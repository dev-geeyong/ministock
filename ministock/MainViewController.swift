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
            UIView.transition(with: stocksTableView, duration: 0.3, options: .transitionCrossDissolve, animations: {self.stocksTableView.reloadData()}, completion: nil)
        }
    }
    var category = ["상승","하락","조회급등","인기검색","배당","시가총액"]
    private var currentIdx: Int = 0
    
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
    private let carouselBackView: UIView = {
        let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return uv
    }()
    private let carouselCollectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    //MARK: - favoriteStockBackView
    private let favoriteStockBackView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemGray6
        uv.heightAnchor.constraint(equalToConstant: 220).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    private let favoriteInView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    private let favoriteTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "관심 주식"
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    private let favoriteStockTableView = UITableView(frame: .zero, style: .plain)
    private lazy var addFavoriteStockBtn: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("관심 주식 담기 및 관리", for: .normal)
        bt.setTitleColor(UIColor.black, for: .normal)
        bt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        bt.backgroundColor = .white
        bt.layer.cornerRadius = 5
        bt.layer.borderColor = UIColor.systemGray4.cgColor
        bt.layer.borderWidth = 1
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(pushView), for: .touchUpInside)
        return bt
    }()
    //MARK: - stocksBackView
    private let stocksBackView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        uv.heightAnchor.constraint(equalToConstant: 770).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    private let stocksCategoryView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .red
        uv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    private let stocksCategoryUnderLineView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemGray5
        uv.heightAnchor.constraint(equalToConstant: 1).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    private let stocksCategoryFilterView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        uv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    private let moreStockView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        uv.heightAnchor.constraint(equalToConstant: 70).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    private let categoryCollectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    private lazy var stocksCategoryFilterBtn: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("전일 기준 ", for: .normal)
        let config = UIImage.SymbolConfiguration(
            pointSize: 11, weight: .regular, scale: .default)
        let image = UIImage(systemName: "chevron.down", withConfiguration: config)
        bt.setImage(image, for: .normal)
        bt.tintColor = .systemGray
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.semanticContentAttribute = .forceRightToLeft
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        bt.addTarget(self, action: #selector(btnActions), for: .touchUpInside)
        bt.contentHorizontalAlignment = .left;
        return bt
    }()
    private lazy var stocksQuestionBtn: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("8시 기준 조회증가순 ", for: .normal)
        let config = UIImage.SymbolConfiguration(
            pointSize: 13, weight: .regular, scale: .default)
        let image = UIImage(systemName: "questionmark.circle", withConfiguration: config)
        bt.setImage(image, for: .normal)
        bt.tintColor = .systemGray
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.semanticContentAttribute = .forceRightToLeft
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        bt.addTarget(self, action: #selector(btnActions), for: .touchUpInside)
        bt.contentHorizontalAlignment = .left;
        bt.isHidden = true
        return bt
    }()
    private lazy var stocksEtfBtn: UIButton = {
        let bt = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular, scale: .default)
        let image = UIImage(systemName: "circle", withConfiguration: config)
        bt.setImage(image, for: .normal)
        bt.setTitle(" ETF만 보기", for: .normal)
        bt.tintColor = .systemGray
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        bt.addTarget(self, action: #selector(btnActions), for: .touchUpInside)
        bt.contentHorizontalAlignment = .right
        return bt
    }()
    private lazy var moreStocksBtn: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("더보기", for: .normal)
        bt.setTitleColor(UIColor.black, for: .normal)
        bt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        bt.backgroundColor = .white
        bt.layer.cornerRadius = 5
        bt.layer.borderColor = UIColor.systemGray4.cgColor
        bt.layer.borderWidth = 1
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(pushView), for: .touchUpInside)
        return bt
    }()
    private let stocksTableView = UITableView(frame: .zero, style: .plain)
    
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
        startAutoCarouselScroll()
        
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

        //MARK: addsubView - favoriteStockBackView
        favoriteStockBackView.addSubview(favoriteInView)
        favoriteInView.snp.makeConstraints { make in
            make.top.equalTo(favoriteStockBackView).offset(10)
            make.left.right.equalTo(favoriteStockBackView)
            make.bottom.equalTo(favoriteStockBackView).offset(-10)
        }
        
        favoriteInView.addSubview(favoriteTitleLabel)
        favoriteTitleLabel.snp.makeConstraints { make in
            make.top.left.equalTo(favoriteInView).offset(15)
        }
    
        favoriteInView.addSubview(addFavoriteStockBtn)
        addFavoriteStockBtn.snp.makeConstraints { make in
            make.left.equalTo(favoriteTitleLabel)
            make.bottom.equalTo(favoriteInView).offset(-15)
            make.right.equalTo(favoriteInView).offset(-10)
        }

        favoriteInView.addSubview(favoriteStockTableView)
        favoriteStockTableView.snp.makeConstraints { make in
            make.top.equalTo(favoriteTitleLabel.snp.bottom).offset(15)
            make.left.equalTo(favoriteTitleLabel)
            make.right.equalTo(favoriteInView)
            make.height.equalTo(60)
            
        }
        favoriteStockTableView.allowsSelection = false
        
        //MARK: addsubView - stocksBackView
        
        stocksBackView.addSubview(stocksCategoryView)
        stocksCategoryView.snp.makeConstraints { make in
            make.top.left.right.equalTo(stocksBackView)
        }
      
        stocksBackView.addSubview(stocksCategoryUnderLineView)
        stocksCategoryUnderLineView.snp.makeConstraints { make in
            make.top.equalTo(stocksCategoryView.snp.bottom)
            make.left.equalTo(stocksCategoryView.snp.left)
            make.right.equalTo(stocksCategoryView.snp.right)
        }
        
        
        stocksBackView.addSubview(stocksCategoryFilterView)
        stocksCategoryFilterView.snp.makeConstraints { make in
            make.top.equalTo(stocksCategoryUnderLineView.snp.bottom)
            make.leading.trailing.equalTo(stocksCategoryUnderLineView)
        }
        
        stocksCategoryFilterView.addSubview(stocksQuestionBtn)
        stocksQuestionBtn.snp.makeConstraints { make in
            make.leading.equalTo(stocksCategoryFilterView).offset(15)
            make.width.equalTo(130)
            make.centerY.height.equalTo(stocksCategoryFilterView)
        }
        
        stocksCategoryFilterView.addSubview(stocksCategoryFilterBtn)
        stocksCategoryFilterBtn.snp.makeConstraints { make in
            make.centerY.height.equalTo(stocksCategoryFilterView)
            make.leading.equalTo(stocksCategoryFilterView).offset(15)
            make.width.equalTo(130)
        }
        
        stocksCategoryFilterView.addSubview(stocksEtfBtn)
        stocksEtfBtn.snp.makeConstraints { make in
            make.trailing.equalTo(stocksCategoryFilterView).offset(-15)
            make.centerY.height.equalTo(stocksCategoryFilterView)
            make.width.equalTo(100)
            
        }
        
        stocksBackView.addSubview(moreStockView)
        moreStockView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(stocksBackView)
        }
        
        moreStockView.addSubview(moreStocksBtn)
        moreStocksBtn.snp.makeConstraints { make in
            make.top.equalTo(moreStockView).offset(10)
            make.bottom.equalTo(moreStockView).offset(-10)
            make.leading.equalTo(moreStockView).offset(15)
            make.trailing.equalTo(moreStockView).offset(-15)
        }
        
        stocksBackView.addSubview(stocksTableView)
        stocksTableView.snp.makeConstraints { make in
            make.top.equalTo(stocksCategoryFilterView.snp.bottom)
            make.leading.equalTo(stocksCategoryFilterView.snp.leading).offset(15)
            make.trailing.equalTo(stocksCategoryFilterView.snp.trailing)
            make.bottom.equalTo(moreStockView.snp.top)
            
        }
       
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
        exchangeRateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(exchangeRateInView).offset(-10)
            make.leading.equalTo(exchangeRateInView).offset(25)
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
        
        favoriteStockTableView.register(MyFavoriteTableViewCell.self, forCellReuseIdentifier: "MyFavoriteTableViewCell")
        favoriteStockTableView.delegate = self
        favoriteStockTableView.dataSource = self
        favoriteStockTableView.translatesAutoresizingMaskIntoConstraints = false
        favoriteStockTableView.rowHeight = 60
        favoriteStockTableView.separatorStyle = .none
        
        stocksTableView.register(MyFavoriteTableViewCell.self, forCellReuseIdentifier: "stocksTableView")
        stocksTableView.delegate = self
        stocksTableView.dataSource = self
        stocksTableView.translatesAutoresizingMaskIntoConstraints = false
        stocksTableView.rowHeight = 60
        stocksTableView.separatorStyle = .none
        stocksTableView.isScrollEnabled = false
        stocksTableView.allowsSelection = false
        
        //------------------------------------------------
        
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        carouselCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "carouselCollectionView")
        carouselCollectionView.showsHorizontalScrollIndicator = false
        carouselCollectionView.isPagingEnabled = true
        carouselBackView.addSubview(carouselCollectionView)
        
        carouselCollectionView.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalTo(carouselBackView)
        }
        
        //------------------------------------------------
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: "CategoryCollectionCell")
        categoryCollectionView.isPagingEnabled = true
        categoryCollectionView.showsHorizontalScrollIndicator = false
        stocksCategoryView.addSubview(categoryCollectionView)

        categoryCollectionView.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalTo(stocksCategoryView)
        }

        
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
    func startAutoCarouselScroll() {
        //전체 cell 개수
        let totalCellCount = carouselCollectionView
            .numberOfItems(inSection: 0)
        
        DispatchQueue.global(qos: .default).async {
            
            while true
            {
                //2초에 한 번씩 paging
                sleep(2)
                
                DispatchQueue.main.async {
                    self.carouselCollectionView.scrollToItem(at: IndexPath(item: self.currentIdx, section: 0), at: .right, animated: true)
                    
                    //다시 처음으로
                    if self.currentIdx == totalCellCount - 1 {
                        self.currentIdx = 0
                    }
                    else {
                        self.currentIdx += 1
                    }
                }
            }
            
        }
    }
}

