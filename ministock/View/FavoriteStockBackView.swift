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
    let favoriteInView: UIView = {
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
        //        bt.addTarget(self, action: #selector(MainViewController.pushView), for: .touchUpInside)
        return bt
    }()
    private let favoriteStockTableView = UITableView(frame: .zero, style: .plain)
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray6
        self.heightAnchor.constraint(equalToConstant: 220).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
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
        favoriteInView.addSubview(addFavoriteStockBtn)
        addFavoriteStockBtn.snp.makeConstraints { make in
            make.left.equalTo(favoriteTitleLabel)
            make.bottom.equalTo(favoriteInView).offset(-15)
            make.right.equalTo(favoriteInView).offset(-10)
        }
        favoriteStockTableView.register(MyFavoriteTableViewCell.self, forCellReuseIdentifier: "MyFavoriteTableViewCell")
        favoriteStockTableView.delegate = self
        favoriteStockTableView.dataSource = self
        favoriteStockTableView.translatesAutoresizingMaskIntoConstraints = false
        favoriteStockTableView.rowHeight = 60
        favoriteStockTableView.separatorStyle = .none
        favoriteInView.addSubview(favoriteStockTableView)
        favoriteStockTableView.snp.makeConstraints { make in
            make.top.equalTo(favoriteTitleLabel.snp.bottom).offset(15)
            make.left.equalTo(favoriteTitleLabel)
            make.right.equalTo(favoriteInView)
            make.height.equalTo(60)
            
        }
        favoriteStockTableView.allowsSelection = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func pushView(){
        
    }
    //MARK: - Helpers
}
extension FavoriteStockBackView:  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyFavoriteTableViewCell", for: indexPath) as? MyFavoriteTableViewCell else{
            return UITableViewCell()
        }
        
        cell.underLineView.isHidden = true
        cell.companyNameLabel.text = "애플"
        cell.stockImageView.image = UIImage(named: "apple")
        return cell
    }
    
    
}
