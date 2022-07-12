//
//  DividendCollectionViewCell.swift
//  ministock
//
//  Created by 윤지용 on 2022/02/28.
//

import UIKit
import Kingfisher
class DividendCollectionViewCell: UICollectionViewCell{
    private lazy var stockImageView: UIImageView = {
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
    private lazy var percentChangeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "연 8.28%"
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textColor = .black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    private lazy var currentPriceLabel: UILabel = {
        let lb = UILabel()
        lb.text = "72,320원"
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = .systemGray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    private lazy var exDividendDate: UILabel = {
        let lb = UILabel()
        lb.text = "2월 28일"
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = .red
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initLayout(){
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        [
            stockImageView,
            companyNameLabel,
            percentChangeLabel,
            currentPriceLabel,
            exDividendDate
        ]
            .forEach {
                addSubview($0)
            }
        stockImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(15)
        }
        companyNameLabel.snp.makeConstraints {
            $0.top.equalTo(stockImageView.snp.bottom).offset(5)
            $0.leading.equalTo(stockImageView.snp.leading)
            $0.trailing.equalToSuperview().offset(-5)
        }
        percentChangeLabel.snp.makeConstraints { 
            $0.top.equalTo(companyNameLabel.snp.bottom).offset(15)
            $0.leading.equalTo(stockImageView.snp.leading)
        }
        currentPriceLabel.snp.makeConstraints {
            $0.top.equalTo(percentChangeLabel.snp.bottom).offset(5)
            $0.leading.equalTo(stockImageView.snp.leading)
        }
        exDividendDate.snp.makeConstraints {
            $0.top.equalTo(currentPriceLabel.snp.bottom).offset(15)
            $0.leading.equalTo(stockImageView.snp.leading)
        }
    }
}
