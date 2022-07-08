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
            print(entities.output1.count)
            entities.output1.forEach {
                let model = Model(account: $0.account, returnPer: $0.returnPer, name: $0.name)
                models.append(model)
            }
            completion(models)
        }
    }

    @objc func cameraButtonDidPress (_ sender:UIButton){

        print("->")
    }
}
