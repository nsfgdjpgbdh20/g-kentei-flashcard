import Foundation
import SwiftUI

// MARK: - Date Extensions
extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    func daysBetween(_ date: Date) -> Int {
        Calendar.current.dateComponents([.day], from: self.startOfDay, to: date.startOfDay).day ?? 0
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }
}

// MARK: - Double Extensions
extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var percentageString: String {
        return "\\(Int(self * 100))%"
    }
}

// MARK: - Array Extensions
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

extension Array where Element == Question {
    func filtered(by category: QuestionCategory) -> [Question] {
        return filter { $0.category == category }
    }
    
    func filtered(by difficulty: Difficulty) -> [Question] {
        return filter { $0.difficulty == difficulty }
    }
}

// MARK: - Color Extensions
extension Color {
    static let appPrimary = Color.blue
    static let appSecondary = Color.gray
    static let appSuccess = Color.green
    static let appError = Color.red
    static let appWarning = Color.orange
    
    static let backgroundPrimary = Color(UIColor.systemBackground)
    static let backgroundSecondary = Color(UIColor.secondarySystemBackground)
}

// MARK: - View Extensions
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - Custom Shapes
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - UserDefaults Extensions
extension UserDefaults {
    func setDate(_ date: Date?, forKey key: String) {
        set(date, forKey: key)
    }
    
    func date(forKey key: String) -> Date? {
        return object(forKey: key) as? Date
    }
}