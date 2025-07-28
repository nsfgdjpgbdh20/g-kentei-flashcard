import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // アプリタイトル
                Text("G検定 Flashcard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.top, 20)
                
                Spacer()
                
                // 学習モード選択
                VStack(spacing: 20) {
                    Text("学習モード選択")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    NavigationLink(destination: QuizView(studyMode: .normal)) {
                        ModeButton(title: "通常モード", subtitle: "1番から順番に学習")
                    }
                    
                    NavigationLink(destination: QuizView(studyMode: .random)) {
                        ModeButton(title: "ランダムモード", subtitle: "問題をシャッフルして出題")
                    }
                    
                    NavigationLink(destination: QuizView(studyMode: .review)) {
                        ModeButton(title: "復習モード", subtitle: "間違えた問題のみ")
                    }
                }
                
                Spacer()
                
                // 学習統計
                VStack(spacing: 10) {
                    Text("学習統計")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    HStack(spacing: 30) {
                        StatItem(title: "正答率", value: "75%")
                        StatItem(title: "学習日数", value: "7日")
                    }
                }
                
                Spacer()
                
                // ボタン
                HStack(spacing: 40) {
                    NavigationLink(destination: StatsView()) {
                        VStack {
                            Image(systemName: "chart.bar")
                                .font(.title2)
                            Text("統計")
                                .font(.caption)
                        }
                        .foregroundColor(.blue)
                    }
                    
                    NavigationLink(destination: SettingsView()) {
                        VStack {
                            Image(systemName: "gear")
                                .font(.title2)
                            Text("設定")
                                .font(.caption)
                        }
                        .foregroundColor(.gray)
                    }
                }
                .padding(.bottom, 100) // バナー広告スペース
            }
            .padding(.horizontal, 20)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ModeButton: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Text(subtitle)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color.blue.gradient)
        .cornerRadius(12)
        .shadow(color: .blue.opacity(0.3), radius: 4, x: 0, y: 2)
    }
}

struct StatItem: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

enum StudyMode: String, CaseIterable {
    case normal = "normal"
    case random = "random"
    case review = "review"
    
    var displayName: String {
        switch self {
        case .normal: return "通常モード"
        case .random: return "ランダムモード"
        case .review: return "復習モード"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}