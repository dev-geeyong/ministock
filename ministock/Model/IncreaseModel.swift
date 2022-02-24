
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
            
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.stockName = try values.decode(String.self, forKey: .stockName)
        self.stockCode = try values.decode(String.self, forKey: .stockCode)
        self.percentChange = try values.decode(String.self, forKey: .percentChange)
        self.currentPrice = try values.decode(Int.self, forKey: .currentPrice)
        self.imageURL = try values.decode(String.self, forKey: .imageURL)

    }

}
