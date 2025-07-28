import Foundation

struct Constants {
    // MARK: - UI Constants
    struct UI {
        static let cornerRadius: CGFloat = 12
        static let buttonHeight: CGFloat = 50
        static let padding: CGFloat = 16
        static let largePadding: CGFloat = 20
        static let bannerAdHeight: CGFloat = 50
    }
    
    // MARK: - Animation Constants
    struct Animation {
        static let defaultDuration: Double = 0.3
        static let fastDuration: Double = 0.2
        static let slowDuration: Double = 0.5
    }
    
    // MARK: - App Constants
    struct App {
        static let name = "G検定 Flashcard"
        static let version = "1.0.0"
        static let totalQuestions = 100
    }
    
    // MARK: - User Defaults Keys
    struct UserDefaultsKeys {
        static let currentQuestionIndex = "current_question_index"
        static let studyStreak = "study_streak"
        static let lastStudyDate = "last_study_date"
        static let hasSeenOnboarding = "has_seen_onboarding"
    }
    
    // MARK: - Ad Configuration
    struct Ads {
        static let maxInterstitialPerDay = 3
        static let minInterstitialInterval: TimeInterval = 30 * 60 // 30分
        static let bannerAdUnitID = "ca-app-pub-3940256099942544/2934735716" // テスト用ID
        static let interstitialAdUnitID = "ca-app-pub-3940256099942544/4411468910" // テスト用ID
    }
    
    // MARK: - Review Request
    struct Review {
        static let minStudyDays = 7
        static let minCorrectAnswers = 50
        static let minDaysSinceLastRequest = 30
    }
}