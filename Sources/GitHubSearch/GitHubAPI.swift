// GitHub APIの各リクエストをまとめる名前空間クラス（インスタンス化不要）
public final class GitHubAPI {

    // MARK: - リポジトリ検索APIリクエスト定義

    // 検索キーワードに基づいてリポジトリを検索するリクエスト
    public struct SearchRepositories: GitHubRequest {
        // 検索クエリ（例: "swift"）
        public let keyword: String

        // レスポンス型（SearchResponse<Repository>）
        public typealias Response = SearchResponse<Repository>

        // HTTPメソッドはGET
        public var method: HTTPMethod {
            return .get
        }

        // APIのパス（ベースURL + これ）
        public var path: String {
            return "/search/repositories"
        }

        // クエリ文字列（?q=swift）
        public var queryItems: [URLQueryItem] {
            return [
                URLQueryItem(name: "q", value: keyword)
            ]
        }
    }

    // MARK: - ユーザー検索APIリクエスト定義

    // 検索キーワードに基づいてユーザーを検索するリクエスト
    public struct SearchUsers: GitHubRequest {
        // 検索クエリ（例: "apple"）
        public let keyword: String

        // レスポンス型（SearchResponse<User>）
        public typealias Response = SearchResponse<User>

        // HTTPメソッドはGET
        public var method: HTTPMethod {
            return .get
        }

        // APIのパス（ベースURL + これ）
        public var path: String {
            return "/search/users"
        }

        // クエリ文字列（?q=apple）
        public var queryItems: [URLQueryItem] {
            return [
                URLQueryItem(name: "q", value: keyword)
            ]
        }
    }
}
