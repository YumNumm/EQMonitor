//
//  JmaCodeTable.swift
//  AppIntentExtension
//
//  地域選択パラメータ用の JMA コードテーブル。
//  app/assets/parameters/jma_code_table.json（Flutter と同一ファイルへの
//  参照を拡張バンドルに同梱）から都道府県・市区町村を読み込む。
//

import Foundation

struct JmaCodeTable {
    struct JmaArea: Hashable {
        enum Kind: String {
            case prefecture
            case city
        }

        let code: String
        let nameJa: String
        let kind: Kind
    }

    let prefectures: [JmaArea]
    let cities: [JmaArea]

    static let shared: JmaCodeTable = load()

    private static func load() -> JmaCodeTable {
        struct Root: Decodable {
            let codeTables: Tables

            enum CodingKeys: String, CodingKey {
                case codeTables = "code_tables"
            }
        }
        struct Tables: Decodable {
            let prefectures: [Entry]
            let cities: [Entry]

            enum CodingKeys: String, CodingKey {
                case prefectures = "area_information_prefecture_earthquake"
                case cities = "area_information_city"
            }
        }
        struct Entry: Decodable {
            let code: String
            let name: Name

            struct Name: Decodable {
                let ja: String
            }
        }

        guard let url = Bundle.main.url(forResource: "jma_code_table", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let root = try? JSONDecoder().decode(Root.self, from: data)
        else {
            return JmaCodeTable(prefectures: [], cities: [])
        }
        return JmaCodeTable(
            prefectures: root.codeTables.prefectures
                .map { JmaArea(code: $0.code, nameJa: $0.name.ja, kind: .prefecture) },
            cities: root.codeTables.cities
                .map { JmaArea(code: $0.code, nameJa: $0.name.ja, kind: .city) }
        )
    }
}
