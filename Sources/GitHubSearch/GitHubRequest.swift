import Foundation

// GitHub APIの各種リクエストが準拠すべき共通プロトコル
public protocol GitHubRequest {

    // レスポンス型を関連型として定義（JSONデコード対象）
    associatedtype Response: Decodable

    // APIのベースURL（デフォルトは https://api.github.com）
    var baseURL: URL { get }

    // APIのパス（例: "/search/repositories"）
    var path: String { get }

    // 使用するHTTPメソッド（GET, POSTなど）
    var method: HTTPMethod { get }

    // クエリパラメータ一覧（?q=swift&page=1 など）
    var queryItems: [URLQueryItem] { get }
}

// GitHubRequest に共通の処理（ベースURL、URLRequest生成、レスポンスパース）を提供する拡張
public extension GitHubRequest {

    // ✅ 共通のベースURL（GitHubの全APIで使用される）
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }

    // ✅ URLRequest を構築する共通処理
    func buildURLRequest() throws -> URLRequest {
        // baseURL + path を結合してURLを作成（例: https://api.github.com/search/repositories）
        let url = baseURL.appendingPathComponent(path)

        // URLComponents を使ってクエリパラメータを組み立てる
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)

        // メソッドが GET の場合のみ、クエリパラメータをURLに含める
        switch method {
        case .get:
            components?.queryItems = queryItems
        default:
            // 他のHTTPメソッドには未対応（今後の拡張対象）
            fatalError("Unsupported method \(method)")
        }

        // URLRequest を作成し、URLとHTTPメソッドをセット
        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }

    // ✅ レスポンスデータから Response 型へ変換する共通処理
    func response(from data: Data, urlResponse: HTTPURLResponse) throws -> Response {
        let decoder = JSONDecoder()

        // ステータスコードが 2xx のとき → 正常なレスポンスとしてパース
        if (200..<300).contains(urlResponse.statusCode) {
            return try decoder.decode(Response.self, from: data)
        } else {
            // それ以外（4xx, 5xx）は GitHubAPIError としてパースして throw
            throw try decoder.decode(GitHubAPIError.self, from: data)
        }
    }
}
