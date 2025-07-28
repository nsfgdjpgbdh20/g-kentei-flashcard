import Foundation

enum QuestionCategory: String, CaseIterable, Codable {
    case aiDefinition = "人工知能の定義と動向"
    case machineLearningOverview = "機械学習の概要"
    case deepLearningTechnology = "ディープラーニングの要素技術"
    case aiSocialImplementation = "AIの社会実装"
    case mathStatistics = "数理・統計知識"
    case aiLawEthics = "AI関連法律・倫理"
    case aiGovernance = "AIガバナンス"
    
    var displayName: String {
        return self.rawValue
    }
    
    var shortName: String {
        switch self {
        case .aiDefinition: return "AI基礎"
        case .machineLearningOverview: return "機械学習"
        case .deepLearningTechnology: return "DL技術"
        case .aiSocialImplementation: return "社会実装"
        case .mathStatistics: return "数理統計"
        case .aiLawEthics: return "法律倫理"
        case .aiGovernance: return "ガバナンス"
        }
    }
}