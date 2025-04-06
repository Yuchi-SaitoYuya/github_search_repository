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

// Repositoryを対象としたSearchResponseに、サンプルJSON文字列を提供する拡張
extension SearchResponse where Item == Repository {
    // サンプルJSON（GitHubの /search/repositories レスポンスに相当）
    static var exampleJSON: String {
        return """
        {
            "total_count": 141722,
            "items": [
                {
                    "id": 44838949,
                    "name": "swift",
                    "full_name": "apple/swift",
                    "owner": {
                        "id": 10639145,
                        "login": "apple"
                    }
                },
                {
                    "id": 790019,
                    "name": "swift",
                    "full_name": "openstack/swift",
                    "owner": {
                        "id": 324574,
                        "login": "openstack"
                    }
                },
                {
                    "id": 20822291,
                    "name": "SwiftGuide",
                    "full_name": "ipader/SwiftGuide",
                    "owner": {
                        "id": 373016,
                        "login": "ipader"
                    }
                }
            ]
        }
        """
    }
}

// GitHubAPIError にテスト用のサンプルJSON文字列を提供する拡張
extension GitHubAPIError {

    // サンプルエラーレスポンスJSON（GitHubの仕様に準拠）
    static var exampleJSON: String {
        return """
        {
            "message": "Validation Failed",
            "errors": [
                {
                    "resource": "Search",
                    "field": "q",
                    "code": "missing"
                }
            ],
            "documentation_url": "https://developer.github.com/v3/search"
        }
        """
    }
}
