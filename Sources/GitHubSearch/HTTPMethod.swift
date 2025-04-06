// HTTPリクエストで使用されるメソッドを表す列挙型
// RawValueとして実際のHTTPメソッド名（文字列）を持つ
public enum HTTPMethod: String {

    // データ取得（読み取り）
    case get = "GET"

    // データ送信（新規作成）
    case post = "POST"

    // データ更新（全体置換）
    case put = "PUT"

    // レスポンスヘッダのみ取得（ボディなし）
    case head = "HEAD"

    // データ削除
    case delete = "DELETE"

    // データ部分更新（差分適用）
    case patch = "PATCH"

    // 通信経路確認用（あまり使われない）
    case trace = "TRACE"

    // オプション情報の取得（サーバー対応確認）
    case options = "OPTIONS"

    // プロキシなどで使用される接続確立用
    case connect = "CONNECT"
}
