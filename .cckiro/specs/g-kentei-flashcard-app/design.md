# G検定一問一答アプリ 設計書

## アプリ全体アーキテクチャ

### MVVM + SwiftUI アーキテクチャ
- **Model**: Core Data + JSON データモデル
- **View**: SwiftUI による宣言的UI
- **ViewModel**: ObservableObject によるビジネスロジック

### プロジェクト構成
```
GKenteiFlashcard/
├── Models/
│   ├── Question.swift
│   ├── QuestionCategory.swift
│   ├── StudyRecord.swift
│   └── CoreData/
├── ViewModels/
│   ├── QuizViewModel.swift
│   ├── StatsViewModel.swift
│   └── SettingsViewModel.swift
├── Views/
│   ├── ContentView.swift
│   ├── QuizView.swift
│   ├── ResultView.swift
│   ├── StatsView.swift
│   └── SettingsView.swift
├── Services/
│   ├── QuestionService.swift
│   ├── CoreDataService.swift
│   └── AdService.swift
├── Resources/
│   └── questions.json
└── Utils/
    └── Extensions.swift
```

## データモデル設計

### 1. Question（問題データ）
```swift
struct Question: Codable, Identifiable {
    let id: Int
    let category: QuestionCategory
    let questionText: String
    let choices: [String]  // 4択の選択肢
    let correctAnswer: Int // 正解のインデックス (0-3)
    let explanation: String
    let difficulty: Difficulty
}

enum QuestionCategory: String, CaseIterable, Codable {
    case aiDefinition = "人工知能の定義と動向"
    case machineLearningOverview = "機械学習の概要"
    case deepLearningTechnology = "ディープラーニングの要素技術"
    case aiSocialImplementation = "AIの社会実装"
    case mathStatistics = "数理・統計知識"
    case aiLawEthics = "AI関連法律・倫理"
    case aiGovernance = "AIガバナンス"
}

enum Difficulty: String, Codable {
    case easy = "基礎"
    case medium = "標準"
    case hard = "応用"
}
```

### 2. StudyRecord（学習記録）- Core Data
```swift
@Entity StudyRecord {
    @Attribute var questionId: Int
    @Attribute var isCorrect: Bool
    @Attribute var answeredAt: Date
    @Attribute var selectedAnswer: Int
    @Attribute var studyMode: String
}
```

### 3. UserPreferences（ユーザー設定）- Core Data
```swift
@Entity UserPreferences {
    @Attribute var dailyGoal: Int
    @Attribute var isDarkMode: Bool
    @Attribute var isAdFree: Bool
    @Attribute var reviewRequestCount: Int
    @Attribute var lastReviewRequestDate: Date?
    @Attribute var interstitialAdCount: Int
    @Attribute var lastInterstitialDate: Date?
}
```

## 画面設計

### 1. メイン画面（ContentView）
```
┌─────────────────────┐
│    G検定 Flashcard   │
├─────────────────────┤
│                     │
│   学習モード選択      │
│   ┌─────────────┐   │
│   │   通常モード   │   │
│   └─────────────┘   │
│   ┌─────────────┐   │
│   │ ランダムモード  │   │
│   └─────────────┘   │
│   ┌─────────────┐   │
│   │   復習モード   │   │
│   └─────────────┘   │
│                     │
│   学習統計           │
│   正答率: 75%        │
│   学習日数: 7日      │
│                     │
│   ┌─────┐ ┌─────┐ │
│   │統計  │ │設定  │ │
│   └─────┘ └─────┘ │
├─────────────────────┤
│    [バナー広告]      │
└─────────────────────┘
```

### 2. クイズ画面（QuizView）
```
┌─────────────────────┐
│  問題 5/100  通常モード│
├─────────────────────┤
│                     │
│ 機械学習において、    │
│ 教師なし学習の代表的  │
│ な手法はどれか？      │
│                     │
│  A) 線形回帰         │
│  B) クラスタリング    │
│  C) サポートベクター   │
│  D) 決定木           │
│                     │
│                     │
│    ┌─────────┐      │
│    │   回答   │      │
│    └─────────┘      │
├─────────────────────┤
│    [バナー広告]      │
└─────────────────────┘
```

