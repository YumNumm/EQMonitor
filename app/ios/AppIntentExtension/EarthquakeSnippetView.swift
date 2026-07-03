//
//  EarthquakeSnippetView.swift
//  AppIntentExtension
//
//  地震情報カード。アプリの earthquake_history_list_tile と同じ構造
//  （震度バッジ / 震源名 + 日時・深さ / M値、行背景は最大震度色 alpha 0.4）
//

import SwiftUI
import AppIntents

struct EarthquakeSnippetView: View {
    let title: String
    let items: [EarthquakeDisplayItem]
    let reloadIntent: EarthquakeSnippetIntent

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(AppFonts.flex(size: 15, weight: .bold))
                    .foregroundStyle(DesignTokens.textPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                Spacer()

                if let first = items.first,
                   let url = URL(string: "eqmonitor:///earthquake-history-details/\(first.id)") {
                    Button(intent: OpenURLIntent(url)) {
                        Label("アプリで開く", systemImage: "arrow.up.forward.app")
                            .font(.system(size: 13, weight: .semibold))
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(DesignTokens.brand)
                }

                Button(intent: reloadIntent) {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 13, weight: .semibold))
                }
                .buttonStyle(.plain)
                .foregroundStyle(DesignTokens.brand)
            }

            if items.isEmpty {
                Text("条件に合う地震はありません")
                    .font(AppFonts.flex(size: 13))
                    .foregroundStyle(DesignTokens.textSecondary)
                    .frame(maxWidth: .infinity, minHeight: 56)
            } else {
                VStack(spacing: 6) {
                    ForEach(items) { item in
                        if let url = URL(string: "eqmonitor:///earthquake-history-details/\(item.id)") {
                            Button(intent: OpenURLIntent(url)) {
                                EarthquakeSnippetRow(item: item)
                            }
                            .buttonStyle(.plain)
                        } else {
                            EarthquakeSnippetRow(item: item)
                        }
                    }
                }
            }
        }
        .padding(14)
    }
}

private struct EarthquakeSnippetRow: View {
    let item: EarthquakeDisplayItem

    private var subtitle: String {
        var parts = [item.formattedTime]
        if !item.depth.isEmpty {
            parts.append("深さ\(item.depth)")
        }
        return parts.filter { !$0.isEmpty }.joined(separator: " ")
    }

    var body: some View {
        HStack(spacing: 10) {
            IntensityBadge(
                intensity: item.formattedIntensity,
                backgroundColor: item.intensityBackgroundColor,
                textColor: item.intensityTextColor,
                size: 38
            )

            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 4) {
                    Text(item.hypocenterName)
                        .font(AppFonts.flex(size: 13, weight: .bold))
                        .foregroundStyle(DesignTokens.textPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)

                    if let badge = item.statusBadge {
                        Text(badge)
                            .font(.system(size: 8, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 3)
                            .padding(.vertical, 1)
                            .background(Color.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                    }
                }

                Text(subtitle)
                    .font(AppFonts.code(size: 10))
                    .foregroundStyle(DesignTokens.textSecondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }

            Spacer(minLength: 4)

            Text(item.magnitude)
                .font(AppFonts.code(size: 15, weight: .bold))
                .foregroundStyle(DesignTokens.textPrimary)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .background(
            RoundedRectangle(cornerRadius: DesignTokens.radiusSm, style: .continuous)
                .fill(item.intensityBackgroundColor.opacity(0.4))
        )
    }
}
