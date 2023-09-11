import Foundation

protocol Endpoint {
    var scheme: String { get }
    var baseURl: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var headers: [String: String] { get }
    var method: String { get }
}
