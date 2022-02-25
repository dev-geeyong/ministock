
import UIKit

struct IncreaseModel: Codable {
    
    let stockName : String
    let stockCode : String
    let percentChange: String
    let currentPrice: Int
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        
        case stockName  = "stockName"
        case stockCode = "stockCode"
        case percentChange = "percentChange"
        case currentPrice = "currentPrice"
        case imageURL = "imageURL"

    }
    

}
