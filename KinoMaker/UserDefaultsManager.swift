import Foundation

enum UserDefaultsManager {
    
    static var requestCount: Int {
        get { UserDefaults.standard.value(forKey: Constants.requestCount) as? Int ?? Constants.dayRequestLimit }
        set { UserDefaults.standard.setValue(newValue, forKey: Constants.requestCount) }
    }
    
    static var previousDay: Date {
        get { UserDefaults.standard.value(forKey: Constants.previousDay) as? Date ?? Date() }
        set { UserDefaults.standard.setValue(newValue, forKey: Constants.previousDay) }
    }
    
}

// MARK: - Constans

extension UserDefaultsManager {
    
    enum Constants {
        static let dayRequestLimit = 200
        static let requestCount = "requestCount"
        static let previousDay = "previousDay"
    }
    
}
