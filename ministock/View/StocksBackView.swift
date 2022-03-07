//
//  StocksBackView.swift
//  ministock
//
//  Created by 윤지용 on 2022/03/07.
//

import UIKit
import SnapKit

class StocksBackView: UIView{
    //MARK: - Propertie
    var category = ["상승","하락","조회급등","인기검색","배당","시가총액"]
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
//        bt.addTarget(self, action: #selector(btnActions), for: .touchUpInside)
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
//        bt.addTarget(self, action: #selector(btnActions), for: .touchUpInside)
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
//        bt.addTarget(self, action: #selector(btnActions), for: .touchUpInside)
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
//        bt.addTarget(self, action: #selector(pushView), for: .touchUpInside)
        return bt
    }()
    private let stocksTableView = UITableView(frame: .zero, style: .plain)
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.heightAnchor.constraint(equalToConstant: 770).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stocksCategoryView)
        stocksCategoryView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self)
        }
        self.addSubview(stocksCategoryUnderLineView)
        stocksCategoryUnderLineView.snp.makeConstraints { make in
            make.top.equalTo(stocksCategoryView.snp.bottom)
            make.left.equalTo(stocksCategoryView.snp.left)
            make.right.equalTo(stocksCategoryView.snp.right)
        }
        self.addSubview(stocksCategoryFilterView)
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
        
        self.addSubview(moreStockView)
        moreStockView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(self)
        }
        
        moreStockView.addSubview(moreStocksBtn)
        moreStocksBtn.snp.makeConstraints { make in
            make.top.equalTo(moreStockView).offset(10)
            make.bottom.equalTo(moreStockView).offset(-10)
            make.leading.equalTo(moreStockView).offset(15)
            make.trailing.equalTo(moreStockView).offset(-15)
        }
        
        self.addSubview(stocksTableView)
        stocksTableView.snp.makeConstraints { make in
            make.top.equalTo(stocksCategoryFilterView.snp.bottom)
            make.leading.equalTo(stocksCategoryFilterView.snp.leading).offset(15)
            make.trailing.equalTo(stocksCategoryFilterView.snp.trailing)
            make.bottom.equalTo(moreStockView.snp.top)
            
        }
        stocksTableView.register(MyFavoriteTableViewCell.self, forCellReuseIdentifier: "stocksTableView")
        stocksTableView.delegate = self
        stocksTableView.dataSource = self
        stocksTableView.translatesAutoresizingMaskIntoConstraints = false
        stocksTableView.rowHeight = 60
        stocksTableView.separatorStyle = .none
        stocksTableView.isScrollEnabled = false
        stocksTableView.allowsSelection = false
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: "CategoryCollectionCell")
        categoryCollectionView.isPagingEnabled = true
        categoryCollectionView.showsHorizontalScrollIndicator = false
        stocksCategoryView.addSubview(categoryCollectionView)

        categoryCollectionView.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalTo(stocksCategoryView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    //MARK: - Helpers
}
extension StocksBackView : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
            return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
            let cell = tableView.dequeueReusableCell(withIdentifier: "stocksTableView", for: indexPath) as! MyFavoriteTableViewCell?
        cell?.companyNameLabel.text = "test"
//            if self.apiData.count > indexPath.row{
//
//                let url = URL(string: "\(self.apiData[indexPath.row].imageURL)")
//                cell?.stockImageView.kf.setImage(with: url, placeholder: UIImage(named: "apple"))
//                cell?.stockNameLabel.text = self.apiData[indexPath.row].stockName
//                cell?.companyNameLabel.text = self.apiData[indexPath.row].stockName
//                cell?.currentPriceLabel.text = "\(self.apiData[indexPath.row].currentPrice)".insertComma + "원"
//
//                let str = String(format: "%.2f", Double(self.apiData[indexPath.row].percentChange))
//                cell?.percentChangeLabel.text = "+" + str + "%"
//            }
            return cell!
        
    
    }
}
extension StocksBackView: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
//                    self.apiData.removeAll()
//                    self.apiData = result
                }
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = 0.0
        var height = 0.0
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as? CategoryCollectionCell else {
            return .zero
        }
        
        let cellWidth = cell.testLabel.frame.width + 15
        
        width = cellWidth
        
        height = collectionView.bounds.height
        return CGSize.init(width: width, height: height)
    }
    
}
