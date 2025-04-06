import Foundation

// GitHub API を実行する汎用クライアントクラス
public class GitHubClient {

    // 通信処理を担当する HTTPClient（依存性注入）
    private let httpClient: HTTPClient

    // イニシャライザでHTTPClientを外部から注入
    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    // 汎用的なリクエスト送信メソッド
    public func send<Request: GitHubRequest>(
        request: Request,
        completion: @escaping (Result<Request.Response, GitHubClientError>) -> Void
    ) {
        do {
            // URLRequest を構築（GitHubRequestから自動生成）
            let urlRequest = try request.buildURLRequest()

            // HTTP通信を実行
            httpClient.sendRequest(urlRequest) { result in
                switch result {
                case .success(let (data, urlResponse)):
                    do {
                        // レスポンスのパース
                        let response = try request.response(from: data, urlResponse: urlResponse)
                        completion(.success(response))
                    } catch let error as GitHubAPIError {
                        // GitHub API のエラーレスポンスを処理
                        completion(.failure(.apiError(error))) // ← 修正ポイント
                    } catch {
                        // その他のJSONパース失敗
                        completion(.failure(.responseParseError(error)))
                    }

                case .failure(let error):
                    // 通信エラー
                    completion(.failure(.connectionError(error)))
                }
            }
        } catch {
            // URLRequestの構築に失敗した場合
            completion(.failure(.responseParseError(error)))
        }
    }
}
