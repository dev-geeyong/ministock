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
    var delegate: ShowBottomSheetDelegate?
    private lazy var dividendCollectionBackView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .clear
        uv.heightAnchor.constraint(equalToConstant: 160).isActive = true
        return uv
    }()
    private lazy var dividendTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "은행 이자 부럽지 않은 배당"
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.textColor = .white
        return lb
    }()
    private lazy var dividendSubTitleLabel: UILabel = {
        let lb = UILabel()
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
        bt.semanticContentAttribute = .forceRightToLeft
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        bt.addTarget(self, action: #selector(btnActions), for: .touchUpInside)
        bt.contentHorizontalAlignment = .left;
        
        return bt
    }()
    private lazy var dividendCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.clipsToBounds = true
        collectionView.layer.cornerRadius = 5
        collectionView.register(DividendCollectionViewCell.self, forCellWithReuseIdentifier: "DividendCollectionViewCell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initLayout()

        
        dividendCollectionView.dataSource = self
        dividendCollectionView.delegate = self


        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Actions
    @objc func btnActions(){
        delegate?.pushButtonTapped2()
    }
    //MARK: - Helpers
    func initLayout(){
        [
            dividendCollectionBackView,
            dividendTitleLabel,
            dividendSubTitleLabel,
            dividendQuestionBtn
        ]
            .forEach {
                self.addSubview($0)
            }
        self.backgroundColor = .systemMint
        self.snp.makeConstraints {
            $0.height.equalTo(250)
        }
        dividendCollectionBackView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview()
        }
        dividendTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(25)
        }
        dividendSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(dividendTitleLabel.snp.bottom)
            $0.leading.equalTo(dividendTitleLabel.snp.leading)
        }
        dividendQuestionBtn.snp.makeConstraints {
            $0.top.equalTo(dividendTitleLabel.snp.top)
            $0.trailing.equalToSuperview().offset(-20)
        }
        dividendCollectionBackView.addSubview(dividendCollectionView)
        dividendCollectionView.snp.makeConstraints {
            $0.centerX.centerY.width.height.equalTo(dividendCollectionBackView)
        }
    }
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
        return CGSize.init(width: dividendCollectionBackView.frame.width / 3.0 + 10, height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
