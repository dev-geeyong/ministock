import UIKit
import Alamofire


class AlamofireManager {
    
    static let shared = AlamofireManager()
    let url = "https://boiling-scrubland-57180.herokuapp.com/dividend-list"
//https://boiling-scrubland-57180.herokuapp.com/dividend-list
    //increase-list
    func getData(completion: @escaping (_ result : [DividendElement])->(Void)){
        var datas = [DividendElement]()
        AF.request(url).responseJSON { response in
            
            switch response.result {
            case .success(_):
                do{
                    print(response.value)
                    if let data = response.data{
                        if let res = try? JSONDecoder().decode([DividendElement].self, from: data){
                            for i in res{
                                datas.append(i)
                            }
                            completion(datas)
                        }
                    }
                }catch{
                    print(error)
                }
                break
            case .failure(let error):
                print(error)
                break
                
            }
        }
    }
}

