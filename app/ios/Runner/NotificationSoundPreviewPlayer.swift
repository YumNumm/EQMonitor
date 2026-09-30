import AVFoundation
import UIKit

final class NotificationSoundPreviewPlayer: NSObject, AVAudioPlayerDelegate {
  private var player: AVAudioPlayer?

  override init() {
    super.init()
    NotificationCenter.default.addObserver(
      self, selector: #selector(stop), name: UIApplication.didEnterBackgroundNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self, selector: #selector(stop), name: AVAudioSession.interruptionNotification,
      object: nil
    )
  }

  deinit { NotificationCenter.default.removeObserver(self) }

  func preview(_ url: URL) throws {
    stop()
    do {
      let session = AVAudioSession.sharedInstance()
      try session.setCategory(.playback, mode: .default, options: [.mixWithOthers])
      try session.setActive(true)
      let audio = try AVAudioPlayer(contentsOf: url)
      audio.delegate = self
      guard audio.prepareToPlay(), audio.play() else {
        throw NotificationSoundFailure("invalidAudio")
      }
      player = audio
    } catch {
      stop()
      throw error
    }
  }

  @objc func stop() {
    player?.stop()
    player = nil
    try? AVAudioSession.sharedInstance().setActive(false, options: [.notifyOthersOnDeactivation])
  }

  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) { stop() }
  func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) { stop() }
}
