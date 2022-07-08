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
