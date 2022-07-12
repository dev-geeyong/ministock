//
//  Service.swift
//  ministock
//
//  Created by 윤지용 on 2022/03/08.
//

import UIKit

class Service {
    let repository = Repository()
    func entityToModel(completion: @escaping ([Model])->Void) {
        var models = [Model]()
        repository.APIRequest { entities in
            entities.output.forEach {
                let model = Model(account: $0.account,
                                  returnPer: $0.returnPer,
                                  price: $0.price,
                                  name: $0.name,
                                  code: $0.code)
                models.append(model)
            }
            completion(models)
        }
    }
}
