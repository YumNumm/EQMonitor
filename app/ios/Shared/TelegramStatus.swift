//
//  TelegramStatus.swift
//  Widget
//
//  電文のステータス
//  Dart定義: packages/eqapi_types/lib/src/model/v2/enum/telegram_status.dart
//

import Foundation
import EQMonitorAPI

/// 電文のステータス
enum TelegramStatus: String, Codable {
    case normal = "NORMAL"
    case training = "TRAINING"
    case test = "TEST"

    /// 通常の電文かどうか
    var isNormal: Bool {
        return self == .normal
    }

    /// 表示用文字列
    var displayString: String {
        switch self {
        case .normal:
            return ""
        case .training:
            return "訓練"
        case .test:
            return "テスト"
        }
    }

    /// バッジテキスト（テスト・訓練の場合のみ）
    var badgeText: String? {
        switch self {
        case .normal:
            return nil
        case .training:
            return "訓練"
        case .test:
            return "テスト"
        }
    }

    // MARK: - Conversion from Generated TelegramStatus

    /// 生成された TelegramStatus 列挙型からの変換
    init(from generated: Components.Schemas.TelegramStatus) {
        switch generated {
        case .NORMAL: self = .normal
        case .TRAINING: self = .training
        case .TEST: self = .test
        }
    }
}
