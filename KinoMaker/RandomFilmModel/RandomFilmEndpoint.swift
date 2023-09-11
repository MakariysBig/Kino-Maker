import Foundation
// "https://api.kinopoisk.dev/v1/movie/random"
//enum RandomFilmEndpoint: Endpoint {
//    case getData
//    var scheme: String {
//        switch self {
//        default:
//            return "https"
//        }
//    }
//
//    var baseURl: String {
//        switch self {
//        default:
//            return "api.kinopoisk.dev"
//        }
//    }
//
//    var path: String {
//        switch self {
//        case .getData:
//            return "/v1.3/movie/random"
//        }
//    }
//
//    var parameters: [URLQueryItem] {
//        switch self {
//        case .getData:
//            return [
//                URLQueryItem(name: "X-API-KEY", value: "4M53ACZ-MH849JV-JHNG3HV-ZH0RAJW"),
//            ]
//        }
//    }
//
//    var method: String {
//        switch self {
//        case .getData:
//            return "GET"
//        }
//    }
//}

import Foundation

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
            return "/v1.3/movie/random"
        }
    }
    
    var parameters: [URLQueryItem] {
            switch self {
            case .getData:
                return [
//                    URLQueryItem(name: "X-API-KEY", value: "4M53ACZ-MH849JV-JHNG3HV-ZH0RAJW"),
                ]
            }
        }
    
    // Добавьте свойство headers, чтобы передавать заголовки
    var headers: [String: String] {
        switch self {
        case .getData:
            return [
                "X-API-KEY": "4M53ACZ-MH849JV-JHNG3HV-ZH0RAJW",
                // Добавьте другие заголовки, если необходимо
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
