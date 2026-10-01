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
      throw NotificationSoundFailure("invalidAudio", stage: "inspect.duration")
    }
    return ["durationMs": max(1, Int(ceil(duration * 1_000)))]
  }

  func prepare(sourcePath: String, trimToMaxDuration: Bool) throws -> [String: Any] {
    let source = try open(sourcePath)
    let duration = Double(source.length) / source.processingFormat.sampleRate
    guard duration <= Double(Self.maxDurationMs) / 1_000 || trimToMaxDuration else {
      throw NotificationSoundFailure("durationTooLong", stage: "prepare.duration")
    }
    let id = UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased()
    let url = try store.preparedURL(id: id)
    do {
      // Even matching WAV files are decoded, so a corrupt tail is not silently copied.
      // On iOS 17, drain autoreleased writers before reopening the WAV header.
      try autoreleasepool { try convert(source: source, destination: url) }
      do { try store.protect(url) }
      catch { throw NotificationSoundFailure(stage: "output.protect", underlyingError: error) }
      return ["id": id, "durationMs": try validate(url)]
    } catch {
      try? store.discard(id: id)
      throw error
    }
  }

  func validate(_ url: URL) throws -> Int {
    let file: AVAudioFile
    do { file = try AVAudioFile(forReading: url) }
    catch { throw NotificationSoundFailure(stage: "output.open", underlyingError: error) }
    let format = file.fileFormat
    let limit = AVAudioFramePosition(Self.sampleRate * Double(Self.maxDurationMs) / 1_000)
    guard format.commonFormat == .pcmFormatInt16,
      format.sampleRate == Self.sampleRate, format.channelCount == 1,
      file.length > 0, file.length <= limit,
      (format.settings[AVLinearPCMIsBigEndianKey] as? Bool) != true
    else { throw NotificationSoundFailure("conversionFailed", stage: "output.validate") }
    return max(1, Int(ceil(Double(file.length) / Self.sampleRate * 1_000)))
  }

  private func open(_ sourcePath: String) throws -> AVAudioFile {
    guard FileManager.default.isReadableFile(atPath: sourcePath) else {
      throw NotificationSoundFailure("sourceUnavailable", stage: "source.access")
    }
    let file: AVAudioFile
    do { file = try AVAudioFile(forReading: URL(fileURLWithPath: sourcePath)) }
    catch {
      throw NotificationSoundFailure("unsupportedFormat", stage: "source.open", underlyingError: error)
    }
    guard file.length > 0, file.processingFormat.sampleRate.isFinite,
      file.processingFormat.sampleRate > 0, file.processingFormat.channelCount > 0,
      let buffer = AVAudioPCMBuffer(pcmFormat: file.processingFormat, frameCapacity: 4_096)
    else { throw NotificationSoundFailure("invalidAudio", stage: "source.format") }
    do {
      try file.read(
        into: buffer,
        frameCount: AVAudioFrameCount(min(AVAudioFramePosition(buffer.frameCapacity), file.length))
      )
    }
    catch { throw NotificationSoundFailure("invalidAudio", stage: "source.read", underlyingError: error) }
    guard buffer.frameLength > 0 else {
      throw NotificationSoundFailure("invalidAudio", stage: "source.empty")
    }
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
    else { throw NotificationSoundFailure("unsupportedFormat", stage: "convert.setup") }
    let settings: [String: Any] = [
      AVFormatIDKey: kAudioFormatLinearPCM, AVSampleRateKey: Self.sampleRate,
      AVNumberOfChannelsKey: 1, AVLinearPCMBitDepthKey: 16,
      AVLinearPCMIsFloatKey: false, AVLinearPCMIsBigEndianKey: false,
      AVLinearPCMIsNonInterleaved: false,
    ]
    let destinationFile: AVAudioFile
    do {
      destinationFile = try AVAudioFile(
        forWriting: destination, settings: settings,
        commonFormat: .pcmFormatFloat32, interleaved: false
      )
    } catch { throw NotificationSoundFailure(stage: "output.create", underlyingError: error) }
    defer {
      // Finalize the WAV header before prepare() validates the output.
      if #available(iOS 18.0, *) { destinationFile.close() }
    }
    let limit = AVAudioFramePosition(Self.sampleRate * Double(Self.maxDurationMs) / 1_000)
    var written: AVAudioFramePosition = 0
    var ended = false
    while written < limit, !ended {
      var conversionError: NSError?
      var readError: Error?
      let status = converter.convert(to: output, error: &conversionError) { requested, inputStatus in
        // EOF is normal: do not ask AVAudioFile to read past its last frame.
        let remaining = source.length - source.framePosition
        guard remaining > 0 else {
          inputStatus.pointee = .endOfStream
          return nil
        }
        do {
          let count = AVAudioFrameCount(min(
            AVAudioFramePosition(min(input.frameCapacity, max(1, requested))), remaining
          ))
          try source.read(into: input, frameCount: count)
          guard input.frameLength > 0 else {
            throw NotificationSoundFailure("invalidAudio", stage: "convert.emptyInput")
          }
          inputStatus.pointee = .haveData
          return input
        } catch {
          readError = error
          inputStatus.pointee = .endOfStream
          return nil
        }
      }
      if let readError {
        if let failure = readError as? NotificationSoundFailure { throw failure }
        throw NotificationSoundFailure("invalidAudio", stage: "convert.read", underlyingError: readError)
      }
      if conversionError != nil || status == .error {
        throw NotificationSoundFailure(
          "conversionFailed", stage: "convert.process", underlyingError: conversionError
        )
      }
      output.frameLength = min(output.frameLength, AVAudioFrameCount(limit - written))
      if output.frameLength > 0 {
        do { try destinationFile.write(from: output) }
        catch { throw NotificationSoundFailure(stage: "output.write", underlyingError: error) }
        written += AVAudioFramePosition(output.frameLength)
      }
      ended = status == .endOfStream
      if output.frameLength == 0 && !ended {
        throw NotificationSoundFailure("conversionFailed", stage: "convert.noProgress")
      }
    }
    guard written > 0 else {
      throw NotificationSoundFailure("conversionFailed", stage: "convert.emptyOutput")
    }
  }
}
