//
//  Service.swift
//  ministock
//
//  Created by 윤지용 on 2022/03/08.
//

import UIKit

class Service {

    let repository = Repository()
    
    func entityToModel(completion: @escaping ([Model])->Void){
        var models = [Model]()
        repository.APIRequest { entities in
            
            for entity in entities{
                let currentPrice = "\(entity.currentPrice)".insertComma + "원"
                let percentChange = "+" + String(format: "%.2f", Double(entity.percentChange)) + "%"
                print(entity)
                let model = Model(stockName: entity.stockName, subStockName: entity.stockName, percent: percentChange, price: currentPrice, image: entity.imageURL)
                models.append(model)
                
            }
            completion(models)
        }
    }

    @objc func cameraButtonDidPress (_ sender:UIButton){

        print("->")
    }
}
