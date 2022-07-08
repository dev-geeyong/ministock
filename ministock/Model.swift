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
    var name: String
}

//해외주식 잔고

struct Stocks: Decodable {
//    let msg: String
    let output1: [Stock]
    
}


struct Stock: Decodable{
    
    let account: String
    let returnPer: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case account = "cano"
        case name = "ovrs_item_name"
        case returnPer = "evlu_pfls_rt"
    }
}

extension Model: Displayable{
    
//    var ShowName: String{
//        "종목명 : \(name)"
//    }
    var redOrBlue: UIColor {
        returnPer.first == "-" ? .blue : .red
    }
    var ShowReturn: String{
        "\(returnPer)%"
    }
    
}
