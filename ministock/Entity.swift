import UIKit

struct Stocks: Decodable {
    let output: [Stock]
    enum CodingKeys: String, CodingKey{
        case output = "output1"
    }
}
struct Stock: Decodable {
    let account: String
    let returnPer: String
    let name: String
    let price: String
    let code: String
    enum CodingKeys: String, CodingKey {
        case account = "cano"
        case name = "ovrs_item_name"
        case returnPer = "evlu_pfls_rt"
        case price = "now_pric2"
        case code = "ovrs_pdno"
    }
}
