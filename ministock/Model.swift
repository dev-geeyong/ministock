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

struct Stocks: Decodable {
//    let msg: String
    let output: Stock
    
}


struct Stock: Decodable{
    
    let name: String
    let price: String
    
    enum CodingKeys: String, CodingKey {
        case name = "bstp_kor_isnm"
        case price = "stck_prpr"
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
