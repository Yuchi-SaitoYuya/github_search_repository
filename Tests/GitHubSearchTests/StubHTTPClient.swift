import Foundation
@testable import GitHubSearch

// スタブ用の HTTPClient 実装（テストやデバッグで使用）
class StubHTTPClient: HTTPClient {

    // 返したい結果（成功 or 失敗）を事前にセット可能
    var result: Result<(Data, HTTPURLResponse), Error> = .success((
        Data(), // 空のData（任意のデータに差し替え可）
        HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200, // 成功ステータス
            httpVersion: nil,
            headerFields: nil)!
    ))

    // HTTPClient プロトコルの実装：completion に result を返すだけ
    func sendRequest(
        _ request: URLRequest,
        completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void
    ) {
        // 0.1秒後に result を返す（非同期風に見せるため）
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
            completion(self.result)
        }
    }
}
