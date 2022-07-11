//
//  CategoryCollectionCell.swift
//  ministock
//
//  Created by 윤지용 on 2022/02/22.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell{
    let categoryTitle : UILabel = {
      let lb = UILabel()
        lb.text = "카테고리"
        lb.font = UIFont.boldSystemFont(ofSize: 15)
        lb.sizeToFit()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let underLineView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemMint
        uv.heightAnchor.constraint(equalToConstant: 3).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.isHidden = true
        return uv
    }()
    override var isSelected: Bool{
        didSet{
            if isSelected{
                categoryTitle.textColor = .systemMint
                underLineView.isHidden = false
            }
            else{
                categoryTitle.textColor = .black
                underLineView.isHidden = true
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryTitle)
        categoryTitle.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        addSubview(underLineView)
        underLineView.snp.makeConstraints {
            $0.leading.equalTo(categoryTitle.snp.leading)
            $0.trailing.equalTo(categoryTitle.snp.trailing)
            $0.bottom.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
