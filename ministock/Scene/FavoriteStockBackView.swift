//
//  FavoriteStockBackView.swift
//  ministock
//
//  Created by 윤지용 on 2022/03/07.
//

import UIKit
import SnapKit



class FavoriteStockBackView: UIView {
    //MARK: - Propertie
    var cellDelegate: PushNavgationDelegate?
    lazy var viewModel = StocksViewModel()
    private lazy var favoriteInView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        return uv
    }()
    private lazy var favoriteTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "보유 주식"
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        return lb
    }()
    private lazy var addFavoriteStockBtn: UIButton = {
        let bt = UIButton()
        bt.setTitle("관심 주식 담기 및 관리", for: .normal)
        bt.setTitleColor(UIColor.black, for: .normal)
        bt.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        bt.backgroundColor = .white
        bt.layer.cornerRadius = 5
        bt.layer.borderColor = UIColor.systemGray4.cgColor
        bt.layer.borderWidth = 1
        bt.addTarget(self, action: #selector(touchUpFavoriteBtn), for: .touchUpInside)
        return bt
    }()
    private lazy var favoriteStockTableView: UITableView = {
        let tv = UITableView()
        tv.register(MyFavoriteTableViewCell.self, forCellReuseIdentifier: "MyFavoriteTableViewCell")
        tv.rowHeight = 60
        tv.separatorStyle = .none
        tv.allowsSelection = false
        return tv
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        favoriteStockTableView.delegate = self
        favoriteStockTableView.dataSource = self
        initLayout()
        initViewModel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Actions
    @objc func touchUpFavoriteBtn(){
        cellDelegate?.pushButtonTapped()
    }
    //MARK: - Helpers
    func initViewModel() {
        viewModel.getStocks()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.favoriteStockTableView.reloadData()
            }
        }
    }
    func initLayout() {
        self.backgroundColor = .systemGray6
        self.heightAnchor.constraint(equalToConstant: 360).isActive = true
        self.addSubview(favoriteInView)
        favoriteInView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self).offset(-10)
        }
        favoriteInView.addSubview(favoriteTitleLabel)
        favoriteTitleLabel.snp.makeConstraints { make in
            make.top.left.equalTo(favoriteInView).offset(15)
        }
        favoriteInView.addSubview(favoriteStockTableView)
        favoriteStockTableView.snp.makeConstraints { make in
            make.top.equalTo(favoriteTitleLabel.snp.bottom).offset(15)
            make.left.equalTo(favoriteTitleLabel)
            make.right.equalTo(favoriteInView)
            make.height.equalTo(200)
        }
        favoriteInView.addSubview(addFavoriteStockBtn)
        addFavoriteStockBtn.snp.makeConstraints { make in
            make.bottom.equalTo(favoriteInView.snp.bottom).offset(-15)
            make.leading.equalTo(favoriteInView.snp.leading).offset(15)
            make.trailing.equalTo(favoriteInView.snp.trailing).offset(-15)
        }
    }
}
extension FavoriteStockBackView:  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stocksModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyFavoriteTableViewCell", for: indexPath) as? MyFavoriteTableViewCell else{
            return UITableViewCell()
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}
