import Foundation

struct StrategyModel: Codable {
    let hasErrors: Bool
    let items: [Strategy]
}

// MARK: - Item
struct Strategy: Codable {
    let modelTitle, modelTimeframe, modelContent: String
    let modelImages: [String]
    let modelCreatedAt: String
    var isRead = false

    enum CodingKeys: String, CodingKey {
        case modelTitle = "model_title"
        case modelTimeframe = "model_timeframe"
        case modelContent = "model_content"
        case modelImages = "model_images"
        case modelCreatedAt = "model_created_at"
    }
}
