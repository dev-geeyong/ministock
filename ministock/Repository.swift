import UIKit
import Alamofire

class Repository {
    static let shared = Repository()
    let keys = KeyValues()
    let getToken = GetToken()
    let url = "https://openapi.koreainvestment.com:9443/uapi/overseas-stock/v1/trading/inquire-balance"
    
    func APIRequest(completion: @escaping(Stocks) -> Void) {
        getToken.tokenCheck()
        
        if UserDefaults.standard.string(forKey: "tokenValue1") == nil { //토큰이 없다..
            getToken.tokenApiRequest { tt in
                if let test = tt {
                    print("->testr4444444",test)
                    UserDefaults.standard.set(test, forKey: "tokenValue1")

                    self.keys.changeToken(to: test)
                    self.keys.setHeaders()
                    AF.request(self.url,
                               method: .get,
                               parameters: self.keys.parameter,
                               encoding: URLEncoding.default,
                               headers: self.keys.headers
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
        }else{
            self.keys.setHeaders()
            AF.request(self.url,
                       method: .get,
                       parameters: self.keys.parameter,
                       encoding: URLEncoding.default,
                       headers: self.keys.headers
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
}
