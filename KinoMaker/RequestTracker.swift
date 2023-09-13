import Foundation

final class RequestTracker {
    
    static let shared = RequestTracker()
    
    private init() {}
    
    // MARK: - Open functions
    
    func trackRequest() {
        var requestCount = getRequestCount()
        
        UserDefaultsManager.requestCount -= 1
        requestCount -= 1
        
        print("Available number of requests \(requestCount)")
    }
    
    // MARK: - Private functions
    
    private func getRequestCount() -> Int {
        let previousDay = UserDefaultsManager.previousDay
        let isDateToday = Calendar.current.isDateInToday(previousDay)
        
        if !isDateToday {
            UserDefaultsManager.requestCount = 200
        }
        
        return UserDefaultsManager.requestCount
    }
    
}

// MARK: - Constants

private extension RequestTracker {
    
    enum Constants {
        static let dayRequestLimit = 200
    }
    
}
