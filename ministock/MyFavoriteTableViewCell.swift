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
        uv.backgroundColor = .white
        return uv
    }()
    
    private let rightView: UIView = {
       let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.backgroundColor = .white
        return uv
    }()
    let companyNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "테슬라"
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let stockNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "TSLA"
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = .systemGray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let underLineView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemGray6
        uv.heightAnchor.constraint(equalToConstant: 1).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    //MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        addSubview(stockImageView)
        stockImageView.backgroundColor = .blue
        stockImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stockImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stockImageView.widthAnchor.constraint(equalToConstant: 42).isActive = true
        stockImageView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        stockImageView.layer.cornerRadius = 42 / 2
        
        
        addSubview(underLineView)
        underLineView.leadingAnchor.constraint(equalTo: stockImageView.leadingAnchor).isActive = true
        underLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        underLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -15).isActive = true
        
        addSubview(leftView)
        leftView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        leftView.heightAnchor.constraint(equalTo: stockImageView.heightAnchor).isActive = true
        leftView.leadingAnchor.constraint(equalTo: stockImageView.trailingAnchor, constant: 10).isActive = true
        
        leftView.addSubview(companyNameLabel)
        companyNameLabel.centerYAnchor.constraint(equalTo: leftView.centerYAnchor).isActive = true
//        companyNameLabel.topAnchor.constraint(equalTo: leftView.topAnchor).isActive = true
        companyNameLabel.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 0).isActive = true
        companyNameLabel.widthAnchor.constraint(equalTo: leftView.widthAnchor).isActive = true
        
        leftView.addSubview(stockNameLabel)
        stockNameLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor).isActive = true
        stockNameLabel.leadingAnchor.constraint(equalTo: companyNameLabel.leadingAnchor).isActive = true
        
        addSubview(rightView)
        rightView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        rightView.heightAnchor.constraint(equalTo: stockImageView.heightAnchor).isActive = true
        rightView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: 0).isActive = true
        
        
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
