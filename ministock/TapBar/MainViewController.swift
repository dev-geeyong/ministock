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

            self.dividendCollectionView.reloadData()
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
    
    //MARK: - carouselBackView
    private let carouselBackView = CarouselBackView()
    private let carouselCollectionView = CarouselBackView().carouselCollectionView

    //MARK: - favoriteStockBackView
    private let favoriteStockBackView = FavoriteStockBackView()
    

    //MARK: - stocksBackView
    private let stocksBackView = StocksBackView()
    
    //MARK: - dividendStocksBackView
    private let dividendStocksBackView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemMint
        uv.heightAnchor.constraint(equalToConstant: 250).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    private let dividendCollectionBackView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .clear
        uv.heightAnchor.constraint(equalToConstant: 160).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    private let dividendTitleLabel: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "은행 이자 부럽지 않은 배당"
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.textColor = .white
        return lb
    }()
    private let dividendSubTitleLabel: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "지금 사면 배당받는 주식!"
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = .white
        return lb
    }()
    
    private lazy var dividendQuestionBtn: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("미국 배당락일 기준 ", for: .normal)
        let config = UIImage.SymbolConfiguration(
            pointSize: 13, weight: .regular, scale: .default)
        let image = UIImage(systemName: "questionmark.circle", withConfiguration: config)
        bt.setImage(image, for: .normal)
        bt.tintColor = .systemGray6
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.semanticContentAttribute = .forceRightToLeft
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        bt.addTarget(self, action: #selector(btnActions), for: .touchUpInside)
        bt.contentHorizontalAlignment = .left;
        
        return bt
    }()
    private let dividendCollectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.clipsToBounds = true
        collectionView.layer.cornerRadius = 5
        
        return collectionView
    }()
    
    //MARK: - exchangeRateBackView
    private let exchangeRateBackView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemGray6
        uv.heightAnchor.constraint(equalToConstant: 200).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    private let exchangeRateInView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        uv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    private let exchangeRateLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.text = "원달러 환율"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    private let exchangeRateDateLabel: UILabel = {
        let lb = UILabel()
        lb.text = "2월 22일 최초고시환율"
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = .systemGray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    private let currentExchangeRateLabel: UILabel = {
        let lb = UILabel()
        lb.text = "1,194.60원"
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textColor = .black
        lb.textAlignment = .right
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    private let percentChangeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "+1.18%"
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.textColor = .red
        lb.textAlignment = .right
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AlamofireManager.shared.getData { result in
            self.apiData = result
        }
        
        initLayout()
        initTableViewAndCollectionView()
        carouselBackView.startAutoCarouselScroll()
        
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
        
        //MARK: addsubView - stocksBackView
        
//        stocksBackView.addSubview(stocksCategoryView)
//        stocksCategoryView.snp.makeConstraints { make in
//            make.top.left.right.equalTo(stocksBackView)
//        }
      
//        stocksBackView.addSubview(stocksCategoryUnderLineView)
//        stocksCategoryUnderLineView.snp.makeConstraints { make in
//            make.top.equalTo(stocksCategoryView.snp.bottom)
//            make.left.equalTo(stocksCategoryView.snp.left)
//            make.right.equalTo(stocksCategoryView.snp.right)
//        }
//
        
//        stocksBackView.addSubview(stocksCategoryFilterView)
//        stocksCategoryFilterView.snp.makeConstraints { make in
//            make.top.equalTo(stocksCategoryUnderLineView.snp.bottom)
//            make.leading.trailing.equalTo(stocksCategoryUnderLineView)
//        }
        
       
        //MARK: addsubView - dividendStocksBackView
        
        dividendStocksBackView.addSubview(dividendCollectionBackView)
        dividendCollectionBackView.snp.makeConstraints { make in
            make.leading.equalTo(dividendStocksBackView).offset(25)
            make.bottom.equalTo(dividendStocksBackView).offset(-25)
            make.trailing.equalTo(dividendStocksBackView)
        }
        
        dividendStocksBackView.addSubview(dividendTitleLabel)
        dividendTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dividendStocksBackView).offset(15)
            make.leading.equalTo(dividendStocksBackView).offset(25)
        }
        
        dividendStocksBackView.addSubview(dividendSubTitleLabel)
        dividendSubTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dividendTitleLabel.snp.bottom)
            make.leading.equalTo(dividendTitleLabel.snp.leading)
        }
        
        dividendStocksBackView.addSubview(dividendQuestionBtn)
        dividendQuestionBtn.snp.makeConstraints { make in
            make.top.equalTo(dividendTitleLabel.snp.top)
            make.trailing.equalTo(dividendStocksBackView.snp.trailing).offset(-20)
        }
        
        //MARK: addsubView - exchangeRateInView
        
        exchangeRateBackView.addSubview(exchangeRateInView)
        exchangeRateInView.snp.makeConstraints { make in
            make.top.equalTo(exchangeRateBackView.snp.top).offset(15)
            make.leading.trailing.equalTo(exchangeRateBackView)
        }
        
        exchangeRateInView.addSubview(exchangeRateLabel)
        exchangeRateLabel.snp.makeConstraints {
            $0.centerY.equalTo(exchangeRateInView).offset(-10)
            $0.leading.equalTo(exchangeRateInView).offset(25)
        }
        
        exchangeRateInView.addSubview(exchangeRateDateLabel)
        exchangeRateDateLabel.snp.makeConstraints { make in
            make.top.equalTo(exchangeRateLabel.snp.bottom)
            make.leading.equalTo(exchangeRateLabel)
        }
        
        exchangeRateInView.addSubview(currentExchangeRateLabel)
        currentExchangeRateLabel.snp.makeConstraints { make in
            make.top.equalTo(exchangeRateLabel)
            make.trailing.equalTo(exchangeRateInView.snp.trailing).offset(-25)
        }
        
        exchangeRateInView.addSubview(percentChangeLabel)
        percentChangeLabel.snp.makeConstraints { make in
            make.top.equalTo(currentExchangeRateLabel.snp.bottom)
            make.trailing.equalTo(currentExchangeRateLabel.snp.trailing)
        }
    }
    func initTableViewAndCollectionView(){
        

        

        
        //------------------------------------------------
        

        
        //------------------------------------------------
        


        
        //------------------------------------------------
        
        dividendCollectionView.dataSource = self
        dividendCollectionView.delegate = self
        dividendCollectionView.register(DividendCollectionViewCell.self, forCellWithReuseIdentifier: "DividendCollectionViewCell")
        dividendCollectionView.isPagingEnabled = true
        dividendCollectionView.showsHorizontalScrollIndicator = false
        dividendCollectionBackView.addSubview(dividendCollectionView)
        
        dividendCollectionView.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalTo(dividendCollectionBackView)
        }
    }

}

extension MainViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      if collectionView == dividendCollectionView{
            return apiData.count
        }
//        else if collectionView == carouselCollectionView{
//            return 4
//        }
        else{ return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DividendCollectionViewCell", for: indexPath) as? DividendCollectionViewCell else{ return UICollectionViewCell()}
            cell.viewModel = DividendViewModel(apiData: self.apiData[indexPath.item])
            return cell
      
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = 0.0
        var height = 0.0
        
        
            width = dividendCollectionBackView.frame.width / 3.0 + 10
            height = collectionView.bounds.height
    
        
        return CGSize.init(width: width, height: height)
    }
    
    //section 내부 cell간의 공간을 제거
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        if collectionView == carouselCollectionView{return 0}
        if collectionView == dividendCollectionView {return 5}
        else{return 0}
    }
    
    //section 사이의 공간을 제거
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    
}



extension MainViewController : UIScrollViewDelegate {
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let pageWidth = scrollView.frame.size.width
//        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
//        self.currentIdx = page
//
//    }
}

