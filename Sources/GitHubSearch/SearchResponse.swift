// 汎用的な検索レスポンスを表す構造体
// Itemはジェネリックで、Decodableに準拠している必要がある
public struct SearchResponse<Item: Decodable>: Decodable {

    // 検索結果の総件数（GitHub APIでは "total_count"）
    public var totalCount: Int

    // 検索で取得されたアイテムの配列（例: Repository型など）
    public var items: [Item]

    // JSONのキー名とSwiftのプロパティ名のマッピング
    public enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
