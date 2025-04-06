public enum GitHubClientError: Error {
    // 通信に失敗
    case connectionError(Error)

    // JSONの構造エラーなどのデコード失敗
    case responseParseError(Error)

    // GitHubのAPIから返されたエラー（message付き）
    case apiError(GitHubAPIError)

    // ✅ GitHubAPIErrorとしてのデコードに失敗（オプション）
    case decodingError(GitHubAPIError)
}
