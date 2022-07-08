//
//  ViewController.swift
//  ministock
//
//  Created by IT on 2022/02/15.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit

class MainViewController: UIViewController {
    //MARK: - Propertie
    
    let service = Service()
    var apiData = [Model](){
        didSet{

//            self.dividendCollectionView.reloadData()
//            UIView.transition(with: stocksTableView, duration: 0.3, options: .transitionCrossDissolve, animations: {self.stocksTableView.reloadData()}, completion: nil)
        }
    }
    var category = ["상승","하락","조회급등","인기검색","배당","시가총액"]
    
    
    private let scrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.backgroundColor = .systemGray6
        return sv
    }()
    
    private let contentView: UIView = {
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
    
    private let carouselBackView = CarouselBackView()
    private let carouselCollectionView = CarouselBackView().carouselCollectionView
    private let favoriteStockBackView = FavoriteStockBackView()
    private let stocksBackView = StocksBackView()
    private let dividendStocksBackView = DividendStocksBackView()
    private let exchangeRateBackView = ExchangeRateBackView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteStockBackView.cellDelegate = self
        stocksBackView.pushDelegate = self
        stocksBackView.showDelegate = self
        dividendStocksBackView.delegate = self
        
        initLayout()
        let pa = [
            "CANO" : "63221397",
            "ACNT_PRDT_CD":"01",
            "OVRS_EXCG_CD": "NASD",
            "TR_CRCY_CD": "USD",
            "CTX_AREA_FK200": "",
            "CTX_AREA_NK200": ""
        ]
        
        
        let headers: HTTPHeaders = [
            "authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsImF1ZCI6ImQ3M2MxMWY4LTA0MTgtNGQxZS05ZDE2LTQzMGI0OTQ4NGNhMyIsImlzcyI6InVub2d3IiwiZXhwIjoxNjU3MjUzNjYzLCJpYXQiOjE2NTcxNjcyNjMsImp0aSI6IlBTUHVEUWVJSDFWeXF1OFBNQWlVeUlGd0RnbXY3U0ExY3JEVyJ9.MAc6v6NbeUeKwgMyMne2O6QBonPvHxnAHrP9SeoiizzIbp0awhsitHkrCobL7xfZZkBRt8ZRsM1kQpE69b1OaA",
            "appkey" : "PSPuDQeIH1Vyqu8PMAiUyIFwDgmv7SA1crDW",
            "appsecret" : "R3UR7aLSAAg9ZGx22O8TtKZY7KVt1FR7VgMyib/rKSDsz9y1GJVtJ0HrYm8xRh/4wHrvhsBAj1suFIChvRxmQyTodLy6+owD3peSpY4fqtqpJ+gtmdJbg8yQ/WZ6I1bu+KpRL6C+Mmz7gB2g9lcTvXjj5/FnE3wAZWXJGAe8QnnD2WTYAhw=",
            "tr_id" : "JTTT3012R",
            "Content-Type":"application/json"
        ]

        AF.request("https://openapi.koreainvestment.com:9443/uapi/overseas-stock/v1/trading/inquire-balance", method: .get, parameters: pa, encoding: URLEncoding.default, headers: headers).responseJSON{ response in
            
            print("->",response)
        }
//            switch response.result {
//            case .success(let test):
//                print("->",test.output.ShowName, test.output.ShowPrice)
//            case .failure(let error):
//                print(error)
//            default:
//                return
//            }
        
        
    }
    //MARK: - Actions
    
    //MARK: - Helpers
    
    func initLayout(){
    
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.centerX.width.top.bottom.equalToSuperview()
        }
   
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.centerX.width.top.bottom.equalTo(scrollView)
        }
    
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.left.right.bottom.height.equalTo(contentView)
        }
    }
}

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
