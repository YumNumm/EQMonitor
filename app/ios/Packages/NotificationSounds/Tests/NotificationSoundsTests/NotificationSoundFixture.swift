import AVFoundation
import Foundation
import Testing
@testable import NotificationSounds

struct NotificationSoundFixture {
  let root: URL
  let store: NotificationSoundStore
  let importer: NotificationSoundImporter

  init() throws {
    root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
    try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
    store = NotificationSoundStore(rootURL: root)
    importer = NotificationSoundImporter(store: store)
  }

  func remove() { try? FileManager.default.removeItem(at: root) }

  // Construct a known PCM16 RIFF header independently of AVAudioFile's writer.
  func wav(sampleRate: UInt32, channels: UInt16, frames: UInt32) throws -> URL {
    let byteCount = frames * UInt32(channels) * 2
    var data = Data("RIFF".utf8)
    data.appendLittleEndian(UInt32(36) + byteCount)
    data.append(Data("WAVEfmt ".utf8))
    data.appendLittleEndian(UInt32(16))
    data.appendLittleEndian(UInt16(1))
    data.appendLittleEndian(channels)
    data.appendLittleEndian(sampleRate)
    data.appendLittleEndian(sampleRate * UInt32(channels) * 2)
    data.appendLittleEndian(channels * 2)
    data.appendLittleEndian(UInt16(16))
    data.append(Data("data".utf8))
    data.appendLittleEndian(byteCount)
    for frame in 0..<frames {
      let sample = Int16(sin(2 * .pi * 440 * Double(frame) / Double(sampleRate)) * 12_000)
      for _ in 0..<channels { data.appendLittleEndian(sample) }
    }
    let url = root.appendingPathComponent("source.wav")
    try data.write(to: url)
    return url
  }

  func importAndSave(_ source: URL, trim: Bool = false) throws -> AVAudioFile {
    let inspection = try importer.inspect(sourcePath: source.path)
    #expect(try #require(inspection["durationMs"] as? Int) > 0)
    let prepared = try importer.prepare(sourcePath: source.path, trimToMaxDuration: trim)
    let id = try #require(prepared["id"] as? String)
    let duration = try #require(prepared["durationMs"] as? Int)
    #expect(duration > 0 && duration <= 29_900)
    _ = try store.commit(id: id, displayName: "Test tone", durationMs: duration)
    let file = try AVAudioFile(forReading: store.savedURL(id: id))
    #expect(file.fileFormat.sampleRate == 44_100)
    #expect(file.fileFormat.channelCount == 1)
    #expect(file.fileFormat.settings[AVLinearPCMBitDepthKey] as? Int == 16)
    #expect(file.length > 0 && file.length <= 1_318_590)
    let buffer = try #require(AVAudioPCMBuffer(pcmFormat: file.processingFormat, frameCapacity: 4_096))
    try file.read(into: buffer, frameCount: AVAudioFrameCount(min(file.length, 4_096)))
    let samples = try #require(buffer.floatChannelData?[0])
    let peak = (0..<Int(buffer.frameLength)).map { abs(samples[$0]) }.max() ?? 0
    #expect(peak > 0.01, "The saved notification must contain decoded audio, not silence.")
    return file
  }
}

private extension Data {
  mutating func appendLittleEndian<T: FixedWidthInteger>(_ value: T) {
    var value = value.littleEndian
    Swift.withUnsafeBytes(of: &value) { append(contentsOf: $0) }
  }
}
