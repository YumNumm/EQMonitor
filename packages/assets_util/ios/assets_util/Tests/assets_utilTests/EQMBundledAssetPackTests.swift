import Foundation
import Testing
@testable import assets_util

@Suite struct EQMBundledAssetPackTests {
  @Test func acceptsSafeNestedRelativePaths() {
    let util = EQMAssetsUtil()

    #expect(util.isSafeRelativePath("map/all.pmtiles"))
    #expect(util.isSafeRelativePath("parameters/jma_code_table.json"))
  }

  @Test func rejectsTraversalAndAbsolutePaths() {
    let util = EQMAssetsUtil()

    #expect(!util.isSafeRelativePath("../manifest.json"))
    #expect(!util.isSafeRelativePath("map/../manifest.json"))
    #expect(!util.isSafeRelativePath("/tmp/manifest.json"))
    #expect(!util.isSafeRelativePath("map\\all.pmtiles"))
    #expect(!util.isSafeRelativePath("map//all.pmtiles"))
  }

  @Test func acceptsOnlyOneBundledDirectoryNameSegment() {
    let util = EQMAssetsUtil()

    #expect(util.isSafeDirectoryName("platform"))
    #expect(!util.isSafeDirectoryName(""))
    #expect(!util.isSafeDirectoryName("../platform"))
    #expect(!util.isSafeDirectoryName("."))
  }
}
