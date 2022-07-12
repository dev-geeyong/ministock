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
    var pushDelegate: PushNavgationDelegate?
    var showDelegate: ShowBottomSheetDelegate?
    lazy var viewModel = StocksViewModel()
    private let category = ["상승","하락","조회급등","인기검색","배당","시가총액"]
    private lazy var stocksCategoryView: UIView = {
        let uv = UIView()
        uv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return uv
    }()
    private lazy var stocksCategoryUnderLineView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemGray5
        uv.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return uv
    }()
    private lazy var stocksCategoryFilterView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        uv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return uv
    }()
    private lazy var moreStockView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        uv.heightAnchor.constraint(equalToConstant: 70).isActive = true
        return uv
    }()
    private lazy var categoryCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: "CategoryCollectionCell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
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
            pointSize: 13,
            weight: .regular,
            scale: .default
        )
        let image = UIImage(systemName: "questionmark.circle", withConfiguration: config)
        bt.setImage(image, for: .normal)
        bt.tintColor = .systemGray
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
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        bt.addTarget(self, action: #selector(btnActions), for: .touchUpInside)
        bt.isUserInteractionEnabled = true
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
        bt.addTarget(self, action: #selector(pushView), for: .touchUpInside)
        return bt
    }()
    private lazy var stocksTableView: UITableView = {
        let tv = UITableView()
        tv.register(MyFavoriteTableViewCell.self, forCellReuseIdentifier: "stocksTableView")
        tv.rowHeight = 60
        tv.separatorStyle = .none
        tv.isScrollEnabled = true
        tv.allowsSelection = false
        return tv
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        initViewModel()
        initLayout()
        stocksTableView.delegate = self
        stocksTableView.dataSource = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Actions
    @objc func pushView(sender: UIButton){
        pushDelegate?.pushButtonTapped()
    }
    @objc func btnActions(sender: UIButton){
        showDelegate?.pushButtonTapped2()
    }
    //MARK: - Helpers
    func initLayout() {
        [
            stocksCategoryView,
            stocksCategoryUnderLineView,
            stocksCategoryFilterView,
            moreStockView,
            stocksTableView
        ]
            .forEach {
                addSubview($0)
            }
        [
            stocksQuestionBtn,
            stocksCategoryFilterBtn,
            stocksEtfBtn
        ]
            .forEach {
                stocksCategoryFilterView.addSubview($0)
            }
        moreStockView.addSubview(moreStocksBtn)
        stocksCategoryView.addSubview(categoryCollectionView)
        stocksCategoryView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self)
        }
        stocksCategoryUnderLineView.snp.makeConstraints {
            $0.top.equalTo(stocksCategoryView.snp.bottom)
            $0.leading.equalTo(stocksCategoryView.snp.leading)
            $0.trailing.equalTo(stocksCategoryView.snp.trailing)
        }
        stocksCategoryFilterView.snp.makeConstraints {
            $0.top.equalTo(stocksCategoryUnderLineView.snp.bottom)
            $0.leading.trailing.equalTo(stocksCategoryUnderLineView)
        }
        stocksQuestionBtn.snp.makeConstraints {
            $0.leading.equalTo(stocksCategoryFilterView).offset(15)
            $0.width.equalTo(130)
            $0.centerY.height.equalTo(stocksCategoryFilterView)
        }
        stocksCategoryFilterBtn.snp.makeConstraints {
            $0.centerY.height.equalTo(stocksCategoryFilterView)
            $0.leading.equalTo(stocksCategoryFilterView).offset(15)
            $0.width.equalTo(130)
        }
        stocksEtfBtn.snp.makeConstraints {
            $0.trailing.equalTo(stocksCategoryFilterView).offset(-15)
            $0.centerY.height.equalTo(stocksCategoryFilterView)
            $0.width.equalTo(100)
        }
        moreStockView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(self)
        }
        moreStocksBtn.snp.makeConstraints {
            $0.top.equalTo(moreStockView).offset(10)
            $0.bottom.equalTo(moreStockView).offset(-10)
            $0.leading.equalTo(moreStockView).offset(15)
            $0.trailing.equalTo(moreStockView).offset(-15)
        }
        stocksTableView.snp.makeConstraints {
            $0.top.equalTo(stocksCategoryFilterView.snp.bottom)
            $0.leading.equalTo(stocksCategoryFilterView.snp.leading).offset(15)
            $0.trailing.equalTo(stocksCategoryFilterView.snp.trailing)
            $0.bottom.equalTo(moreStockView.snp.top)
        }
        categoryCollectionView.snp.makeConstraints {
            $0.centerX.centerY.width.height.equalTo(stocksCategoryView)
        }
    }
    func initViewModel() {
        viewModel.getStocks()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.stocksTableView.reloadData()
            }
        }
    }
}
extension StocksBackView : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.snp.updateConstraints {
            $0.height.equalTo(viewModel.stocksModel.count * 60 + 20 + 171)
        }
        return viewModel.stocksModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "stocksTableView", for: indexPath) as? MyFavoriteTableViewCell else{
            return UITableViewCell()
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
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
            cell.categoryTitle.text = self.category[indexPath.item]
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
                    return
                }
                if indexPath.row == 5 {
                    let rect = self.categoryCollectionView.layoutAttributesForItem(at: IndexPath(row: 5, section: 0))?.frame
                    self.categoryCollectionView.scrollRectToVisible(rect!, animated: true)
                }else{
                    self.categoryCollectionView.selectItem(at: IndexPath(item: indexPath.item, section: 0), animated: true, scrollPosition: .right)
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
        let cellWidth = cell.categoryTitle.frame.width + 15
        width = cellWidth
        height = collectionView.bounds.height
        return CGSize.init(width: width, height: height)
    }
}
