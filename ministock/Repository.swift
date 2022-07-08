import UIKit
import Alamofire


class Repository {
    let parameter = [
        "CANO" : "63221397",
        "ACNT_PRDT_CD":"01",
        "OVRS_EXCG_CD": "NASD",
        "TR_CRCY_CD": "USD",
        "CTX_AREA_FK200": "",
        "CTX_AREA_NK200": ""
    ]
    let headers: HTTPHeaders = [
        "authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsImF1ZCI6IjA3MDY3ZmM4LWM4ODMtNGZjMC1iMmY1LWYyYWJhMjQ3MWRmOCIsImlzcyI6InVub2d3IiwiZXhwIjoxNjU3MzQwOTY1LCJpYXQiOjE2NTcyNTQ1NjUsImp0aSI6IlBTUHVEUWVJSDFWeXF1OFBNQWlVeUlGd0RnbXY3U0ExY3JEVyJ9.gqzDdY74nd82fzSzVUedFOPnM24AsxxSMQXDrzjiv-SQ6yLF9FZUlqPl4IkYEwuDUSDwYgUtnXe7nwnpUpfHig",
        "appkey" : "PSPuDQeIH1Vyqu8PMAiUyIFwDgmv7SA1crDW",
        "appsecret" : "R3UR7aLSAAg9ZGx22O8TtKZY7KVt1FR7VgMyib/rKSDsz9y1GJVtJ0HrYm8xRh/4wHrvhsBAj1suFIChvRxmQyTodLy6+owD3peSpY4fqtqpJ+gtmdJbg8yQ/WZ6I1bu+KpRL6C+Mmz7gB2g9lcTvXjj5/FnE3wAZWXJGAe8QnnD2WTYAhw=",
        "tr_id" : "JTTT3012R",
        "Content-Type":"application/json"
    ]
    
    static let shared = Repository()
    let url = "https://openapi.koreainvestment.com:9443/uapi/overseas-stock/v1/trading/inquire-balance"
    func APIRequest(completion: @escaping(Stocks) -> Void){
        AF.request(url,
                   method: .get,
                   parameters: parameter,
                   encoding: URLEncoding.default,
                   headers: headers
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
