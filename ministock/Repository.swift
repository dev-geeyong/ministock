import UIKit
import Alamofire


class Repository {
    
    static let shared = Repository()
    let url = "https://boiling-scrubland-57180.herokuapp.com/dividend-list"
//https://boiling-scrubland-57180.herokuapp.com/dividend-list
    func APIRequest(completion: @escaping([Entity])->Void){
        AF.request(url)
            .responseDecodable(of: [Entity].self) { response in
                switch response.result{
                case .success(let result):
                    print("->result",result)
                    completion(result)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
