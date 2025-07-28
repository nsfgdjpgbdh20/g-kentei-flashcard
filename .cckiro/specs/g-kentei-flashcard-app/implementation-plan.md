# G検定一問一答アプリ 実装計画書

## 実装フェーズ分割

### Phase 1: 基盤実装（MVP）
**期間**: 1-2週間
**目標**: 基本的な一問一答機能の実装

#### 1.1 プロジェクトセットアップ
- [ ] Xcodeプロジェクト作成
- [ ] SwiftUIプロジェクト構成
- [ ] Core Data設定
- [ ] 基本的なフォルダ構造作成

#### 1.2 データモデル実装
- [ ] `Question.swift` - 問題データモデル
- [ ] `QuestionCategory.swift` - カテゴリ列挙型
- [ ] Core Dataモデル（StudyRecord, UserPreferences）
- [ ] `questions.json` - サンプル問題データ（10問程度）

#### 1.3 基本画面実装
- [ ] `ContentView.swift` - メイン画面
- [ ] `QuizView.swift` - 問題表示画面
- [ ] `ResultView.swift` - 結果表示画面
- [ ] 基本ナビゲーション

#### 1.4 コアロジック実装
- [ ] `QuestionService.swift` - 問題データ管理
- [ ] `QuizViewModel.swift` - 問題表示ロジック
- [ ] 通常モードの実装
- [ ] 解答判定ロジック

### Phase 2: 学習機能拡張
**期間**: 1週間
**目標**: 学習モードと進捗管理機能

#### 2.1 学習モード実装
- [ ] ランダムモード実装
- [ ] 復習モード実装（間違えた問題）
- [ ] モード選択UI

#### 2.2 データ永続化
- [ ] `CoreDataService.swift` - データ管理サービス
- [ ] 解答履歴保存機能
- [ ] 学習進捗管理
- [ ] UserDefaults設定管理

#### 2.3 統計機能
- [ ] `StatsView.swift` - 統計画面
- [ ] `StatsViewModel.swift` - 統計ロジック
- [ ] 正答率計算
- [ ] カテゴリ別統計

### Phase 3: UI/UX改善
**期間**: 1週間
**目標**: ユーザー体験の向上

#### 3.1 UI改善
- [ ] アニメーション追加
- [ ] ダークモード対応
- [ ] アクセシビリティ対応
- [ ] 画面レスポンシブ対応

#### 3.2 設定機能
- [ ] `SettingsView.swift` - 設定画面
- [ ] フォントサイズ調整
- [ ] 通知設定
- [ ] データリセット機能

### Phase 4: マネタイゼーション
**期間**: 1週間
**目標**: 広告とレビューリクエスト

#### 4.1 広告実装
- [ ] AdMob SDK統合
- [ ] `AdService.swift` - 広告管理サービス
- [ ] バナー広告実装
- [ ] インタースティシャル広告実装
- [ ] 広告表示制限ロジック

#### 4.2 レビューリクエスト
- [ ] `ReviewManager.swift` - レビュー管理
- [ ] StoreKit統合
- [ ] レビューリクエストタイミング制御

#### 4.3 アプリ内課金（オプション）
- [ ] 広告非表示オプション
- [ ] StoreKit課金処理
- [ ] 課金状態管理

### Phase 5: 問題データ拡張
**期間**: 1週間
**目標**: 100問の問題データ作成

#### 5.1 問題作成
- [ ] カテゴリ別問題作成（各カテゴリ14-15問）
- [ ] 解説文作成
- [ ] 難易度設定
- [ ] JSONデータ整備

#### 5.2 データ検証
- [ ] 問題の正確性チェック
- [ ] 解説の品質確認
- [ ] カテゴリ分散バランス調整

## 技術実装詳細

### 開発環境
- **Xcode**: 15.0以降
- **iOS**: 15.0以降
- **Swift**: 5.9以降
- **依存関係**: AdMob SDK

### プロジェクト構成
```
GKenteiFlashcard/
├── GKenteiFlashcardApp.swift
├── Models/
│   ├── Question.swift
│   ├── QuestionCategory.swift
│   ├── StudyRecord.swift
│   ├── UserPreferences.swift
│   └── GKenteiFlashcard.xcdatamodeld
├── ViewModels/
│   ├── QuizViewModel.swift
│   ├── StatsViewModel.swift
│   └── SettingsViewModel.swift
├── Views/
│   ├── ContentView.swift
│   ├── QuizView.swift
│   ├── ResultView.swift
│   ├── StatsView.swift
│   ├── SettingsView.swift
│   └── Components/
│       ├── QuestionCard.swift
│       ├── AnswerButton.swift
│       └── ProgressBar.swift
├── Services/
│   ├── QuestionService.swift
│   ├── CoreDataService.swift
│   ├── AdService.swift
│   └── ReviewManager.swift
├── Resources/
│   ├── questions.json
│   └── Assets.xcassets
└── Utils/
    ├── Extensions.swift
    └── Constants.swift
```

### Core Data スキーマ
```swift
// StudyRecord Entity
- questionId: Int32
- isCorrect: Bool
- answeredAt: Date
- selectedAnswer: Int32
- studyMode: String

// UserPreferences Entity  
- id: UUID
- dailyGoal: Int32
- isDarkMode: Bool
- isAdFree: Bool
- reviewRequestCount: Int32
- lastReviewRequestDate: Date?
- interstitialAdCount: Int32
- lastInterstitialDate: Date?
```

### JSON データ構造
```json
{
  "questions": [
    {
      "id": 1,
      "category": "aiDefinition",
      "questionText": "人工知能という言葉を最初に提唱したのは誰か？",
      "choices": [
        "アラン・チューリング",
        "ジョン・マッカーシー", 
        "マービン・ミンスキー",
        "フランク・ローゼンブラット"
      ],
      "correctAnswer": 1,
      "explanation": "「人工知能（Artificial Intelligence）」という用語は、1956年にジョン・マッカーシーによって...",
      "difficulty": "easy"
    }
  ]
}
```

## テスト計画

### ユニットテスト
- [ ] QuestionService テスト
- [ ] QuizViewModel テスト  
- [ ] CoreDataService テスト
- [ ] 計算ロジックテスト

### UIテスト
- [ ] 画面遷移テスト
- [ ] タップ操作テスト
- [ ] データ表示テスト

### 統合テスト
- [ ] エンドツーエンド学習フローテスト
- [ ] データ永続化テスト
- [ ] 広告表示テスト

## デプロイメント計画

### App Store準備
1. **アプリメタデータ**
   - アプリ名: "G検定 Flashcard"
   - カテゴリ: 教育
   - 年齢制限: 4+
   - プライバシーポリシー作成

2. **スクリーンショット**
   - iPhone各サイズ対応
   - iPad対応（オプション）
   - アプリの主要機能を示す画像

3. **アプリ説明文**
   - 日本語での詳細説明
   - キーワード最適化
   - 更新履歴準備

### リリース手順
1. TestFlight ベータテスト
2. App Store Review
3. リリース日調整
4. マーケティング準備

## リスク管理

### 技術リスク
- **Core Data マイグレーション**: 軽量マイグレーション設計
- **AdMob 統合**: サンドボックスモードでの十分なテスト
- **メモリ管理**: 大量問題データの効率的読み込み

### ビジネスリスク
- **App Store 審査**: ガイドライン準拠確認
- **著作権**: 問題文の独自作成
- **競合**: 差別化ポイントの明確化

この実装計画で進めることに問題はありますか？