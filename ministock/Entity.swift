
import UIKit

struct Entity: Codable {
    let stockName: String
    let currentPrice: Int
    let percentChange: Double
    let imageURL: String
    let exDividendDate: String
}
