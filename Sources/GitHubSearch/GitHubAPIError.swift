// GitHub APIのエラーレスポンスを表す構造体
public struct GitHubAPIError: Decodable, Error {

    // ネストされた個別エラーの構造体（配列で返される）
    public struct Error: Decodable {
        // 対象のリソース（例: "Repository", "User" など）
        public var resource: String

        // 問題があるフィールド名（例: "name", "email"）
        public var field: String

        // エラーコード（例: "missing", "invalid", "already_exists"）
        public var code: String
    }

    // メインメッセージ（例: "Validation Failed"）
    public var message: String

    // 詳細なエラー情報（複数件ある可能性がある）
    public var errors: [Error]
}

