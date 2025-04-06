import Foundation              // Data, JSONDecoder などを使う
import XCTest                 // ユニットテストのための標準フレームワーク
import GitHubSearch           // テスト対象のモジュールをインポート

// GitHubAPIError のデコード検証用テストクラス
class GitHubAPIErrorTests: XCTestCase {

    // サンプルJSONから正しくパースできるか確認するテスト
    func testDecode() throws {
        let jsonDecoder = JSONDecoder()

        // テスト用のサンプルJSONをDataに変換
        let data = GitHubAPIError.exampleJSON.data(using: .utf8)!

        // JSONからGitHubAPIError構造体へデコード
        let error = try jsonDecoder.decode(GitHubAPIError.self, from: data)

        // トップレベルのメッセージが期待通りかチェック
        XCTAssertEqual(error.message, "Validation Failed")

        // errors配列の先頭要素の各フィールドが正しいか検証
        let firstError = error.errors.first
        XCTAssertEqual(firstError?.field, "q")
        XCTAssertEqual(firstError?.code, "missing")
        XCTAssertEqual(firstError?.resource, "Search")
    }
}
