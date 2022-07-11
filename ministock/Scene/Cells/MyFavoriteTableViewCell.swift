//
//  MyFavoriteTableViewCellswift.swift
//  ministock
//
//  Created by IT on 2022/02/21.
//

import UIKit
import Kingfisher

class MyFavoriteTableViewCell: UITableViewCell{
    //MARK: - Propertie
    var cellViewModel: Model? {
        didSet {
            guard let viewModel = cellViewModel else{return}
            companyNameLabel.text = viewModel.name
            stockNameLabel.text = viewModel.code
            currentPriceLabel.text = viewModel.setPrice
            percentChangeLabel.text = viewModel.setReturn
            percentChangeLabel.textColor = viewModel.setColor
        }
    }
    private lazy var stockImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "kisspng-tesla-motors-electric-car-electric-vehicle-logo-tesla-5ac2de39ed7200.6105417915227203139726")
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.systemGray4.cgColor
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 42).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 42).isActive = true
        iv.layer.cornerRadius = 42 / 2
        return iv
    }()
    private lazy var leftView: UIView = {
       let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.backgroundColor = .white
        return uv
    }()
    private lazy var rightView: UIView = {
       let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.backgroundColor = .white
        return uv
    }()
    private lazy var companyNameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    private lazy var stockNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "TSLA"
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = .systemGray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    private lazy var currentPriceLabel: UILabel = {
        let lb = UILabel()
        lb.text = "17,877원"
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.textColor = .black
        lb.textAlignment = .right
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    private lazy var percentChangeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "+18.88%"
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textColor = .red
        lb.textAlignment = .right
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    private lazy var underLineView: UIView = {
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
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Actions
    //MARK: - Helpers
    func initLayout(){
        [
            stockImageView,
            underLineView,
            leftView,
            rightView
        ]
            .forEach {
                addSubview($0)
            }
        stockImageView.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
        }
        underLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(stockImageView.snp.leading)
            $0.trailing.equalToSuperview().offset(-15)
        }
        leftView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(stockImageView.snp.height)
            $0.leading.equalTo(stockImageView.snp.trailing).offset(10)
        }
        leftView.addSubview(companyNameLabel)
        companyNameLabel.snp.makeConstraints {
            $0.centerY.leading.width.equalToSuperview()
        }
        leftView.addSubview(stockNameLabel)
        stockNameLabel.snp.makeConstraints {
            $0.top.equalTo(companyNameLabel.snp.bottom)
            $0.leading.equalTo(companyNameLabel.snp.leading)
            $0.width.equalToSuperview()
        }
        rightView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(stockImageView.snp.height)
            $0.leading.equalTo(leftView.snp.trailing)
        }
        rightView.addSubview(percentChangeLabel)
        percentChangeLabel.snp.makeConstraints {
            $0.centerY.trailing.width.equalToSuperview()
        }
        rightView.addSubview(currentPriceLabel)
        currentPriceLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(percentChangeLabel.snp.bottom)
            $0.trailing.equalTo(percentChangeLabel.snp.trailing)
        }
    }
}
