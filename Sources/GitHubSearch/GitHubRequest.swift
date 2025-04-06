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

// GitHubRequestに共通のベースURLを提供する拡張
public extension GitHubRequest {

    // デフォルトのbaseURL（すべてのGitHub API共通）
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
}
