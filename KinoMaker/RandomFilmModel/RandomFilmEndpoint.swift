import Foundation
//https://api.kinopoisk.dev/v1.3/movie?page=1&limit=250&typeNumber=1&isSeries=false

enum RandomFilmEndpoint: Endpoint {
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
            return "api.kinopoisk.dev"
        }
    }

    var path: String {
        switch self {
        case .getData:
            return "/v1.3/movie"
        }
    }

    var parameters: [URLQueryItem] {
            switch self {
            case .getData:
                return [
                    URLQueryItem(name: "page", value: "1"),
                    URLQueryItem(name: "limit", value: "250"),
                    URLQueryItem(name: "typeNumber", value: "1"),
                    URLQueryItem(name: "isSeries", value: "false"),
                ]
            }
        }
    
    var headers: [String: String] {
        switch self {
        case .getData:
            return [
                "X-API-KEY": "4M53ACZ-MH849JV-JHNG3HV-ZH0RAJW",
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
