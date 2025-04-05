// モデル定義を利用するために GitHubSearch モジュールをインポート
import GitHubSearch

// User 型への拡張：テスト用のJSON文字列を提供
extension User {
    // JSON文字列を返す静的プロパティ（テスト用）
    static var exampleJSON: String {
        return """
        {
            "login": "apple",
            "id": 10639145
        }
        """
    }
}

// Repository 型への拡張：テスト用のJSON文字列を提供
extension Repository {
    // JSON文字列を返す静的プロパティ（ネストされた User を含む）
    static var exampleJSON: String {
        return """
        {
            "id": 44838949,
            "name": "swift",
            "full_name": "apple/swift",
            "owner": {
                "login": "apple",
                "id": 10639145
            }
        }
        """
    }
}
