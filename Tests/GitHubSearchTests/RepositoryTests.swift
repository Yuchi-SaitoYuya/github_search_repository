// Foundationの標準機能（Data, JSONDecoder など）を使用
import Foundation

// XCTestフレームワークの読み込み（ユニットテストのため）
import XCTest

// テスト対象モジュールの読み込み
import GitHubSearch

// Repository構造体のユニットテストクラス
class RepositoryTests: XCTestCase {

    // JSONデコードテストメソッド
    func testDecode() throws {
        // JSONDecoder を初期化（デフォルト設定）
        let jsonDecoder = JSONDecoder()

        // RepositoryのサンプルJSON文字列をDataに変換
        let data = Repository.exampleJSON.data(using: .utf8)!

        // JSONデータを Repository 型へデコード（Decodableに準拠）
        let repository = try jsonDecoder.decode(Repository.self, from: data)

        // 各プロパティが期待どおりか検証
        XCTAssertEqual(repository.id, 44838949)                  // リポジトリID
        XCTAssertEqual(repository.name, "swift")                 // リポジトリ名
        XCTAssertEqual(repository.fullName, "apple/swift")       // フルネーム
        XCTAssertEqual(repository.owner.id, 10639145)            // 所有者のID
    }
}
