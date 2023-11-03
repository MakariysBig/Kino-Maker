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
    
    static var filmArray: [FilmInfo] {
        get {
            var array = [FilmInfo]()
            if let data = UserDefaults.standard.value(forKey: "filmArray") as? Data {
                if let dataFromDB = try? PropertyListDecoder().decode(Array<FilmInfo>.self, from: data) {
                    array = dataFromDB
                }
            }
            return array
        }
        
        set {
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newValue), forKey:"filmArray")
        }
    }
    
    static var firstUser: [FilmInfo] {
        get {
            var array = [FilmInfo]()
            if let data = UserDefaults.standard.value(forKey: "firstUser") as? Data {
                if let dataFromDB = try? PropertyListDecoder().decode(Array<FilmInfo>.self, from: data) {
                    array = dataFromDB
                }
            }
            return array
        }
        
        set {
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newValue), forKey:"firstUser")
        }
    }
    
    static var secondUser: [FilmInfo] {
        get {
            var array = [FilmInfo]()
            if let data = UserDefaults.standard.value(forKey: "secondUser") as? Data {
                if let dataFromDB = try? PropertyListDecoder().decode(Array<FilmInfo>.self, from: data) {
                    array = dataFromDB
                }
            }
            return array
        }
        
        set {
            UserDefaults.standard.setValue(try? PropertyListEncoder().encode(newValue), forKey:"secondUser")
        }
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
