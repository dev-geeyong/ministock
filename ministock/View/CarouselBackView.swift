//
//  carouselBackView.swift
//  ministock
//
//  Created by 윤지용 on 2022/03/07.
//

import UIKit
import SnapKit

class CarouselBackView: UIView {
    //MARK: - Propertie
    private var currentIdx: Int = 0
    let carouselCollectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = .red
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        carouselCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "carouselCollectionView")
        carouselCollectionView.showsHorizontalScrollIndicator = false
        carouselCollectionView.isPagingEnabled = true
        
        self.addSubview(carouselCollectionView)
    
        carouselCollectionView.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalTo(self)
        }
        startAutoCarouselScroll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Actions
    
    //MARK: - Helpers
    func startAutoCarouselScroll() {
        //전체 cell 개수
        let totalCellCount = carouselCollectionView
            .numberOfItems(inSection: 0)
        
        DispatchQueue.global(qos: .default).async {
            while true
            {
                //2초에 한 번씩 paging
                sleep(2)
                
                DispatchQueue.main.async {
                    self.carouselCollectionView.scrollToItem(at: IndexPath(item: self.currentIdx, section: 0), at: .right, animated: true)
                    
                    //다시 처음으로
                    if self.currentIdx == totalCellCount - 1 {
                        self.currentIdx = 0
                    }
                    else {
                        self.currentIdx += 1
                    }
                }
            }
            
        }
    }
}
extension CarouselBackView: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate ,UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        self.currentIdx = page
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCollectionView", for: indexPath)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == carouselCollectionView{
            
            if indexPath.row == 0 {
                cell.backgroundColor = .red
            }
            else if indexPath.row == 1 {
                cell.backgroundColor = .blue
            }
            else if indexPath.row == 2 {
                cell.backgroundColor = .systemGreen
            }
            else if indexPath.row == 3 {
                cell.backgroundColor = .systemMint
            }
            else{
                cell.backgroundColor = .purple
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
}
