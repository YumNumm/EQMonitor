import AVFoundation
import Foundation

final class NotificationSoundImporter {
  static let maxDurationMs = 29_900
  static let sampleRate = 44_100.0
  private let store: NotificationSoundStore

  init(store: NotificationSoundStore) { self.store = store }

  func inspect(sourcePath: String) throws -> [String: Any] {
    let file = try open(sourcePath)
    let duration = Double(file.length) / file.processingFormat.sampleRate
    guard duration.isFinite, duration > 0, duration * 1_000 < Double(Int.max) else {
      throw NotificationSoundFailure("invalidAudio")
    }
    return ["durationMs": max(1, Int(ceil(duration * 1_000)))]
  }

  func prepare(sourcePath: String, trimToMaxDuration: Bool) throws -> [String: Any] {
    let source = try open(sourcePath)
    let duration = Double(source.length) / source.processingFormat.sampleRate
    guard duration <= Double(Self.maxDurationMs) / 1_000 || trimToMaxDuration else {
      throw NotificationSoundFailure("durationTooLong")
    }
    let id = UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased()
    let url = try store.preparedURL(id: id)
    do {
      // Even matching WAV files are decoded, so a corrupt tail is not silently copied.
      try convert(source: source, destination: url)
      try store.protect(url)
      return ["id": id, "durationMs": try validate(url)]
    } catch {
      try? store.discard(id: id)
      throw error
    }
  }

  func validate(_ url: URL) throws -> Int {
    let file = try AVAudioFile(forReading: url)
    let format = file.fileFormat
    let limit = AVAudioFramePosition(Self.sampleRate * Double(Self.maxDurationMs) / 1_000)
    guard format.commonFormat == .pcmFormatInt16,
      format.sampleRate == Self.sampleRate, format.channelCount == 1,
      file.length > 0, file.length <= limit,
      (format.settings[AVLinearPCMIsBigEndianKey] as? Bool) != true
    else { throw NotificationSoundFailure("invalidAudio") }
    return max(1, Int(ceil(Double(file.length) / Self.sampleRate * 1_000)))
  }

  private func open(_ sourcePath: String) throws -> AVAudioFile {
    guard FileManager.default.isReadableFile(atPath: sourcePath) else {
      throw NotificationSoundFailure("sourceUnavailable")
    }
    let file: AVAudioFile
    do { file = try AVAudioFile(forReading: URL(fileURLWithPath: sourcePath)) }
    catch { throw NotificationSoundFailure("unsupportedFormat") }
    guard file.length > 0, file.processingFormat.sampleRate.isFinite,
      file.processingFormat.sampleRate > 0, file.processingFormat.channelCount > 0,
      let buffer = AVAudioPCMBuffer(pcmFormat: file.processingFormat, frameCapacity: 4_096)
    else { throw NotificationSoundFailure("invalidAudio") }
    do { try file.read(into: buffer) }
    catch { throw NotificationSoundFailure("invalidAudio") }
    guard buffer.frameLength > 0 else { throw NotificationSoundFailure("invalidAudio") }
    file.framePosition = 0
    return file
  }

  private func convert(source: AVAudioFile, destination: URL) throws {
    guard let format = AVAudioFormat(
      commonFormat: .pcmFormatFloat32, sampleRate: Self.sampleRate,
      channels: 1, interleaved: false
    ), let converter = AVAudioConverter(from: source.processingFormat, to: format),
      let input = AVAudioPCMBuffer(pcmFormat: source.processingFormat, frameCapacity: 4_096),
      let output = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: 4_096)
    else { throw NotificationSoundFailure("unsupportedFormat") }
    let settings: [String: Any] = [
      AVFormatIDKey: kAudioFormatLinearPCM, AVSampleRateKey: Self.sampleRate,
      AVNumberOfChannelsKey: 1, AVLinearPCMBitDepthKey: 16,
      AVLinearPCMIsFloatKey: false, AVLinearPCMIsBigEndianKey: false,
      AVLinearPCMIsNonInterleaved: false,
    ]
    let destinationFile = try AVAudioFile(
      forWriting: destination, settings: settings,
      commonFormat: .pcmFormatFloat32, interleaved: false
    )
    let limit = AVAudioFramePosition(Self.sampleRate * Double(Self.maxDurationMs) / 1_000)
    var written: AVAudioFramePosition = 0
    var ended = false
    while written < limit, !ended {
      var conversionError: NSError?
      var readError: Error?
      let status = converter.convert(to: output, error: &conversionError) { requested, inputStatus in
        do {
          let count = min(input.frameCapacity, max(1, requested))
          try source.read(into: input, frameCount: count)
          inputStatus.pointee = input.frameLength == 0 ? .endOfStream : .haveData
          return input.frameLength == 0 ? nil : input
        } catch {
          readError = error
          inputStatus.pointee = .endOfStream
          return nil
        }
      }
      if readError != nil || conversionError != nil || status == .error {
        throw NotificationSoundFailure("invalidAudio")
      }
      output.frameLength = min(output.frameLength, AVAudioFrameCount(limit - written))
      if output.frameLength > 0 {
        try destinationFile.write(from: output)
        written += AVAudioFramePosition(output.frameLength)
      }
      ended = status == .endOfStream
      if output.frameLength == 0 && !ended {
        throw NotificationSoundFailure("invalidAudio")
      }
    }
    guard written > 0 else { throw NotificationSoundFailure("invalidAudio") }
  }
}
