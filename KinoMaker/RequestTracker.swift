import Foundation

final class RequestTracker {
    
    static let shared = RequestTracker()
    
    private init() {}
    
    func trackRequest() {
        var requestCount = UserDefaultsManager.requestCount
        
        UserDefaultsManager.requestCount -= 1
        requestCount -= 1
        
        print("Available number of requests \(requestCount)")
    }
    
}
