
import UIKit

struct IncreaseModel: Codable {
    
}
struct IncloreElement: Codable {
    let stockName: String
    let currentPrice: Int
    let stockQuantity: Double
    let valueChange: Int
    let percentChange: Double
    let imageURL: String
    
}
struct DividendElement: Codable {
    let stockName: String
    let currentPrice: Int
    let percentChange: Double
    let imageURL: String
    let exDividendDate: String
}
struct IncreaseElement: Codable {
    let stockName: String
    let stockCode: StockCode
    let increasePercentChange: Double
    let currentPrice: Int
    let imageURL: String
    let percentChange: Double

    enum CodingKeys: String, CodingKey {
        case stockName, stockCode
        case increasePercentChange = "percentChange:"
        case currentPrice, imageURL, percentChange
    }
}

enum StockCode: String, Codable {
    case aaa = "AAA"
}

typealias Increase = [IncreaseElement]
