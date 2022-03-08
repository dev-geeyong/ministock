//
//  DividendCollectionViewCell.swift
//  ministock
//
//  Created by 윤지용 on 2022/02/28.
//

import UIKit
import Kingfisher
class DividendCollectionViewCell: UICollectionViewCell{
    
    var viewModel: DividendViewModel?{
        didSet{
            configure()
        }
    }
    let stockImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "kisspng-tesla-motors-electric-car-electric-vehicle-logo-tesla-5ac2de39ed7200.6105417915227203139726")
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.systemGray4.cgColor
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 32).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 32).isActive = true
        iv.layer.cornerRadius = 32/2
        return iv
    }()
    let companyNameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "다우"
        return lb
    }()
    let percentChangeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "연 8.28%"
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textColor = .black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let currentPriceLabel: UILabel = {
        let lb = UILabel()
        lb.text = "72,320원"
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = .systemGray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let exDividendDate: UILabel = {
        let lb = UILabel()
        lb.text = "2월 28일"
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = .red
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        
        addSubview(stockImageView)
        stockImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        stockImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        
        addSubview(companyNameLabel)
        companyNameLabel.topAnchor.constraint(equalTo: stockImageView.bottomAnchor, constant: 5).isActive = true
        companyNameLabel.leadingAnchor.constraint(equalTo: stockImageView.leadingAnchor).isActive = true
        
        companyNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -5).isActive = true
        
        addSubview(percentChangeLabel)
        percentChangeLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 15).isActive = true
        percentChangeLabel.leadingAnchor.constraint(equalTo: stockImageView.leadingAnchor).isActive = true
        
        addSubview(currentPriceLabel)
        currentPriceLabel.topAnchor.constraint(equalTo: percentChangeLabel.bottomAnchor, constant: 5).isActive = true
        currentPriceLabel.leadingAnchor.constraint(equalTo: stockImageView.leadingAnchor).isActive = true
        
        addSubview(exDividendDate)
        exDividendDate.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 15).isActive = true
        exDividendDate.leadingAnchor.constraint(equalTo: stockImageView.leadingAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        guard let viewModel = viewModel else {return}
   
        if let image = viewModel.image{
            stockImageView.kf.setImage(with: image)
        }
        companyNameLabel.text = viewModel.name
        percentChangeLabel.text = viewModel.percent
        currentPriceLabel.text = viewModel.price
        exDividendDate.text = viewModel.date
    }
}
