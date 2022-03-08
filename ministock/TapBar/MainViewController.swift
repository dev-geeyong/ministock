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
    var apiData = [DividendElement](){
        didSet{

//            self.dividendCollectionView.reloadData()
//            UIView.transition(with: stocksTableView, duration: 0.3, options: .transitionCrossDissolve, animations: {self.stocksTableView.reloadData()}, completion: nil)
        }
    }
    var category = ["상승","하락","조회급등","인기검색","배당","시가총액"]
    
    
    private let scrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.backgroundColor = .systemGray6
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentView: UIView = {
       let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
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
        sv.translatesAutoresizingMaskIntoConstraints = false
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
        
        AlamofireManager.shared.getData { result in
            self.apiData = result
        }
        initLayout()
        
    }
    //MARK: - Actions
    @objc func btnActions(sender: UIButton){
        print("->acc",sender)
        let popUpViewController = PopUpViewController()
        popUpViewController.modalPresentationStyle = .overFullScreen
        present(popUpViewController, animated: false, completion: nil)
    }
    @objc func pushView(){
        let nv = AccountViewController()
        self.navigationController?.pushViewController(nv, animated: true)
    }
    //MARK: - Helpers
    
    func initLayout(){
    
        //MARK: addsubView - scrollView
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
