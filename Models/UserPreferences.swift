import Foundation
import CoreData

@objc(UserPreferences)
public class UserPreferences: NSManagedObject {
    
}

extension UserPreferences {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserPreferences> {
        return NSFetchRequest<UserPreferences>(entityName: "UserPreferences")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var dailyGoal: Int32
    @NSManaged public var isDarkMode: Bool
    @NSManaged public var isAdFree: Bool
    @NSManaged public var reviewRequestCount: Int32
    @NSManaged public var lastReviewRequestDate: Date?
    @NSManaged public var interstitialAdCount: Int32
    @NSManaged public var lastInterstitialDate: Date?
}

extension UserPreferences: Identifiable {
    
}