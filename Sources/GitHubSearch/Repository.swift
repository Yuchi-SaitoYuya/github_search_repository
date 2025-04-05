// GitHubのリポジトリ情報を表す構造体
public struct Repository {

    // リポジトリの一意なID
    public var id: Int

    // リポジトリ名（例: "swift"）
    public var name: String

    // フルネーム（例: "apple/swift"）
    public var fullName: String

    // 所有者情報（User構造体）
    public var owner: User
}
