import Foundation

// HTTP通信を抽象化するプロトコル（インターフェース）
public protocol HTTPClient {
    // URLRequest を送信し、結果を completion で非同期に返す
    func sendRequest(
        _ urlRequest: URLRequest,
        completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void
    )
}

// URLSession を HTTPClient プロトコルに準拠させる拡張
extension URLSession: HTTPClient {

    // URLRequest を送信し、結果を非同期で completion クロージャに返す
    public func sendRequest(
        _ urlRequest: URLRequest,
        completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void
    ) {
        // 通信タスクの開始：非同期でネットワークへ接続
        let task = dataTask(with: urlRequest) { data, urlResponse, error in

            // 受け取ったレスポンスの組み合わせをチェック
            switch (data, urlResponse, error) {

            // ❌ エラーがあれば、そのまま失敗として completion に返す
            case (_, _, let error?):
                completion(Result.failure(error))

            // ✅ 正常に data と HTTPURLResponse が得られた場合
            case (let data?, let urlResponse as HTTPURLResponse, _):
                completion(Result.success((data, urlResponse)))

            // ❗️それ以外（不正な組み合わせ）は致命的エラーとしてクラッシュ
            default:
                fatalError("invalid response combination: \(String(describing: (data, urlResponse, error)))")
            }
        }

        // 通信タスクを開始
        task.resume()
    }
}
