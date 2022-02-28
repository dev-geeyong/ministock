//
//  DividendViewModel.swift
//  ministock
//
//  Created by 윤지용 on 2022/02/28.
//

import UIKit

struct DividendViewModel{
    var apiData: DividendElement
    
    var image: URL?{
        if let url = URL(string: "\(apiData.imageURL)"){
            return url
        }else{
            return nil
        }
        
    }
    var name: String{
        return apiData.stockName
    }
    
    var percent: String{
        let percent =  String(format: "%.2f", Double(apiData.percentChange))
        return "연 \(percent)%"
    }
    
    var price: String{
        
        return "\(apiData.currentPrice)".insertComma
    }
    
    var date: String{
        
        return "\(apiData.exDividendDate) 배당락"
    }
}
