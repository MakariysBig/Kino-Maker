import Foundation

enum StrategyEndpoint: Endpoint {
    case getData
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }

    var baseURl: String {
        switch self {
        default:
            return "bionn.space"
        }
    }

    var path: String {
        switch self {
        case .getData:
            return "/api/v2/strategies"
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        case .getData:
            return [
                     URLQueryItem(name: "token", value: "55b9a408-9277-11ed-a1eb-0242ac120002"),
                     URLQueryItem(name: "lang", value: "en")
            ]
        }
    }

    var method: String {
        switch self {
        case .getData:
            return "GET"
        }
    }
}
