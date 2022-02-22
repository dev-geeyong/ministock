//
//  MyFavoriteTableViewCellswift.swift
//  ministock
//
//  Created by IT on 2022/02/21.
//

import UIKit

class MyFavoriteTableViewCell: UITableViewCell{
    //MARK: - Propertie
    let stockImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "kisspng-tesla-motors-electric-car-electric-vehicle-logo-tesla-5ac2de39ed7200.6105417915227203139726")
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private let leftView: UIView = {
       let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.backgroundColor = .red
        return uv
    }()
    
    private let rightView: UIView = {
       let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.backgroundColor = .blue
        return uv
    }()
    let stockName: UILabel = {
        let lb = UILabel()
        lb.text = "테슬라"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    //MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        addSubview(stockImageView)
        stockImageView.backgroundColor = .blue
        stockImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stockImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stockImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        stockImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        stockImageView.layer.cornerRadius = 48 / 2
        
        addSubview(stockName)
        stockName.leadingAnchor.constraint(equalTo: stockImageView.trailingAnchor, constant: 10).isActive = true
        stockName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
//        addSubview(leftView)
////        addSubview(rightView)
////
//        leftView.leadingAnchor.constraint(equalTo: stockImageView.rightAnchor).isActive = true
//        leftView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        leftView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        leftView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Actions
    //MARK: - Helpers
}
