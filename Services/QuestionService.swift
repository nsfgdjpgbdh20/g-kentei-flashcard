import Foundation

class QuestionService: ObservableObject {
    static let shared = QuestionService()
    
    @Published var questions: [Question] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private init() {}
    
    func loadQuestions() {
        isLoading = true
        error = nil
        
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            error = "問題データファイルが見つかりません"
            isLoading = false
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let questionData = try JSONDecoder().decode(QuestionData.self, from: data)
            
            DispatchQueue.main.async {
                self.questions = questionData.questions
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.error = "問題データの読み込みに失敗しました: \\(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
    
    func getQuestionsByMode(_ mode: StudyMode) -> [Question] {
        switch mode {
        case .normal:
            return questions
        case .random:
            return questions.shuffled()
        case .review:
            // TODO: 復習モードは後で実装（間違えた問題のみ）
            return questions.shuffled()
        }
    }
    
    func getQuestionsByCategory(_ category: QuestionCategory) -> [Question] {
        return questions.filter { $0.category == category }
    }
    
    func getQuestion(by id: Int) -> Question? {
        return questions.first { $0.id == id }
    }
}