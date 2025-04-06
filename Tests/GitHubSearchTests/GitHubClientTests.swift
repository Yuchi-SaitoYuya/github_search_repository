import Foundation
import XCTest
import GitHubSearch // GitHubClient や API定義、StubHTTPClient を使用するため

// GitHubClient の単体テストを行うクラス
class GitHubClientTests: XCTestCase {

    // モック通信クライアント（本物の通信は行わない）
    var httpClient: StubHTTPClient = StubHTTPClient()

    // テスト対象の GitHubClient（HTTPClient を注入）
    var gitHubClient: GitHubClient!

    // 各テスト実行前に呼ばれる初期化処理
    override func setUp() {
        super.setUp()
        gitHubClient = GitHubClient(httpClient: httpClient)
    }

    // 指定したステータスコードとJSON文字列から、StubHTTPClient に設定する結果を生成
    private func makeHTTPClientResult(statusCode: Int, json: String) -> Result<(Data, HTTPURLResponse), Error> {
        return .success((
            json.data(using: .utf8)!, // JSON文字列 → Data変換
            HTTPURLResponse(
                url: URL(string: "https://api.github.com/search/repositories")!, // ダミーURL
                statusCode: statusCode, // 成功 or エラーを指定可能
                httpVersion: nil,
                headerFields: nil)!
        ))
    }

    // 正常なリポジトリ検索レスポンスを受け取れるかテスト
    func testSuccess() {
        // Stub に成功レスポンスを設定（例: 200 OK + サンプルJSON）
        httpClient.result = makeHTTPClientResult(
            statusCode: 200,
            json: GitHubAPI.SearchRepositories.Response.exampleJSON
        )

        // 検索リクエストを作成
        let request = GitHubAPI.SearchRepositories(keyword: "swift")

        // 非同期処理の完了を待つための XCTestExpectation を用意
        let apiExpectation = expectation(description: "")

        // リクエストを送信
        gitHubClient.send(request: request) { result in
            switch result {
            case .success(let response):
                // ✅ 最初のリポジトリの fullName が期待通りか検証
                let repository = response.items.first
                XCTAssertEqual(repository?.fullName, "apple/swift")

            default:
                // ❌ 成功以外のケースは失敗とみなす
                XCTFail("unexpected result: \(result)")
            }

            // 非同期完了を通知
            apiExpectation.fulfill()
        }

        // タイムアウト（3秒）を設定して待機
        wait(for: [apiExpectation], timeout: 3)
    }
}
