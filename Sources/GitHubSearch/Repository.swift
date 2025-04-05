// GitHubのリポジトリ情報を表す構造体
public struct Repository: Decodable {

    // リポジトリの一意なID（数値ID）
    public var id: Int

    // リポジトリ名（例: "swift"）
    public var name: String

    // リポジトリのフルネーム（例: "apple/swift"）
    public var fullName: String

    // 所有者情報（User構造体、ネストされたJSONとして取得）
    public var owner: User

    // JSONキーとSwiftプロパティの対応付け（スネークケース変換対応）
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
    }
}
