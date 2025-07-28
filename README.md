# G検定 Flashcard アプリ

## セットアップ手順

### 1. Xcodeプロジェクトの作成
1. Xcodeを起動
2. "Create a new Xcode project" を選択
3. "iOS" → "App" を選択
4. 以下の設定で作成：
   - Product Name: `GKenteiFlashcard`
   - Interface: SwiftUI
   - Language: Swift
   - Use Core Data: チェック
   - Bundle Identifier: com.yourname.gkenteiflashcard

### 2. ファイルの配置
作成したプロジェクトに以下のファイルを追加してください：

```
GKenteiFlashcard/
├── GKenteiFlashcardApp.swift (既存ファイルを置き換え)
├── Models/
│   ├── Question.swift
│   ├── QuestionCategory.swift
│   ├── StudyRecord.swift
│   └── UserPreferences.swift
├── ViewModels/
│   └── QuizViewModel.swift
├── Views/
│   ├── ContentView.swift (既存ファイルを置き換え)
│   ├── QuizView.swift
│   ├── StatsView.swift
│   └── SettingsView.swift
├── Services/
│   ├── PersistenceController.swift
│   ├── QuestionService.swift
│   └── CoreDataService.swift
├── Resources/
│   └── questions.json
└── Utils/
    ├── Constants.swift
    └── Extensions.swift
```

### 3. Core Dataモデルファイルの更新
1. プロジェクト内の `GKenteiFlashcard.xcdatamodeld` を選択
2. 既存の内容を削除
3. 提供された `Contents` ファイルの内容で置き換え

### 4. ビルド設定
- iOS Deployment Target: 15.0 以降に設定
- Swift Language Version: Swift 5

### 5. 実行
Cmd+R でビルドして実行

## 現在の実装状況
- ✅ Phase 1: 基盤実装（MVP）完了
- ⏳ Phase 2: 学習機能拡張
- ⏳ Phase 3: UI/UX改善
- ⏳ Phase 4: マネタイゼーション
- ⏳ Phase 5: 問題データ拡張

## 主な機能
- 3つの学習モード（通常・ランダム・復習）
- 一問一答形式のクイズ
- 解答結果と解説表示
- 学習統計表示
- 設定画面
- Core Dataによる学習記録保存