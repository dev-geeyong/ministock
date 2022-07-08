//
//  Model.swift
//  ministock
//
//  Created by 윤지용 on 2022/03/08.
//

import UIKit

struct Model{
    var account: String
    var returnPer: String
    var price: String
    var name: String
}

//해외주식 잔고

struct Stocks: Decodable {
//    let msg: String
    let output: [Stock]
    
    enum CodingKeys: String, CodingKey{
        case output = "output1"
    }
}

struct Stock: Decodable{
    
    let account: String
    let returnPer: String
    let name: String
    let price: String
    
    enum CodingKeys: String, CodingKey {
        case account = "cano"
        case name = "ovrs_item_name"
        case returnPer = "evlu_pfls_rt"
        case price = "now_pric2"
    }
}

extension Model{
    var setColor: UIColor {
        returnPer.first == "-" ? .blue : .red
    }
    var setReturn: String{
        "\(returnPer)%"
    }
    var setPrice: String{
        "$\(Double(price)!)"
    }
}
