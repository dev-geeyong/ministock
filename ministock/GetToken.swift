//
//  GetToken.swift
//  ministock
//
//  Created by 윤지용 on 2022/07/15.
//


import UIKit
import Alamofire

class GetToken {
    static let shared = GetToken()
    var tt = ""
    let tokenParameter = [
        "grant_type": "client_credentials",
        "appkey": "PSPuDQeIH1Vyqu8PMAiUyIFwDgmv7SA1crDW",
        "appsecret": "R3UR7aLSAAg9ZGx22O8TtKZY7KVt1FR7VgMyib/rKSDsz9y1GJVtJ0HrYm8xRh/4wHrvhsBAj1suFIChvRxmQyTodLy6+owD3peSpY4fqtqpJ+gtmdJbg8yQ/WZ6I1bu+KpRL6C+Mmz7gB2g9lcTvXjj5/FnE3wAZWXJGAe8QnnD2WTYAhw="
    ]

    let tokenUrl = "https://openapi.koreainvestment.com:9443/oauth2/tokenP"

    func tokenApiRequest(completion: @escaping(String?) -> (Void)) {
        AF.request(tokenUrl,
                   method: .post,
                   parameters: tokenParameter,
                   encoding: JSONEncoding.default)
            .responseDecodable(of: Token.self) { response in
                switch response.result {
                case .success(let result):
                    completion(result.token)
                case .failure(let error):
                    print("\(error)")
                }
            }
    }
    func tokenCheck() -> Bool {
        UserDefaults.standard.set(Date(), forKey: "key")
        print("->date",UserDefaults.standard.object(forKey: "key") as! Date)
        print("->date2",Date())
        return UserDefaults.standard.object(forKey: "key") as! Date > Date()


//        if UserDefaults.standard.string(forKey: "tokenData") == nil {
//
//        }else{
//
//        }
    }
}
