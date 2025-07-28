import Foundation
import CoreData

class CoreDataService: ObservableObject {
    static let shared = CoreDataService()
    private let persistenceController = PersistenceController.shared
    
    private var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
    
    private init() {}
    
    // MARK: - Study Record Operations
    
    func saveStudyRecord(questionId: Int, isCorrect: Bool, selectedAnswer: Int, studyMode: String) {
        let newRecord = StudyRecord(context: viewContext)
        newRecord.questionId = Int32(questionId)
        newRecord.isCorrect = isCorrect
        newRecord.selectedAnswer = Int32(selectedAnswer)
        newRecord.studyMode = studyMode
        newRecord.answeredAt = Date()
        
        saveContext()
    }
    
    func getStudyRecords() -> [StudyRecord] {
        let request: NSFetchRequest<StudyRecord> = StudyRecord.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \\StudyRecord.answeredAt, ascending: false)]
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Error fetching study records: \\(error)")
            return []
        }
    }
    
    func getIncorrectQuestionIds() -> [Int] {
        let request: NSFetchRequest<StudyRecord> = StudyRecord.fetchRequest()
        request.predicate = NSPredicate(format: "isCorrect == false")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \\StudyRecord.answeredAt, ascending: false)]
        
        do {
            let records = try viewContext.fetch(request)
            return records.map { Int($0.questionId) }
        } catch {
            print("Error fetching incorrect questions: \\(error)")
            return []
        }
    }
    
    func getCorrectAnswerCount() -> Int {
        let request: NSFetchRequest<StudyRecord> = StudyRecord.fetchRequest()
        request.predicate = NSPredicate(format: "isCorrect == true")
        
        do {
            return try viewContext.count(for: request)
        } catch {
            print("Error counting correct answers: \\(error)")
            return 0
        }
    }
    
    func getTotalAnswerCount() -> Int {
        let request: NSFetchRequest<StudyRecord> = StudyRecord.fetchRequest()
        
        do {
            return try viewContext.count(for: request)
        } catch {
            print("Error counting total answers: \\(error)")
            return 0
        }
    }
    
    func getCorrectAnswerRate() -> Double {
        let total = getTotalAnswerCount()
        guard total > 0 else { return 0.0 }
        
        let correct = getCorrectAnswerCount()
        return Double(correct) / Double(total)
    }
    
    // MARK: - User Preferences Operations
    
    func getUserPreferences() -> UserPreferences {
        let request: NSFetchRequest<UserPreferences> = UserPreferences.fetchRequest()
        
        do {
            let preferences = try viewContext.fetch(request)
            if let existing = preferences.first {
                return existing
            } else {
                // 新しい設定を作成
                let newPreferences = UserPreferences(context: viewContext)
                newPreferences.id = UUID()
                newPreferences.dailyGoal = 10
                newPreferences.isDarkMode = false
                newPreferences.isAdFree = false
                newPreferences.reviewRequestCount = 0
                newPreferences.interstitialAdCount = 0
                
                saveContext()
                return newPreferences
            }
        } catch {
            print("Error fetching user preferences: \\(error)")
            
            // エラー時は新しい設定を作成
            let newPreferences = UserPreferences(context: viewContext)
            newPreferences.id = UUID()
            newPreferences.dailyGoal = 10
            newPreferences.isDarkMode = false
            newPreferences.isAdFree = false
            newPreferences.reviewRequestCount = 0
            newPreferences.interstitialAdCount = 0
            
            saveContext()
            return newPreferences
        }
    }
    
    func updateUserPreferences(_ preferences: UserPreferences) {
        saveContext()
    }
    
    // MARK: - Data Management
    
    func deleteAllStudyRecords() {
        let request: NSFetchRequest<NSFetchRequestResult> = StudyRecord.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try viewContext.execute(deleteRequest)
            saveContext()
        } catch {
            print("Error deleting study records: \\(error)")
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \\(error)")
        }
    }
}