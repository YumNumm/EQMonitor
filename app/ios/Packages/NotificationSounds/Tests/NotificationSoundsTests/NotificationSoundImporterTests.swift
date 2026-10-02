import AVFoundation
import Foundation
import Testing
@testable import NotificationSounds

struct NotificationSoundImporterTests {
  @Test func acceptsKnownNotificationFormat() throws {
    let fixture = try NotificationSoundFixture()
    defer { fixture.remove() }
    let source = try fixture.wav(sampleRate: 44_100, channels: 1, frames: 44_100)
    #expect(try fixture.importer.validate(source) == 1_000)
  }

  @Test(arguments: [UInt32(1_000), 4_096, 4_097])
  func importsShortAndBufferBoundaryWav(frames: UInt32) throws {
    let fixture = try NotificationSoundFixture()
    defer { fixture.remove() }
    let source = try fixture.wav(sampleRate: 44_100, channels: 1, frames: frames)
    let output = try fixture.importAndSave(source)
    #expect(output.length == Int64(frames))
  }

  @Test func resamplesStereoWav() throws {
    let fixture = try NotificationSoundFixture()
    defer { fixture.remove() }
    let source = try fixture.wav(sampleRate: 48_000, channels: 2, frames: 48_000)
    let output = try fixture.importAndSave(source)
    #expect(abs(output.length - 44_100) <= 441)
  }

  @Test func importsActualMp3() throws {
    let fixture = try NotificationSoundFixture()
    defer { fixture.remove() }
    let source = try #require(Bundle.module.url(
      forResource: "tone-48000-stereo", withExtension: "mp3", subdirectory: "Fixtures"
    ))
    let output = try fixture.importAndSave(source)
    #expect(output.length >= 11_025 && output.length <= 17_640)
  }

  @Test func longAudioRequiresConsentAndTrimsToNotificationLimit() throws {
    let fixture = try NotificationSoundFixture()
    defer { fixture.remove() }
    let source = try fixture.wav(sampleRate: 44_100, channels: 1, frames: 1_367_100)
    do {
      _ = try fixture.importer.prepare(sourcePath: source.path, trimToMaxDuration: false)
      Issue.record("A 31-second source must require trim consent.")
    } catch let failure as NotificationSoundFailure {
      #expect(failure.code == "durationTooLong")
    }
    let output = try fixture.importAndSave(source, trim: true)
    #expect(output.length == 1_318_590)
  }

  @Test func invalidAudioPreservesNativeFailure() throws {
    let fixture = try NotificationSoundFixture()
    defer { fixture.remove() }
    let source = fixture.root.appendingPathComponent("invalid.wav")
    try Data("not an audio file".utf8).write(to: source)
    do {
      _ = try fixture.importer.inspect(sourcePath: source.path)
      Issue.record("Non-audio data must not be accepted.")
    } catch let failure as NotificationSoundFailure {
      #expect(failure.code == "unsupportedFormat")
    }
  }
}
