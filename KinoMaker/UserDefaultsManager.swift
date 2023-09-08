import Foundation

enum UserDefaultsManager {
    
    static var requestCount: Int {
        get { UserDefaults.standard.value(forKey: Constants.key) as? Int ?? Constants.dayRequestLimit }
        set { UserDefaults.standard.setValue(newValue, forKey: Constants.key) }
    }
    
}

// MARK: - Constans

extension UserDefaultsManager {
    
    enum Constants {
        static let dayRequestLimit = 200
        static let key = "requestCount"
    }
    
}
