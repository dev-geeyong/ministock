//
//  Model.swift
//  ministock
//
//  Created by 윤지용 on 2022/03/08.
//

import UIKit

struct Model {
    var account: String
    var returnPer: String
    var price: String
    var name: String
    var code: String
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
