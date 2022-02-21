//
//  MyFavoriteTableViewCellswift.swift
//  ministock
//
//  Created by IT on 2022/02/21.
//

import UIKit

class MyFavoriteTableViewCell: UITableViewCell{
    //MARK: - Propertie
    var stockImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "kisspng-tesla-motors-electric-car-electric-vehicle-logo-tesla-5ac2de39ed7200.6105417915227203139726")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Actions
    //MARK: - Helpers
}
