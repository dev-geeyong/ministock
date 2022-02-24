//
//  AlamofireManager.swift
//  ministock
//
//  Created by 윤지용 on 2022/02/24.
//

import UIKit
import Alamofire

enum MyError: String,Error {
    case noData = "데이터가 없습니다."
}


class AlamofireManager{
    static let shared = AlamofireManager()
    let url = "https://boiling-scrubland-57180.herokuapp.com/increase-list"
    
        func getTest(completion: @escaping(Result<[IncreaseModel],Error>)->Void) {
            let list = [IncreaseModel]()
            AF.request(url)
                .responseJSON { reponse in
                    guard let responseValue = reponse.value as? [String: Any]  else {return }
                    print(responseValue)
                    completion(.success(list))

                    
                }
         }
}



//test
//self.session
//    .request(MySearchRouter.getVocaApi)
//    .responseJSON { (response) in
//        guard let reponseValue = response.value as? [String: Any] else { completion(.failure(.noData)); return }
//
//        if let JSONs = reponseValue["list"] as? [[String: Any]] {
//            for JSON in JSONs {
//                if let data = try? JSONDecoder().decode(Voca.self, from: JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted)){
//
//                    datas.append(data)
//                }
//            }
//        }
//
//        if datas.count>0{
//            completion(.success(datas))
//        }else{
//            print("-> failure")
//            completion(.failure(.noData))
//        }
//    }
//



