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
            self.myFavoriteTableView.reloadData()
            self.stocksTableView.reloadData()
            self.dividendCollectionView.reloadData()
        }
    }
    var category = ["상승","하락","조회급등","인기검색","배당","시가총액"]
    
    private let slideShowView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .red
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return uv
    }()
    
    private let myFavoriteView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemGray6
        uv.heightAnchor.constraint(equalToConstant: 220).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    private let myFavoriteBackView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    private let myFavoriteLabel: UILabel = {
        let lb = UILabel()
        lb.text = "관심 주식"
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let stocksView: UIView = {
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
    private let moreStockView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        uv.heightAnchor.constraint(equalToConstant: 70).isActive = true
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
    //dividend
    private let dividendStocksView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemMint
        uv.heightAnchor.constraint(equalToConstant: 250).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    private let dividendStocksBackView: UIView = {
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
    
    
    private let exchangeRateView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemGray6
        uv.heightAnchor.constraint(equalToConstant: 150).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    private let carouselCollectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
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
    
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var currentIdx: Int = 0
    private let myFavoriteTableView = UITableView(frame: .zero, style: .plain)
    private let stocksTableView = UITableView(frame: .zero, style: .plain)
    
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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AlamofireManager.shared.getData { result in
            self.apiData = result
            
        }
        myFavoriteTableView.register(MyFavoriteTableViewCell.self, forCellReuseIdentifier: "MyFavoriteTableViewCell")
        myFavoriteTableView.delegate = self
        myFavoriteTableView.dataSource = self
        myFavoriteTableView.translatesAutoresizingMaskIntoConstraints = false
        myFavoriteTableView.rowHeight = 60
        myFavoriteTableView.separatorStyle = .none
        
        stocksTableView.register(MyFavoriteTableViewCell.self, forCellReuseIdentifier: "stocksTableView")
        stocksTableView.delegate = self
        stocksTableView.dataSource = self
        stocksTableView.translatesAutoresizingMaskIntoConstraints = false
        stocksTableView.rowHeight = 60
        stocksTableView.separatorStyle = .none
        stocksTableView.isScrollEnabled = false
        stocksTableView.allowsSelection = false
        
        initLayout()
        initCarouselCollectionView()
        startAutoScroll()
        
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        contentView.backgroundColor = .systemGray6
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [slideShowView,myFavoriteView,stocksView,dividendStocksView,exchangeRateView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        
        myFavoriteView.addSubview(myFavoriteBackView)
        myFavoriteBackView.topAnchor.constraint(equalTo: myFavoriteView.topAnchor, constant: 10).isActive = true
        myFavoriteBackView.leadingAnchor.constraint(equalTo: myFavoriteView.leadingAnchor, constant: 0).isActive = true
        myFavoriteBackView.trailingAnchor.constraint(equalTo: myFavoriteView.trailingAnchor).isActive = true
        myFavoriteBackView.bottomAnchor.constraint(equalTo: myFavoriteView.bottomAnchor, constant: -10).isActive = true
        
        myFavoriteBackView.addSubview(myFavoriteLabel)
        myFavoriteLabel.topAnchor.constraint(equalTo: myFavoriteBackView.topAnchor, constant: 15).isActive = true
        myFavoriteLabel.leadingAnchor.constraint(equalTo: myFavoriteBackView.leadingAnchor, constant: 15).isActive = true
        
        myFavoriteBackView.addSubview(addFavoriteStock)
        addFavoriteStock.leadingAnchor.constraint(equalTo: myFavoriteLabel.leadingAnchor, constant: 0).isActive = true
        addFavoriteStock.bottomAnchor.constraint(equalTo: myFavoriteBackView.bottomAnchor, constant: -15).isActive = true
        addFavoriteStock.trailingAnchor.constraint(equalTo: myFavoriteBackView.trailingAnchor, constant: -10).isActive = true
        
        myFavoriteBackView.addSubview(myFavoriteTableView)
        myFavoriteTableView.topAnchor.constraint(equalTo: myFavoriteLabel.bottomAnchor,constant: 15).isActive = true
        myFavoriteTableView.leadingAnchor.constraint(equalTo: myFavoriteLabel.leadingAnchor).isActive = true
        myFavoriteTableView.trailingAnchor.constraint(equalTo: myFavoriteBackView.trailingAnchor).isActive = true
        myFavoriteTableView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        myFavoriteTableView.allowsSelection = false
        
        ///
        stocksView.addSubview(stocksCategoryView)
        stocksCategoryView.topAnchor.constraint(equalTo: stocksView.topAnchor).isActive = true
        stocksCategoryView.leadingAnchor.constraint(equalTo: stocksView.leadingAnchor).isActive = true
        stocksCategoryView.trailingAnchor.constraint(equalTo: stocksView.trailingAnchor).isActive = true
        
        stocksView.addSubview(stocksCategoryUnderLineView)
        stocksCategoryUnderLineView.topAnchor.constraint(equalTo: stocksCategoryView.bottomAnchor).isActive = true
        stocksCategoryUnderLineView.leadingAnchor.constraint(equalTo: stocksCategoryView.leadingAnchor).isActive = true
        stocksCategoryUnderLineView.trailingAnchor.constraint(equalTo: stocksCategoryView.trailingAnchor).isActive = true
        
        stocksView.addSubview(stocksCategoryFilterView)
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
        
        stocksView.addSubview(moreStockView)
        moreStockView.bottomAnchor.constraint(equalTo: stocksView.bottomAnchor).isActive = true
        moreStockView.leadingAnchor.constraint(equalTo: stocksView.leadingAnchor).isActive = true
        moreStockView.trailingAnchor.constraint(equalTo: stocksView.trailingAnchor).isActive = true
        
        moreStockView.addSubview(moreStocksBtn)
        moreStocksBtn.topAnchor.constraint(equalTo: moreStockView.topAnchor, constant: 10).isActive = true
        moreStocksBtn.leadingAnchor.constraint(equalTo: moreStockView.leadingAnchor, constant: 15).isActive = true
        moreStocksBtn.trailingAnchor.constraint(equalTo: moreStockView.trailingAnchor,constant: -15).isActive = true
        moreStocksBtn.bottomAnchor.constraint(equalTo: moreStockView.bottomAnchor, constant: -10).isActive = true
        
        stocksView.addSubview(stocksTableView)
        stocksTableView.topAnchor.constraint(equalTo: stocksCategoryFilterView.bottomAnchor).isActive = true
        stocksTableView.leadingAnchor.constraint(equalTo: stocksCategoryFilterView.leadingAnchor, constant: 15).isActive = true
        stocksTableView.trailingAnchor.constraint(equalTo: stocksCategoryFilterView.trailingAnchor).isActive = true
        stocksTableView.bottomAnchor.constraint(equalTo: moreStockView.topAnchor).isActive = true
       
        
        //dividend
        
        dividendStocksView.addSubview(dividendStocksBackView)
        dividendStocksBackView.leadingAnchor.constraint(equalTo: dividendStocksView.leadingAnchor, constant: 25).isActive = true
        dividendStocksBackView.bottomAnchor.constraint(equalTo: dividendStocksView.bottomAnchor, constant: -25).isActive = true
        dividendStocksBackView.trailingAnchor.constraint(equalTo: dividendStocksView.trailingAnchor).isActive = true
        
        dividendStocksView.addSubview(dividendTitleLabel)
        dividendTitleLabel.topAnchor.constraint(equalTo: dividendStocksView.topAnchor, constant: 15).isActive = true
        dividendTitleLabel.leadingAnchor.constraint(equalTo: dividendStocksView.leadingAnchor, constant: 25).isActive = true
        
        dividendStocksView.addSubview(dividendSubTitleLabel)
        dividendSubTitleLabel.topAnchor.constraint(equalTo: dividendTitleLabel.bottomAnchor, constant: 1).isActive = true
        dividendSubTitleLabel.leadingAnchor.constraint(equalTo: dividendTitleLabel.leadingAnchor).isActive = true
        
        dividendStocksView.addSubview(dividendQuestionBtn)
        dividendQuestionBtn.topAnchor.constraint(equalTo: dividendTitleLabel.topAnchor).isActive = true
        dividendQuestionBtn.trailingAnchor.constraint(equalTo: dividendStocksView.trailingAnchor, constant: -20).isActive = true
        
        
    }
    func initCarouselCollectionView(){
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        carouselCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "carouselCollectionView")
        slideShowView.addSubview(carouselCollectionView)
        carouselCollectionView.showsHorizontalScrollIndicator = false
        carouselCollectionView.isPagingEnabled = true
        NSLayoutConstraint.activate([
            carouselCollectionView.centerXAnchor.constraint(equalTo: slideShowView.centerXAnchor, constant: 0),
            carouselCollectionView.centerYAnchor.constraint(equalTo: slideShowView.centerYAnchor, constant: 0),
            carouselCollectionView.widthAnchor.constraint(equalTo: slideShowView.widthAnchor),
            carouselCollectionView.heightAnchor.constraint(equalTo: slideShowView.heightAnchor)
            
        ])
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
        
        dividendCollectionView.dataSource = self
        dividendCollectionView.delegate = self
        dividendCollectionView.register(DividendCollectionViewCell.self, forCellWithReuseIdentifier: "DividendCollectionViewCell")
        dividendStocksBackView.addSubview(dividendCollectionView)
        dividendCollectionView.isPagingEnabled = true
        dividendCollectionView.showsHorizontalScrollIndicator = false
        NSLayoutConstraint.activate([
            dividendCollectionView.centerXAnchor.constraint(equalTo: dividendStocksBackView.centerXAnchor, constant: 0),
            dividendCollectionView.centerYAnchor.constraint(equalTo: dividendStocksBackView.centerYAnchor, constant: 0),
            dividendCollectionView.widthAnchor.constraint(equalTo: dividendStocksBackView.widthAnchor),
            dividendCollectionView.heightAnchor.constraint(equalTo: dividendStocksBackView.heightAnchor)
            
        ])
        
        
    }
    func startAutoScroll() {
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
            print("->com",indexPath.item)
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
            width = dividendStocksBackView.frame.width / 3.0 + 10
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
        if myFavoriteTableView == tableView{
            return 1
        }else{
            return self.apiData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == myFavoriteTableView {
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
