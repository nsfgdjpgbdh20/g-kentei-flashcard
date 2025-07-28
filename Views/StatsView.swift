import SwiftUI

struct StatsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            // ヘッダー
            HStack {
                Button("戻る") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.blue)
                
                Spacer()
                
                Text("学習統計")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            ScrollView {
                VStack(spacing: 30) {
                    // 全体統計
                    VStack(spacing: 16) {
                        Text("全体統計")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        HStack(spacing: 30) {
                            StatCard(title: "総合正答率", value: "75%", color: .blue)
                            StatCard(title: "学習継続", value: "7日", color: .green)
                            StatCard(title: "解答済み", value: "45/100問", color: .orange)
                        }
                    }
                    
                    // カテゴリ別正答率
                    VStack(alignment: .leading, spacing: 16) {
                        Text("カテゴリ別正答率")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 12) {
                            CategoryStatsRow(category: "人工知能の定義と動向", percentage: 80)
                            CategoryStatsRow(category: "機械学習の概要", percentage: 70)
                            CategoryStatsRow(category: "ディープラーニングの要素技術", percentage: 65)
                            CategoryStatsRow(category: "AIの社会実装", percentage: 60)
                            CategoryStatsRow(category: "数理・統計知識", percentage: 85)
                            CategoryStatsRow(category: "AI関連法律・倫理", percentage: 75)
                            CategoryStatsRow(category: "AIガバナンス", percentage: 70)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // 学習履歴（プレースホルダー）
                    VStack(alignment: .leading, spacing: 16) {
                        Text("学習履歴")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        // カレンダー風の学習履歴表示（簡略版）
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                            ForEach(1...21, id: \\.self) { day in
                                Rectangle()
                                    .fill(day % 3 == 0 ? Color.green.opacity(0.8) : 
                                         day % 5 == 0 ? Color.green.opacity(0.4) : Color.gray.opacity(0.2))
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(6)
                            }
                        }
                        
                        HStack {
                            Text("学習なし")
                                .font(.caption)
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 12, height: 12)
                                .cornerRadius(2)
                            
                            Text("少し学習")
                                .font(.caption)
                            Rectangle()
                                .fill(Color.green.opacity(0.4))
                                .frame(width: 12, height: 12)
                                .cornerRadius(2)
                            
                            Text("たくさん学習")
                                .font(.caption)
                            Rectangle()
                                .fill(Color.green.opacity(0.8))
                                .frame(width: 12, height: 12)
                                .cornerRadius(2)
                            
                            Spacer()
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 100) // バナー広告スペース
            }
        }
        .navigationBarHidden(true)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}

struct CategoryStatsRow: View {
    let category: String
    let percentage: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(category)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text("\\(percentage)%")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(percentage >= 70 ? .green : percentage >= 50 ? .orange : .red)
            }
            
            ProgressView(value: Double(percentage), total: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: percentage >= 70 ? .green : percentage >= 50 ? .orange : .red))
        }
        .padding(.vertical, 4)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}