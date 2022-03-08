//
//  DividendStocksBackView.swift
//  ministock
//
//  Created by 윤지용 on 2022/03/08.
//

import UIKit
import SnapKit

class DividendStocksBackView: UIView {
    //MARK: - Propertie
    private let dividendCollectionBackView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .clear
        uv.heightAnchor.constraint(equalToConstant: 160).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    private let dividendTitleLabel: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "은행 이자 부럽지 않은 배당"
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.textColor = .white
        return lb
    }()
    private let dividendSubTitleLabel: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "지금 사면 배당받는 주식!"
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.textColor = .white
        return lb
    }()
    
    private lazy var dividendQuestionBtn: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("미국 배당락일 기준 ", for: .normal)
        let config = UIImage.SymbolConfiguration(
            pointSize: 13, weight: .regular, scale: .default)
        let image = UIImage(systemName: "questionmark.circle", withConfiguration: config)
        bt.setImage(image, for: .normal)
        bt.tintColor = .systemGray6
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.semanticContentAttribute = .forceRightToLeft
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 13)
//        bt.addTarget(self, action: #selector(btnActions), for: .touchUpInside)
        bt.contentHorizontalAlignment = .left;
        
        return bt
    }()
    private let dividendCollectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.clipsToBounds = true
        collectionView.layer.cornerRadius = 5
        
        return collectionView
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemMint
        self.heightAnchor.constraint(equalToConstant: 250).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(dividendCollectionBackView)
        dividendCollectionBackView.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(25)
            make.bottom.equalTo(self).offset(-25)
            make.trailing.equalTo(self)
        }
        
        self.addSubview(dividendTitleLabel)
        dividendTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(15)
            make.leading.equalTo(self).offset(25)
        }
        
        self.addSubview(dividendSubTitleLabel)
        dividendSubTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dividendTitleLabel.snp.bottom)
            make.leading.equalTo(dividendTitleLabel.snp.leading)
        }
        
        self.addSubview(dividendQuestionBtn)
        dividendQuestionBtn.snp.makeConstraints { make in
            make.top.equalTo(dividendTitleLabel.snp.top)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
        }
        dividendCollectionView.dataSource = self
        dividendCollectionView.delegate = self
        dividendCollectionView.register(DividendCollectionViewCell.self, forCellWithReuseIdentifier: "DividendCollectionViewCell")
        dividendCollectionView.isPagingEnabled = true
        dividendCollectionView.showsHorizontalScrollIndicator = false
        dividendCollectionBackView.addSubview(dividendCollectionView)
        
        dividendCollectionView.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalTo(dividendCollectionBackView)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Actions
    
    //MARK: - Helpers

}
extension DividendStocksBackView: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DividendCollectionViewCell", for: indexPath) as? DividendCollectionViewCell else{ return UICollectionViewCell()}
        cell.companyNameLabel.text = "test"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = 0.0
        var height = 0.0
        
        
            width = dividendCollectionBackView.frame.width / 3.0 + 10
            height = collectionView.bounds.height
    
        
        return CGSize.init(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        if collectionView == carouselCollectionView{return 0}
        if collectionView == dividendCollectionView {return 5}
        else{return 0}
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
}
