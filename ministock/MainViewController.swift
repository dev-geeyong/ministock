//
//  ViewController.swift
//  ministock
//
//  Created by IT on 2022/02/15.
//

import UIKit
import Alamofire
import Kingfisher

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
    private lazy var addFavoriteStock: UIButton = {
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
        uv.backgroundColor = .white
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
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(contentView)
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        //MARK: addsubView - favoriteStockBackView
        
        favoriteStockBackView.addSubview(favoriteInView)
        favoriteInView.topAnchor.constraint(equalTo: favoriteStockBackView.topAnchor, constant: 10).isActive = true
        favoriteInView.leadingAnchor.constraint(equalTo: favoriteStockBackView.leadingAnchor, constant: 0).isActive = true
        favoriteInView.trailingAnchor.constraint(equalTo: favoriteStockBackView.trailingAnchor).isActive = true
        favoriteInView.bottomAnchor.constraint(equalTo: favoriteStockBackView.bottomAnchor, constant: -10).isActive = true
        
        favoriteInView.addSubview(favoriteTitleLabel)
        favoriteTitleLabel.topAnchor.constraint(equalTo: favoriteInView.topAnchor, constant: 15).isActive = true
        favoriteTitleLabel.leadingAnchor.constraint(equalTo: favoriteInView.leadingAnchor, constant: 15).isActive = true
        
        favoriteInView.addSubview(addFavoriteStock)
        addFavoriteStock.leadingAnchor.constraint(equalTo: favoriteTitleLabel.leadingAnchor, constant: 0).isActive = true
        addFavoriteStock.bottomAnchor.constraint(equalTo: favoriteInView.bottomAnchor, constant: -15).isActive = true
        addFavoriteStock.trailingAnchor.constraint(equalTo: favoriteInView.trailingAnchor, constant: -10).isActive = true
        
        favoriteInView.addSubview(favoriteStockTableView)
        favoriteStockTableView.topAnchor.constraint(equalTo: favoriteTitleLabel.bottomAnchor,constant: 15).isActive = true
        favoriteStockTableView.leadingAnchor.constraint(equalTo: favoriteTitleLabel.leadingAnchor).isActive = true
        favoriteStockTableView.trailingAnchor.constraint(equalTo: favoriteInView.trailingAnchor).isActive = true
        favoriteStockTableView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        favoriteStockTableView.allowsSelection = false
        
        //MARK: addsubView - stocksBackView
        
        stocksBackView.addSubview(stocksCategoryView)
        stocksCategoryView.topAnchor.constraint(equalTo: stocksBackView.topAnchor).isActive = true
        stocksCategoryView.leadingAnchor.constraint(equalTo: stocksBackView.leadingAnchor).isActive = true
        stocksCategoryView.trailingAnchor.constraint(equalTo: stocksBackView.trailingAnchor).isActive = true
        
        stocksBackView.addSubview(stocksCategoryUnderLineView)
        stocksCategoryUnderLineView.topAnchor.constraint(equalTo: stocksCategoryView.bottomAnchor).isActive = true
        stocksCategoryUnderLineView.leadingAnchor.constraint(equalTo: stocksCategoryView.leadingAnchor).isActive = true
        stocksCategoryUnderLineView.trailingAnchor.constraint(equalTo: stocksCategoryView.trailingAnchor).isActive = true
        
        stocksBackView.addSubview(stocksCategoryFilterView)
        stocksCategoryFilterView.topAnchor.constraint(equalTo: stocksCategoryUnderLineView.bottomAnchor).isActive = true
        stocksCategoryFilterView.leadingAnchor.constraint(equalTo: stocksCategoryUnderLineView.leadingAnchor).isActive = true
        stocksCategoryFilterView.trailingAnchor.constraint(equalTo: stocksCategoryUnderLineView.trailingAnchor).isActive = true
        
        stocksCategoryFilterView.addSubview(stocksQuestionBtn)
        stocksQuestionBtn.leadingAnchor.constraint(equalTo: stocksCategoryFilterView.leadingAnchor, constant: 15).isActive = true
        stocksQuestionBtn.centerYAnchor.constraint(equalTo: stocksCategoryFilterView.centerYAnchor).isActive = true
        stocksQuestionBtn.widthAnchor.constraint(equalToConstant: 130).isActive = true
        stocksQuestionBtn.heightAnchor.constraint(equalTo: stocksCategoryFilterView.heightAnchor).isActive = true
        
        stocksCategoryFilterView.addSubview(stocksCategoryFilterBtn)
        stocksCategoryFilterBtn.leadingAnchor.constraint(equalTo: stocksCategoryFilterView.leadingAnchor, constant: 15).isActive = true
        stocksCategoryFilterBtn.centerYAnchor.constraint(equalTo: stocksCategoryFilterView.centerYAnchor).isActive = true
        stocksCategoryFilterBtn.widthAnchor.constraint(equalToConstant: 130).isActive = true
        stocksCategoryFilterBtn.heightAnchor.constraint(equalTo: stocksCategoryFilterView.heightAnchor).isActive = true
        
        stocksCategoryFilterView.addSubview(stocksEtfBtn)
        stocksEtfBtn.trailingAnchor.constraint(equalTo: stocksCategoryFilterView.trailingAnchor,constant: -15).isActive = true
        stocksEtfBtn.centerYAnchor.constraint(equalTo: stocksCategoryFilterView.centerYAnchor).isActive = true
        stocksEtfBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        stocksEtfBtn.heightAnchor.constraint(equalTo: stocksCategoryFilterView.heightAnchor).isActive = true
        
        stocksBackView.addSubview(moreStockView)
        moreStockView.bottomAnchor.constraint(equalTo: stocksBackView.bottomAnchor).isActive = true
        moreStockView.leadingAnchor.constraint(equalTo: stocksBackView.leadingAnchor).isActive = true
        moreStockView.trailingAnchor.constraint(equalTo: stocksBackView.trailingAnchor).isActive = true
        
        moreStockView.addSubview(moreStocksBtn)
        moreStocksBtn.topAnchor.constraint(equalTo: moreStockView.topAnchor, constant: 10).isActive = true
        moreStocksBtn.leadingAnchor.constraint(equalTo: moreStockView.leadingAnchor, constant: 15).isActive = true
        moreStocksBtn.trailingAnchor.constraint(equalTo: moreStockView.trailingAnchor,constant: -15).isActive = true
        moreStocksBtn.bottomAnchor.constraint(equalTo: moreStockView.bottomAnchor, constant: -10).isActive = true
        
        stocksBackView.addSubview(stocksTableView)
        stocksTableView.topAnchor.constraint(equalTo: stocksCategoryFilterView.bottomAnchor).isActive = true
        stocksTableView.leadingAnchor.constraint(equalTo: stocksCategoryFilterView.leadingAnchor, constant: 15).isActive = true
        stocksTableView.trailingAnchor.constraint(equalTo: stocksCategoryFilterView.trailingAnchor).isActive = true
        stocksTableView.bottomAnchor.constraint(equalTo: moreStockView.topAnchor).isActive = true
       
        
        //MARK: addsubView - dividendStocksBackView
        
        dividendStocksBackView.addSubview(dividendCollectionBackView)
        dividendCollectionBackView.leadingAnchor.constraint(equalTo: dividendStocksBackView.leadingAnchor, constant: 25).isActive = true
        dividendCollectionBackView.bottomAnchor.constraint(equalTo: dividendStocksBackView.bottomAnchor, constant: -25).isActive = true
        dividendCollectionBackView.trailingAnchor.constraint(equalTo: dividendStocksBackView.trailingAnchor).isActive = true
        
        dividendStocksBackView.addSubview(dividendTitleLabel)
        dividendTitleLabel.topAnchor.constraint(equalTo: dividendStocksBackView.topAnchor, constant: 15).isActive = true
        dividendTitleLabel.leadingAnchor.constraint(equalTo: dividendStocksBackView.leadingAnchor, constant: 25).isActive = true
        
        dividendStocksBackView.addSubview(dividendSubTitleLabel)
        dividendSubTitleLabel.topAnchor.constraint(equalTo: dividendTitleLabel.bottomAnchor, constant: 1).isActive = true
        dividendSubTitleLabel.leadingAnchor.constraint(equalTo: dividendTitleLabel.leadingAnchor).isActive = true
        
        dividendStocksBackView.addSubview(dividendQuestionBtn)
        dividendQuestionBtn.topAnchor.constraint(equalTo: dividendTitleLabel.topAnchor).isActive = true
        dividendQuestionBtn.trailingAnchor.constraint(equalTo: dividendStocksBackView.trailingAnchor, constant: -20).isActive = true
        
        //MARK: addsubView - exchangeRateInView
        
        exchangeRateBackView.addSubview(exchangeRateInView)
        exchangeRateInView.topAnchor.constraint(equalTo: exchangeRateBackView.topAnchor, constant: 15).isActive = true
        exchangeRateInView.leadingAnchor.constraint(equalTo: exchangeRateBackView.leadingAnchor).isActive = true
        exchangeRateInView.trailingAnchor.constraint(equalTo: exchangeRateBackView.trailingAnchor).isActive = true
        
        exchangeRateInView.addSubview(exchangeRateLabel)
        exchangeRateLabel.centerYAnchor.constraint(equalTo: exchangeRateInView.centerYAnchor, constant: -10).isActive = true
        exchangeRateLabel.leadingAnchor.constraint(equalTo: exchangeRateInView.leadingAnchor, constant: 25).isActive = true
        
        exchangeRateInView.addSubview(exchangeRateDateLabel)
        exchangeRateDateLabel.topAnchor.constraint(equalTo: exchangeRateLabel.bottomAnchor).isActive = true
        exchangeRateDateLabel.leadingAnchor.constraint(equalTo: exchangeRateLabel.leadingAnchor).isActive = true
        
        exchangeRateInView.addSubview(currentExchangeRateLabel)
        currentExchangeRateLabel.topAnchor.constraint(equalTo: exchangeRateLabel.topAnchor).isActive = true
        currentExchangeRateLabel.trailingAnchor.constraint(equalTo: exchangeRateInView.trailingAnchor, constant: -25).isActive = true
        
        exchangeRateInView.addSubview(percentChangeLabel)
        percentChangeLabel.topAnchor.constraint(equalTo: currentExchangeRateLabel.bottomAnchor).isActive = true
        percentChangeLabel.trailingAnchor.constraint(equalTo: currentExchangeRateLabel.trailingAnchor).isActive = true
        
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
        carouselBackView.addSubview(carouselCollectionView)
        carouselCollectionView.showsHorizontalScrollIndicator = false
        carouselCollectionView.isPagingEnabled = true
        NSLayoutConstraint.activate([
            carouselCollectionView.centerXAnchor.constraint(equalTo: carouselBackView.centerXAnchor, constant: 0),
            carouselCollectionView.centerYAnchor.constraint(equalTo: carouselBackView.centerYAnchor, constant: 0),
            carouselCollectionView.widthAnchor.constraint(equalTo: carouselBackView.widthAnchor),
            carouselCollectionView.heightAnchor.constraint(equalTo: carouselBackView.heightAnchor)
            
        ])
        
        //------------------------------------------------
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: "CategoryCollectionCell")
        stocksCategoryView.addSubview(categoryCollectionView)
        
        categoryCollectionView.isPagingEnabled = true
        categoryCollectionView.showsHorizontalScrollIndicator = false
        NSLayoutConstraint.activate([
            categoryCollectionView.centerXAnchor.constraint(equalTo: stocksCategoryView.centerXAnchor, constant: 0),
            categoryCollectionView.centerYAnchor.constraint(equalTo: stocksCategoryView.centerYAnchor, constant: 0),
            categoryCollectionView.widthAnchor.constraint(equalTo: stocksCategoryView.widthAnchor),
            categoryCollectionView.heightAnchor.constraint(equalTo: stocksCategoryView.heightAnchor)
            
        ])
        
        //------------------------------------------------
        
        dividendCollectionView.dataSource = self
        dividendCollectionView.delegate = self
        dividendCollectionView.register(DividendCollectionViewCell.self, forCellWithReuseIdentifier: "DividendCollectionViewCell")
        dividendCollectionBackView.addSubview(dividendCollectionView)
        dividendCollectionView.isPagingEnabled = true
        dividendCollectionView.showsHorizontalScrollIndicator = false
        NSLayoutConstraint.activate([
            dividendCollectionView.centerXAnchor.constraint(equalTo: dividendCollectionBackView.centerXAnchor, constant: 0),
            dividendCollectionView.centerYAnchor.constraint(equalTo: dividendCollectionBackView.centerYAnchor, constant: 0),
            dividendCollectionView.widthAnchor.constraint(equalTo: dividendCollectionBackView.widthAnchor),
            dividendCollectionView.heightAnchor.constraint(equalTo: dividendCollectionBackView.heightAnchor)
            
        ])
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