extension MainViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView{
            return self.category.count
        }
        else if collectionView == dividendCollectionView{
            return apiData.count
        }
        else if collectionView == carouselCollectionView{
            return 4
        }
        else{ return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == carouselCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCollectionView", for: indexPath)
            return cell
        }
        else if collectionView == dividendCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DividendCollectionViewCell", for: indexPath) as? DividendCollectionViewCell else{ return UICollectionViewCell()}
            cell.viewModel = DividendViewModel(apiData: self.apiData[indexPath.item])
            return cell
        }
        else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as? CategoryCollectionCell else{return UICollectionViewCell()}
            if indexPath.item == 0 {
                cell.isSelected = true
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
                
            }
            
            if self.category.count > indexPath.item{
                
                cell.testLabel.text = self.category[indexPath.item]
                
                
            }
            
            return cell
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView{
            DispatchQueue.main.async {
                switch indexPath.row{
                case 0, 1:
                    self.stocksCategoryFilterBtn.isHidden = false
                    self.stocksQuestionBtn.isHidden = true
                    self.stocksEtfBtn.isHidden = false
                    self.stocksCategoryFilterBtn.setTitle("전일 기준 ", for: .normal)
                case 2:
                    self.stocksCategoryFilterBtn.isHidden = true
                    self.stocksQuestionBtn.isHidden = false
                    self.stocksQuestionBtn.setTitle("8시 기준 조회증가순 ", for: .normal)
                    self.stocksEtfBtn.isHidden = true
                    
                case 3:
                    self.stocksCategoryFilterBtn.isHidden = true
                    self.stocksQuestionBtn.isHidden = false
                    self.stocksQuestionBtn.setTitle("8시 기준 검색증가순 ", for: .normal)
                    self.stocksEtfBtn.isHidden = true

                case 4:
                    self.stocksCategoryFilterBtn.isHidden = false
                    self.stocksQuestionBtn.isHidden = true
                    self.stocksCategoryFilterBtn.setTitle("배당수익률순 ", for: .normal)
                    self.stocksEtfBtn.isHidden = true
                case 5:
                    self.stocksCategoryFilterBtn.isHidden = false
                    self.stocksQuestionBtn.isHidden = true
                    self.stocksCategoryFilterBtn.setTitle("시가 총액 ", for: .normal)
                    self.stocksEtfBtn.isHidden = true
                default:
                    print("")
                }
                
                if indexPath.row == 5 {
                    let rect = self.categoryCollectionView.layoutAttributesForItem(at: IndexPath(row: 5, section: 0))?.frame
                    self.categoryCollectionView.scrollRectToVisible(rect!, animated: true)
                }else{
                    self.categoryCollectionView.selectItem(at: IndexPath(item: indexPath.item, section: 0), animated: true, scrollPosition: .right)
                }
                
                AlamofireManager.shared.getData { result in
                    self.apiData.removeAll()
                    self.apiData = result
                }
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == carouselCollectionView{
            
            if indexPath.row == 0 {
                cell.backgroundColor = .red
            }
            else if indexPath.row == 1 {
                cell.backgroundColor = .blue
            }
            else if indexPath.row == 2 {
                cell.backgroundColor = .systemGreen
            }
            else if indexPath.row == 3 {
                cell.backgroundColor = .systemMint
            }
            else{
                cell.backgroundColor = .purple
            }
        }
        else if collectionView == dividendCollectionView {
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = 0.0
        var height = 0.0
        
        if collectionView == carouselCollectionView{
            width = collectionView.bounds.width
            height = collectionView.bounds.height
        }
        else if collectionView == dividendCollectionView{
            width = dividendCollectionBackView.frame.width / 3.0 + 10
            height = collectionView.bounds.height
        }
        else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as? CategoryCollectionCell else {
                return .zero
            }
            
            let cellWidth = cell.testLabel.frame.width + 15
            
            width = cellWidth
            
            height = collectionView.bounds.height
        }
        return CGSize.init(width: width, height: height)
    }
    
    //section 내부 cell간의 공간을 제거
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == carouselCollectionView{return 0}
        else if collectionView == dividendCollectionView {return 5}
        else{return 0}
    }
    
    //section 사이의 공간을 제거
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    
}



extension MainViewController : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        self.currentIdx = page
        
    }
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favoriteStockTableView == tableView{
            return 1
        }else{
            return self.apiData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == favoriteStockTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyFavoriteTableViewCell", for: indexPath) as! MyFavoriteTableViewCell?
            
            cell?.underLineView.isHidden = true
            cell?.companyNameLabel.text = "애플"
            cell?.stockImageView.image = UIImage(named: "apple")
            return cell!
            
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "stocksTableView", for: indexPath) as! MyFavoriteTableViewCell?
            if self.apiData.count > indexPath.row{
                
                let url = URL(string: "\(self.apiData[indexPath.row].imageURL)")
                cell?.stockImageView.kf.setImage(with: url, placeholder: UIImage(named: "apple"))
                cell?.stockNameLabel.text = self.apiData[indexPath.row].stockName
                cell?.companyNameLabel.text = self.apiData[indexPath.row].stockName
                cell?.currentPriceLabel.text = "\(self.apiData[indexPath.row].currentPrice)".insertComma + "원"
                
                let str = String(format: "%.2f", Double(self.apiData[indexPath.row].percentChange))
                cell?.percentChangeLabel.text = "+" + str + "%"
            }
            return cell!
        }
        
    }
}
