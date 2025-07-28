import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var dailyGoal: Double = 10
    @State private var isDarkMode = false
    @State private var notificationsEnabled = true
    @State private var showResetAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            // ヘッダー
            HStack {
                Button("戻る") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.blue)
                
                Spacer()
                
                Text("設定")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            ScrollView {
                VStack(spacing: 30) {
                    // 学習設定
                    VStack(alignment: .leading, spacing: 16) {
                        Text("学習設定")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("1日の目標問題数: \\(Int(dailyGoal))問")
                                .font(.subheadline)
                            
                            Slider(value: $dailyGoal, in: 5...50, step: 5)
                                .accentColor(.blue)
                        }
                        .padding(16)
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(12)
                    }
                    
                    // 表示設定
                    VStack(alignment: .leading, spacing: 16) {
                        Text("表示設定")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 16) {
                            HStack {
                                Text("ダークモード")
                                    .font(.subheadline)
                                
                                Spacer()
                                
                                Toggle("", isOn: $isDarkMode)
                            }
                            
                            Divider()
                            
                            HStack {
                                Text("学習リマインダー")
                                    .font(.subheadline)
                                
                                Spacer()
                                
                                Toggle("", isOn: $notificationsEnabled)
                            }
                        }
                        .padding(16)
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(12)
                    }
                    
                    // アプリ情報
                    VStack(alignment: .leading, spacing: 16) {
                        Text("アプリ情報")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 16) {
                            InfoRow(title: "バージョン", value: "1.0.0")
                            
                            Divider()
                            
                            Button(action: {
                                // レビューを書く
                            }) {
                                HStack {
                                    Text("アプリを評価する")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Divider()
                            
                            Button(action: {
                                // お問い合わせ
                            }) {
                                HStack {
                                    Text("お問い合わせ")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(16)
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(12)
                    }
                    
                    // データ管理
                    VStack(alignment: .leading, spacing: 16) {
                        Text("データ管理")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 16) {
                            Button(action: {
                                showResetAlert = true
                            }) {
                                HStack {
                                    Text("学習データをリセット")
                                        .font(.subheadline)
                                        .foregroundColor(.red)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(16)
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100) // バナー広告スペース
            }
        }
        .navigationBarHidden(true)
        .alert("学習データをリセット", isPresented: $showResetAlert) {
            Button("キャンセル", role: .cancel) { }
            Button("リセット", role: .destructive) {
                // リセット処理
            }
        } message: {
            Text("すべての学習記録が削除されます。この操作は取り消せません。")
        }
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}