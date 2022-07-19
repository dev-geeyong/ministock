//
//  MainViewController.swift
//  ministock
//
//  Created by IT on 2022/02/15.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit
import FirebaseCore
import FirebaseFirestore
import FirebaseMessaging
import SwiftUI

class MainViewController: UIViewController {
    //MARK: - Propertie
    private lazy var category = ["상승","zzxczxc하락","조회급등","인기검색","배당","시가총액"]
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .systemGray6
        return sv
    }()
    private lazy var contentView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemGray6
        return uv
    }()
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [carouselBackView,
                                                favoriteStockBackView,
                                                stocksBackView,
                                                dividendStocksBackView,
                                                exchangeRateBackView])
        sv.axis = .vertical
        return sv
    }()
    private lazy var carouselBackView = CarouselBackView()
    private lazy var favoriteStockBackView = FavoriteStockBackView()
    private lazy var stocksBackView = StocksBackView()
    private lazy var dividendStocksBackView = DividendStocksBackView()
    private lazy var exchangeRateBackView = ExchangeRateBackView()
    let url = NSURL(string: "https://fcm.googleapis.com/fcm/send")
    
    var db: Firestore? = Firestore.firestore()
    var ref: DocumentReference? = nil
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        favoriteStockBackView.cellDelegate = self
        stocksBackView.pushDelegate = self
        stocksBackView.showDelegate = self
        dividendStocksBackView.delegate = self
        test()
        Messaging.messaging().subscribe(toTopic: "weather") { error in
          print("Subscribed to weather topic")
        }
        // Add a new document with a generated ID
        
        //        ref = db!.collection("users").addDocument(data: [
        //            "test": "test",
        //        ]) { err in
        //            if let err = err {
        //                print("Error adding document: \(err)")
        //            } else {
        //                print("Document added with ID: \(self.ref!.documentID)")
        //                UserDefaults.standard.set(self.ref!.documentID, forKey: "documentID")
        //            }
        //        }
        //        print("->?!",UserDefaults.standard.string(forKey: "documentID"))
        
        initLayout()
    }
    //MARK: - Helpers
    func initLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.top.bottom.equalTo(scrollView)
        }
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    func test(){
        let serverKey = "AAAAbViq_Kk:APA91bGPS1soZHMD-d9CLth5DImX1dBXau6LHt_lomkLDSfskS9Wghc56T6X8VLbU2EkllxzSMHLWYf9sQcwEguR6jr77IUNrLKFE558YBnhQJLXlk3x52Xut6SOpHN7WKAd_rxsZD1S"
        let partnerToken = "cjYmUHM3G0R_vkIQRaQ8s5:APA91bHWRkLBwYSEk5lBmU2CNHFZ8WtIMOLbgwYrxZQZDZjsR_UKR6l8UPLnZeotA1rppaEQq06nfrUzxXmQVJpz04hlpSchRfPYOBCdzL4MvcK-TgJ4H9mTEeZet-7F6YjWSwBmViaM"
        let url = NSURL(string: "https://fcm.googleapis.com/fcm/send")
        let postParams = [
            "to": partnerToken,
            "notification": [
                "body": "This is the body.",
                "title": "This is the title.",
                "sound" : true, // or specify audio name to play
                "click_action" : "🚀", // action when user click notification (categoryIdentifier)
            ]] as [String : Any]
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postParams, options: JSONSerialization.WritingOptions())
            print("My paramaters: \(postParams)")
        } catch {
            print("Caught an error: \(error)")
        }
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if let realResponse = response as? HTTPURLResponse {
                if realResponse.statusCode != 200 {
                    print("Not a 200 response")
                }
            }
            
            if let postString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as String? {
                print("POST: \(postString)")
            }
        }
        
        task.resume()
    }
}
//MARK: - Actions
extension MainViewController: PushNavgationDelegate{
    func pushButtonTapped() {
        let nv = AccountViewController()
        self.navigationController?.pushViewController(nv, animated: true)
    }
}
extension MainViewController: ShowBottomSheetDelegate{
    func pushButtonTapped2() {
        let popUpViewController = PopUpViewController()
        popUpViewController.modalPresentationStyle = .overFullScreen
        present(popUpViewController, animated: false, completion: nil)
    }
}
//PrewViewProvider 연결!
struct MainViewController_Previews: PreviewProvider {
    
    //프리뷰
    static var previews: some View {
        container().edgesIgnoringSafeArea(.all)
    }
    
    //프리뷰 보여줄 ViewController 지정
    struct container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let mainViewController = MainViewController()
            return UINavigationController(rootViewController: mainViewController)
        }
        
        //호출해야하는 함수라 비워두어도 괜찮다능
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
        
        //타입알리아스는 UIViewController로
        typealias UIViewControllerType = UIViewController
    }
    
}
