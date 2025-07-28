import Foundation
import Combine

class QuizViewModel: ObservableObject {
    @Published var currentQuestion: Question?
    @Published var currentQuestionIndex = 0
    @Published var selectedAnswer: Int?
    @Published var showResult = false
    @Published var isCorrect = false
    @Published var isLoading = false
    
    private var questions: [Question] = []
    private let questionService = QuestionService.shared
    private let coreDataService = CoreDataService.shared
    private var cancellables = Set<AnyCancellable>()
    
    let studyMode: StudyMode
    
    var totalQuestions: Int {
        return questions.count
    }
    
    var isLastQuestion: Bool {
        return currentQuestionIndex >= questions.count - 1
    }
    
    init(studyMode: StudyMode) {
        self.studyMode = studyMode
        setupBindings()
    }
    
    private func setupBindings() {
        questionService.$questions
            .sink { [weak self] questions in
                guard let self = self else { return }
                self.questions = self.questionService.getQuestionsByMode(self.studyMode)
                self.loadCurrentQuestion()
            }
            .store(in: &cancellables)
        
        questionService.$isLoading
            .assign(to: &$isLoading)
    }
    
    func loadQuestions() {
        if questionService.questions.isEmpty {
            questionService.loadQuestions()
        } else {
            questions = questionService.getQuestionsByMode(studyMode)
            loadCurrentQuestion()
        }
    }
    
    private func loadCurrentQuestion() {
        guard currentQuestionIndex < questions.count else {
            // 全問題完了
            currentQuestion = nil
            return
        }
        
        currentQuestion = questions[currentQuestionIndex]
        selectedAnswer = nil
        showResult = false
    }
    
    func selectAnswer(_ index: Int) {
        guard !showResult else { return }
        selectedAnswer = index
    }
    
    func submitAnswer() {
        guard let selectedAnswer = selectedAnswer,
              let question = currentQuestion else { return }
        
        isCorrect = selectedAnswer == question.correctAnswer
        showResult = true
        
        // 学習記録を保存
        coreDataService.saveStudyRecord(
            questionId: question.id,
            isCorrect: isCorrect,
            selectedAnswer: selectedAnswer,
            studyMode: studyMode.rawValue
        )
    }
    
    func nextQuestion() {
        if isLastQuestion {
            // 学習セッション完了
            // TODO: 完了画面への遷移やインタースティシャル広告表示
            return
        }
        
        currentQuestionIndex += 1
        loadCurrentQuestion()
    }
    
    func resetQuiz() {
        currentQuestionIndex = 0
        selectedAnswer = nil
        showResult = false
        isCorrect = false
        loadCurrentQuestion()
    }
    
    // MARK: - Statistics
    
    func getProgressPercentage() -> Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(currentQuestionIndex) / Double(totalQuestions) * 100
    }
}