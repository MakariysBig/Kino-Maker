import Foundation

struct ServiceStatus: Codable {
    let status: String
    let info: [String: EndpointStatus]
    let details: [String: EndpointStatus]
}

struct EndpointStatus: Codable {
    let status: String
}
