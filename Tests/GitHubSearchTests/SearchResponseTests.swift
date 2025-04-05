// Foundation: DataやJSONDecoderのために必要
import Foundation

// XCTest: ユニットテスト用フレームワーク
import XCTest

// GitHubSearch: テスト対象のモジュールを読み込む
import GitHubSearch

// SearchResponse<Repository> に関するテストクラス
class SearchResponseTests: XCTestCase {

    // JSONから正しくデコードされるかを検証するテスト
    func testDecodeRepositories() throws {
        // JSONDecoderを初期化
        let jsonDecoder = JSONDecoder()

        // SearchResponse<Repository> に拡張されたサンプルJSONをDataに変換
        let data = SearchResponse<Repository>.exampleJSON
            .data(using: .utf8)!

        // デコード処理：JSONを SearchResponse<Repository> に変換
        let response = try jsonDecoder.decode(SearchResponse<Repository>.self, from: data)

        // 件数の検証
        XCTAssertEqual(response.totalCount, 141722)
        XCTAssertEqual(response.items.count, 3)

        // 最初のリポジトリのプロパティを検証
        let firstRepository = response.items.first
        XCTAssertEqual(firstRepository?.name, "swift")
        XCTAssertEqual(firstRepository?.fullName, "apple/swift")
    }
}

