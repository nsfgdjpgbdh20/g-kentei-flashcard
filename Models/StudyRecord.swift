import Foundation
import CoreData

@objc(StudyRecord)
public class StudyRecord: NSManagedObject {
    
}

extension StudyRecord {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudyRecord> {
        return NSFetchRequest<StudyRecord>(entityName: "StudyRecord")
    }
    
    @NSManaged public var questionId: Int32
    @NSManaged public var isCorrect: Bool
    @NSManaged public var answeredAt: Date
    @NSManaged public var selectedAnswer: Int32
    @NSManaged public var studyMode: String
}

extension StudyRecord: Identifiable {
    
}