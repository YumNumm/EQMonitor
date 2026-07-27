//
//  BackgroundDownloadHandler.swift
//  AssetDownloader
//
//  Created by ryotaro.onoue on 2026/07/28.
//

import BackgroundAssets
import ExtensionFoundation
import StoreKit

@main
struct DownloaderExtension: StoreDownloaderExtension {
    func shouldDownload(_ assetPack: AssetPack) -> Bool {
        return true
    }
}
