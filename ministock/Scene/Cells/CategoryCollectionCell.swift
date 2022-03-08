//
//  CategoryCollectionCell.swift
//  ministock
//
//  Created by 윤지용 on 2022/02/22.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell{
    
    
    let testLabel : UILabel = {
      let lb = UILabel()
        lb.text = "감자고구"
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
                testLabel.textColor = .systemMint
                underLineView.isHidden = false

                
            }
            else{

                testLabel.textColor = .black
                underLineView.isHidden = true
                
                
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(testLabel)
        
        testLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        testLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.isSelected = true
        
        addSubview(underLineView)
        underLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        underLineView.leadingAnchor.constraint(equalTo: testLabel.leadingAnchor).isActive = true
        underLineView.trailingAnchor.constraint(equalTo: testLabel.trailingAnchor).isActive = true
    
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
