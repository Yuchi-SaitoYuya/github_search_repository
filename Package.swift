// swift-tools-version:5.9

// Swift Package Manager 用の定義を使うためのインポート
import PackageDescription

// パッケージ全体の定義
let package = Package(
    // パッケージ名（通常はルートディレクトリと同じ名前）
    name: "github_search_repository",

    // 追加：プロダクトの定義（executable を明示）
    products: [
        .executable(
            name: "github_search_repository",
            targets: ["github_search_repository"]
        )
    ],

    // ビルド対象（ターゲット）の配列
    targets: [
        // ライブラリターゲット: GitHub検索のロジックやモデルなどを含む
        .target(
            name: "GitHubSearch"
        ),

        // テストターゲット: GitHubSearchモジュールのユニットテスト
        .testTarget(
            name: "GitHubSearchTests",
            dependencies: ["GitHubSearch"]
        ),

        // 実行ターゲット: アプリのエントリーポイント（CLIやUI処理など）
        .executableTarget( // ← .target ではなく .executableTarget に変更
            name: "github_search_repository",
            dependencies: ["GitHubSearch"]
        ),
    ]
)
