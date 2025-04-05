// 基本ライブラリ（DataやJSONDecoderなどを使用）
import Foundation

// XCTestフレームワーク（ユニットテスト用）
import XCTest

// GitHubSearchモジュールの中身をテスト対象として使用
import GitHubSearch

// User構造体のテストクラス
class UserTests: XCTestCase {

    // JSONデコードのテストメソッド
    func testDecode() throws {
        // JSONDecoderを用意（デフォルト設定）
        let jsonDecoder = JSONDecoder()

        // サンプルJSON文字列をData型に変換（強制アンラップ：失敗しない前提）
        let data = User.exampleJSON.data(using: .utf8)!

        // JSONからUser構造体にデコード（Decodableにより自動変換）
        let user = try jsonDecoder.decode(User.self, from: data)

        // デコード結果の検証（期待値と一致しているか）
        XCTAssertEqual(user.id, 10639145)
        XCTAssertEqual(user.login, "apple")
    }
}
