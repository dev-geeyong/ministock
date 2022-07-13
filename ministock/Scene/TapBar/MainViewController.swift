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

class MainViewController: UIViewController {
    //MARK: - Propertie
    private lazy var category = ["상승","하락","조회급등","인기검색","배당","시가총액"]
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
    var db: Firestore? = Firestore.firestore()
    var ref: DocumentReference? = nil
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteStockBackView.cellDelegate = self
        stocksBackView.pushDelegate = self
        stocksBackView.showDelegate = self
        dividendStocksBackView.delegate = self
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
        let docRef = db!.collection("users").document(UserDefaults.standard.string(forKey: "documentID")!)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("->Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
        
        db!.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if let test = UserDefaults.standard.string(forKey: "documentID"){
                        if test == document.documentID {
                            print("->document.data()",document.data())
                        }
                    }
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        //https://firebase.google.com/docs/firestore/query-data/get-data
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
