import UIKit
import Alamofire


class Repository {

    
    static let shared = Repository()
    let keys = KeyValues()
    let url = "https://openapi.koreainvestment.com:9443/uapi/overseas-stock/v1/trading/inquire-balance"
    func APIRequest(completion: @escaping(Stocks) -> Void){
        AF.request(url,
                   method: .get,
                   parameters: keys.parameter,
                   encoding: URLEncoding.default,
                   headers: keys.headers
        )
            .responseDecodable(of: Stocks.self) { response in
            switch response.result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print(error)
            }
        }
    }
}