### 3. 結果画面（ResultView）
```
┌─────────────────────┐
│       結果画面       │
├─────────────────────┤
│        ✓ 正解       │
│                     │
│ 正解: B) クラスタリング│
│                     │
│ 解説:               │
│ クラスタリングは教師  │
│ なし学習の代表的な    │
│ 手法で、データを...   │
│                     │
│  ┌─────┐ ┌─────┐   │
│  │次の問題│ │解説詳細│   │
│  └─────┘ └─────┘   │
├─────────────────────┤
│    [バナー広告]      │
└─────────────────────┘
```

### 4. 統計画面（StatsView）
```
┌─────────────────────┐
│       学習統計       │
├─────────────────────┤
│                     │
│ 総合正答率: 75%      │
│ 学習継続: 7日        │
│ 解答済み: 45/100問   │
│                     │
│ カテゴリ別正答率      │
│ ┌─────────────────┐ │
│ │人工知能基礎  80% │ │
│ │機械学習手法  70% │ │
│ │DL概要       65% │ │
│ │DL手法       60% │ │
│ │社会実装     85% │ │
│ └─────────────────┘ │
│                     │
│ 学習履歴             │
│ [カレンダー表示]      │
├─────────────────────┤
│    [バナー広告]      │
└─────────────────────┘
```

## 学習モード設計

### 1. 通常モード
- 問題を1番から順番に出題
- 進捗状況をUserDefaultsに保存
- 途中で中断しても続きから再開可能

### 2. ランダムモード  
- 未回答の問題からランダム選択
- 同じ問題は2回出題されない（1セッション内）
- シャッフルアルゴリズムでバランス良く出題

### 3. 復習モード
- 過去に間違えた問題のみを出題
- Core Dataから不正解記録を取得
- 正解した問題は復習対象から除外

## 広告実装設計

### 1. AdService クラス
```swift
class AdService: NSObject, ObservableObject {
    @Published var isBannerLoaded = false
    @Published var isInterstitialReady = false
    
    private var bannerView: GADBannerView?
    private var interstitialAd: GADInterstitialAd?
    private var interstitialCount = 0
    private var lastInterstitialDate: Date?
    
    func loadBannerAd()
    func loadInterstitialAd()
    func showInterstitial() -> Bool  // 制限チェック付き
    func canShowInterstitial() -> Bool  // 1日3回制限
}
```

### 2. 広告表示タイミング
- **バナー**: アプリ起動時に読み込み、全画面下部に表示
- **インタースティシャル**: 
  - 10問完了後
  - 学習セッション終了時
  - 1日3回まで制限
  - 前回表示から30分以上経過

## レビューリクエスト設計

### ReviewManager クラス
```swift
class ReviewManager {
    static func requestReviewIfAppropriate() {
        // 条件チェック:
        // - 学習継続7日以上
        // - 50問以上正解
        // - 前回リクエストから30日以上経過
        
        if shouldRequestReview() {
            SKStoreReviewController.requestReview()
        }
    }
}
```

## データ永続化設計

### 1. Core Data Stack
- 学習記録（StudyRecord）
- ユーザー設定（UserPreferences）
- 軽量マイグレーション対応

### 2. JSON データ
- 問題データは questions.json として Bundle に含める
- 起動時にメモリに読み込み
- 構造化データで高速アクセス

## パフォーマンス最適化

### 1. メモリ管理
- 問題データの遅延読み込み
- 画像リソースの最適化
- Core Data のバッチ処理

### 2. UI応答性
- 非同期データ読み込み
- アニメーション最適化
- レンダリング負荷軽減

この設計で実装を進める準備ができていますが、何か修正点や質問はありますか？