import Foundation

struct Question: Codable, Identifiable {
    let id: Int
    let category: QuestionCategory
    let questionText: String
    let choices: [String]
    let correctAnswer: Int
    let explanation: String
    let difficulty: Difficulty
    
    var isValidChoiceIndex: Bool {
        return correctAnswer >= 0 && correctAnswer < choices.count
    }
}

enum Difficulty: String, Codable, CaseIterable {
    case easy = "基礎"
    case medium = "標準"
    case hard = "応用"
    
    var displayName: String {
        return self.rawValue
    }
}

struct QuestionData: Codable {
    let questions: [Question]
}