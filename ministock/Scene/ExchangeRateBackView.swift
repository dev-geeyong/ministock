//
//  ExchangeRateBackView.swift
//  ministock
//
//  Created by 윤지용 on 2022/03/08.
//

import UIKit
import SnapKit

class ExchangeRateBackView: UIView{
    //MARK: - Propertie
    private let exchangeRateInView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        uv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return uv
    }()
    private let exchangeRateLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.text = "원달러 환율"
        return lb
    }()
    private let exchangeRateDateLabel: UILabel = {
        let lb = UILabel()
        lb.text = "2월 22일 최초고시환율"
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = .systemGray
        return lb
    }()
    private let currentExchangeRateLabel: UILabel = {
        let lb = UILabel()
        lb.text = "1,194.60원"
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textColor = .black
        lb.textAlignment = .right
        return lb
    }()
    private let percentChangeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "+1.18%"
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.textColor = .red
        lb.textAlignment = .right
        return lb
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray6
        self.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
    
        self.addSubview(exchangeRateInView)
        exchangeRateInView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(15)
            make.leading.trailing.equalTo(self)
        }
        [exchangeRateLabel,exchangeRateDateLabel,
         currentExchangeRateLabel,percentChangeLabel].forEach {
            exchangeRateInView.addSubview($0)
        }
        
        exchangeRateLabel.snp.makeConstraints {
            $0.centerY.equalTo(exchangeRateInView).offset(-10)
            $0.leading.equalTo(exchangeRateInView).offset(25)
        }
        
        exchangeRateDateLabel.snp.makeConstraints { make in
            make.top.equalTo(exchangeRateLabel.snp.bottom)
            make.leading.equalTo(exchangeRateLabel)
        }
        
        currentExchangeRateLabel.snp.makeConstraints { make in
            make.top.equalTo(exchangeRateLabel)
            make.trailing.equalTo(exchangeRateInView.snp.trailing).offset(-25)
        }
        
        percentChangeLabel.snp.makeConstraints { make in
            make.top.equalTo(currentExchangeRateLabel.snp.bottom)
            make.trailing.equalTo(currentExchangeRateLabel.snp.trailing)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    //MARK: - Helpers
}
