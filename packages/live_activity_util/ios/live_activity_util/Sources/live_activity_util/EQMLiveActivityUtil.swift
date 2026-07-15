import ActivityKit
import Foundation

// MARK: - LiveActivityUtil

#if os(iOS)
  @available(iOS 16.1, *)
  @objc(EQMLiveActivityUtil)
  @objcMembers public class EQMLiveActivityUtil: NSObject {
    @nonobjc private var pushToStartTokenObservationTask: Task<Void, Never>?

    @available(iOS 17.2, *)
    public func pushToStartToken() -> String? {
      let data = Activity<MockLiveActivityAttributes>.pushToStartToken
      if let data = data {
        let token = data.map { String(format: "%02x", $0) }.joined()
        return token
      } else {
        return nil
      }
    }

    @available(iOS 17.2, *)
    public func observePushToStartTokenUpdates(
      _ onUpdate: @escaping @Sendable @convention(block) (NSString) -> Void
    ) {
      stopObservingPushToStartTokenUpdates()
      pushToStartTokenObservationTask = Task {
        for await tokenData in Activity<MockLiveActivityAttributes>.pushToStartTokenUpdates {
          guard !Task.isCancelled else {
            break
          }
          let token = tokenData.map { String(format: "%02x", $0) }.joined()
          onUpdate(token as NSString)
        }
      }
    }

    @objc public func stopObservingPushToStartTokenUpdates() {
      pushToStartTokenObservationTask?.cancel()
      pushToStartTokenObservationTask = nil
    }

    /// EEW Live Activity の push update token 更新を監視する。
    /// ActivityKit はモジュール名なしの型名でアクティビティを識別するため、
    /// Widget Extension の EewLiveActivityAttributes と同じ型名を持つミラー型で監視できる。
    /// callback: (liveActivityId, pushToken)
    public func observeEewActivityPushTokenUpdates(
      _ onUpdate: @escaping @Sendable @convention(block) (NSString, NSString) -> Void
    ) {
      Task {
        for await activity in Activity<EewLiveActivityAttributes>.activityUpdates {
          Task {
            let activityId = activity.attributes.id.uuidString.lowercased()
            for await tokenData in activity.pushTokenUpdates {
              let token = tokenData.map { String(format: "%02x", $0) }.joined()
              onUpdate(activityId as NSString, token as NSString)
            }
          }
        }
      }
    }

    /// 揺れ検知 Live Activity の push update token 更新を監視する。
    /// callback: (liveActivityId, pushToken)
    public func observeShakeDetectionActivityPushTokenUpdates(
      _ onUpdate: @escaping @Sendable @convention(block) (NSString, NSString) -> Void
    ) {
      Task {
        for await activity in Activity<ShakeDetectionLiveActivityAttributes>.activityUpdates {
          Task {
            let activityId = activity.attributes.id.uuidString.lowercased()
            for await tokenData in activity.pushTokenUpdates {
              let token = tokenData.map { String(format: "%02x", $0) }.joined()
              onUpdate(activityId as NSString, token as NSString)
            }
          }
        }
      }
    }

    public func isLiveActivitySupported() -> Bool {
      guard #available(iOS 16.1, *), !ProcessInfo.processInfo.isiOSAppOnMac else {
        return false
      }

      guard #available(iOS 26.1, *), !ProcessInfo.processInfo.isiOSAppOnVision else {
        return false
      }
      return true
    }

    public func isPushToStartSupported() -> Bool {
      if !isLiveActivitySupported() {
        return false
      }
      guard #available(iOS 17.2, *), !ProcessInfo.processInfo.isiOSAppOnMac else {
        return false
      }
      return true
    }
  }

  // MARK: - MockLiveActivityAttributes
  struct MockLiveActivityAttributes: ActivityAttributes, Identifiable {
    public typealias ContentState = MockLiveActivityContentState

    public var id = UUID()
  }

  struct MockLiveActivityContentState: Codable, Hashable {
  }

  // MARK: - EEW Live Activity mirror types
  // ActivityKit はモジュール名なしの型名でアクティビティを識別するため、
  // Widget Extension 側の EewLiveActivityAttributes と同名の型を定義することで
  // 同じアクティビティを監視できる。
  // ContentState のフィールドは監視には不要なため空で定義する。
  struct EewLiveActivityAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {}
    var id = UUID()
    let eventId: String
  }

  // MARK: - ShakeDetection Live Activity mirror types
  struct ShakeDetectionLiveActivityAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {}
    var id = UUID()
    let eventId: String
  }

#endif
