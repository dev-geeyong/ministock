//
//  Model.swift
//  ministock
//
//  Created by 윤지용 on 2022/03/08.
//

import UIKit

struct Model{
    var stockName: String
    var subStockName: String
    var percent: String
    var price: String
    var image: String
}

//해외주식 잔고

struct Stocks: Decodable {
//    let msg: String
    let output1: [Stock]
    
}


struct Stock: Decodable{
    
    let account: String
    let price: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case account = "cano"
        case name = "ovrs_item_name"
        case price = "evlu_pfls_rt"
    }
}

extension Stock: Displayable{
    
    var ShowName: String{
        "종목명 : \(name)"
    }
    var ShowPrice: String{
        "\(price)원"
    }
    
}
