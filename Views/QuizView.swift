import SwiftUI

struct QuizView: View {
    @StateObject private var viewModel: QuizViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(studyMode: StudyMode) {
        _viewModel = StateObject(wrappedValue: QuizViewModel(studyMode: studyMode))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // ヘッダー
            HStack {
                Button("戻る") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.blue)
                
                Spacer()
                
                Text("問題 \\(viewModel.currentQuestionIndex + 1)/\\(viewModel.totalQuestions)")
                    .font(.headline)
                
                Spacer()
                
                Text(viewModel.studyMode.displayName)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 20)
            
            // プログレスバー
            ProgressView(value: Double(viewModel.currentQuestionIndex), total: Double(viewModel.totalQuestions))
                .padding(.horizontal, 20)
            
            if let currentQuestion = viewModel.currentQuestion {
                // 問題表示
                VStack(spacing: 20) {
                    // カテゴリ表示
                    Text(currentQuestion.category.displayName)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(.blue)
                        .cornerRadius(8)
                    
                    // 問題文
                    Text(currentQuestion.questionText)
                        .font(.title3)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 20)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
                    
                    // 選択肢
                    VStack(spacing: 12) {
                        ForEach(0..<currentQuestion.choices.count, id: \\.self) { index in
                            ChoiceButton(
                                choice: currentQuestion.choices[index],
                                index: index,
                                selectedAnswer: viewModel.selectedAnswer,
                                correctAnswer: viewModel.showResult ? currentQuestion.correctAnswer : nil
                            ) {
                                viewModel.selectAnswer(index)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    // 回答ボタン / 次へボタン
                    if !viewModel.showResult {
                        Button(action: viewModel.submitAnswer) {
                            Text("回答")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(viewModel.selectedAnswer != nil ? Color.blue : Color.gray)
                                .cornerRadius(12)
                        }
                        .disabled(viewModel.selectedAnswer == nil)
                        .padding(.horizontal, 20)
                    } else {
                        // 結果表示
                        ResultView(
                            isCorrect: viewModel.isCorrect,
                            correctAnswer: currentQuestion.choices[currentQuestion.correctAnswer],
                            explanation: currentQuestion.explanation,
                            onNext: viewModel.nextQuestion
                        )
                    }
                }
            } else {
                // 問題読み込み中またはエラー
                VStack {
                    ProgressView()
                    Text("問題を読み込んでいます...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // バナー広告スペース
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 50)
                .overlay(
                    Text("[バナー広告]")
                        .font(.caption)
                        .foregroundColor(.gray)
                )
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.loadQuestions()
        }
    }
}

struct ChoiceButton: View {
    let choice: String
    let index: Int
    let selectedAnswer: Int?
    let correctAnswer: Int?
    let action: () -> Void
    
    private var backgroundColor: Color {
        if let correct = correctAnswer {
            if index == correct {
                return Color.green.opacity(0.8)
            } else if index == selectedAnswer && selectedAnswer != correct {
                return Color.red.opacity(0.8)
            }
        }
        
        if selectedAnswer == index {
            return Color.blue.opacity(0.8)
        }
        
        return Color.gray.opacity(0.1)
    }
    
    private var textColor: Color {
        if correctAnswer != nil {
            if index == correctAnswer || (index == selectedAnswer && selectedAnswer != correctAnswer) {
                return .white
            }
        } else if selectedAnswer == index {
            return .white
        }
        
        return .primary
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text("\\(["A", "B", "C", "D"][index]))")
                    .fontWeight(.semibold)
                
                Text(choice)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding(16)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selectedAnswer == index ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
        .disabled(correctAnswer != nil)
    }
}

struct ResultView: View {
    let isCorrect: Bool
    let correctAnswer: String
    let explanation: String
    let onNext: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            // 正解/不正解表示
            HStack {
                Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(isCorrect ? .green : .red)
                
                Text(isCorrect ? "正解!" : "不正解")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(isCorrect ? .green : .red)
            }
            
            // 正解表示
            VStack(alignment: .leading, spacing: 8) {
                Text("正解: \\(correctAnswer)")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("解説:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(explanation)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(16)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            .padding(.horizontal, 20)
            
            // 次の問題ボタン
            Button(action: onNext) {
                Text("次の問題")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(studyMode: .normal)
    }
}