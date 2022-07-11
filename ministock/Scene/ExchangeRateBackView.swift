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
    private lazy var exchangeRateInView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        uv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return uv
    }()
    private lazy var exchangeRateLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.text = "원달러 환율"
        return lb
    }()
    private lazy var exchangeRateDateLabel: UILabel = {
        let lb = UILabel()
        lb.text = "2월 22일 최초고시환율"
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = .systemGray
        return lb
    }()
    private lazy var currentExchangeRateLabel: UILabel = {
        let lb = UILabel()
        lb.text = "1,194.60원"
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textColor = .black
        lb.textAlignment = .right
        return lb
    }()
    private lazy var percentChangeLabel: UILabel = {
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
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    //MARK: - Helpers
    func initLayout(){
        self.backgroundColor = .systemGray6
        self.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        self.addSubview(exchangeRateInView)
        exchangeRateInView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.trailing.equalToSuperview()
        }
        [
            exchangeRateLabel,
            exchangeRateDateLabel,
            currentExchangeRateLabel,
            percentChangeLabel
        ]
            .forEach {
                exchangeRateInView.addSubview($0)
            }
        exchangeRateLabel.snp.makeConstraints {
            $0.centerY.equalTo(exchangeRateInView).offset(-10)
            $0.leading.equalTo(exchangeRateInView).offset(25)
        }
        exchangeRateDateLabel.snp.makeConstraints {
            $0.top.equalTo(exchangeRateLabel.snp.bottom)
            $0.leading.equalTo(exchangeRateLabel)
        }
        currentExchangeRateLabel.snp.makeConstraints {
            $0.top.equalTo(exchangeRateLabel)
            $0.trailing.equalTo(exchangeRateInView.snp.trailing).offset(-25)
        }
        percentChangeLabel.snp.makeConstraints {
            $0.top.equalTo(currentExchangeRateLabel.snp.bottom)
            $0.trailing.equalTo(currentExchangeRateLabel.snp.trailing)
        }
    }
}
