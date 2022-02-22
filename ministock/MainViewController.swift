//
//  ViewController.swift
//  ministock
//
//  Created by IT on 2022/02/15.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: - Propertie
    
    var category = ["상승","하락","조회급등","인기검색","배당","시가총액"]
    var images = ["apple","meta","kisspng-tesla-motors-electric-car-electric-vehicle-logo-tesla-5ac2de39ed7200.6105417915227203139726","samsung","paypal"]
    private let slideShowView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .red
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return uv
    }()
    
    let myFavoriteView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemGray5
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
    
    let stocksView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        uv.heightAnchor.constraint(equalToConstant: 700).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    let stocksCategoryView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        uv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    let stocksCategoryUnderLineView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemGray5
        uv.heightAnchor.constraint(equalToConstant: 1).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    let stocksCategoryFilterView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemCyan
        uv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    
    let dividendStocksView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemMint
        uv.heightAnchor.constraint(equalToConstant: 200).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    let exchangeRateView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemGray
        uv.heightAnchor.constraint(equalToConstant: 150).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    let carouselCollectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    
    let categoryCollectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var currentIdx: Int = 0
    let myFavoriteTableView = UITableView(frame: .zero, style: .plain)
    let stocksTableView = UITableView(frame: .zero, style: .plain)
    
    private lazy var addFavoriteStock: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("관심 주식 담기 및 관리", for: .normal)
        bt.setTitleColor(UIColor.black, for: .normal)
        bt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        bt.backgroundColor = .white
        bt.layer.cornerRadius = 5
        bt.layer.borderColor = UIColor.black.cgColor
        bt.layer.borderWidth = 1
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myFavoriteTableView.register(MyFavoriteTableViewCell.self, forCellReuseIdentifier: "MyFavoriteTableViewCell")
        myFavoriteTableView.delegate = self
        myFavoriteTableView.dataSource = self
        myFavoriteTableView.translatesAutoresizingMaskIntoConstraints = false
        myFavoriteTableView.rowHeight = 50
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
    //MARK: - Helpers
    
    func initLayout(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        contentView.backgroundColor = .systemGray4
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
        
        stocksView.addSubview(stocksTableView)
        stocksTableView.topAnchor.constraint(equalTo: stocksCategoryFilterView.bottomAnchor).isActive = true
        stocksTableView.leadingAnchor.constraint(equalTo: stocksCategoryFilterView.leadingAnchor, constant: 15).isActive = true
        stocksTableView.trailingAnchor.constraint(equalTo: stocksCategoryFilterView.trailingAnchor).isActive = true
        stocksTableView.bottomAnchor.constraint(equalTo: stocksView.bottomAnchor).isActive = true
        
        //
    }
    func initCarouselCollectionView(){
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        carouselCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "carouselCollectionView")
        slideShowView.addSubview(carouselCollectionView)
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
        }else{
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == carouselCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCollectionView", for: indexPath)
            return cell
        }else{
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
        if let cell = collectionView.cellForItem(at: indexPath){
            //            cell.isSelected = true
        }
        DispatchQueue.main.async {
            
            if indexPath.row == 5 {
                let rect = self.categoryCollectionView.layoutAttributesForItem(at: IndexPath(row: 5, section: 0))?.frame
                self.categoryCollectionView.scrollRectToVisible(rect!, animated: true)
            }else{
                self.categoryCollectionView.selectItem(at: IndexPath(item: indexPath.item, section: 0), animated: true, scrollPosition: .right)
            }
        }
        print("->indexPath.item",indexPath.item)
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
        }else{
            //
//            if indexPath.row == 0 {
//                cell.backgroundColor = .red
//            }
//            else if indexPath.row == 1 {
//                cell.backgroundColor = .blue
//            }
//            else if indexPath.row == 2 {
//                cell.backgroundColor = .systemGreen
//            }
//            else if indexPath.row == 3 {
//                cell.backgroundColor = .systemMint
//            }
//            else if indexPath.row == 4 {
//                cell.backgroundColor = .green
//            }
//            else{
//                cell.backgroundColor = .purple
//            }
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = 0.0
        var height = 0.0
        if collectionView == carouselCollectionView{
            width = collectionView.bounds.width
            height = collectionView.bounds.height
        }
        else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as? CategoryCollectionCell else {
                return .zero
            }
            
            
            print("->cell.testLabel.frame.width ",cell.testLabel.frame.width )
            
            let cellWidth = cell.testLabel.frame.width + 15
            
            
            width = cellWidth
            
            height = collectionView.bounds.height
        }
        return CGSize.init(width: width, height: height)
    }
    
    //section 내부 cell간의 공간을 제거
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == carouselCollectionView{return 0}
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
        if tableView == myFavoriteTableView {
            return 1
        }else{
            return 10
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == myFavoriteTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyFavoriteTableViewCell", for: indexPath) as! MyFavoriteTableViewCell?
            return cell!
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "stocksTableView", for: indexPath) as! MyFavoriteTableViewCell?
            if self.images.count > indexPath.row{
                cell?.stockImageView.image = UIImage(named: self.images[indexPath.row])
                cell?.stockImageView.backgroundColor = .systemBlue
            }
            return cell!
        }
        
        
        
        
    }
    
    
}
