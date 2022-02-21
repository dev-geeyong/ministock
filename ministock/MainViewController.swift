//
//  ViewController.swift
//  ministock
//
//  Created by IT on 2022/02/15.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: - Propertie
   

    private let slideShowView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .red
        uv.translatesAutoresizingMaskIntoConstraints = false
        uv.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return uv
    }()
    
    let myFavoriteView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemGray5
        uv.heightAnchor.constraint(equalToConstant: 220).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    private let myFavoriteBackView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .white
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    private let myFavoriteLabel: UILabel = {
       let lb = UILabel()
        lb.text = "관심 주식"
        lb.font = UIFont.boldSystemFont(ofSize: 18)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let stocksView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemMint
        uv.heightAnchor.constraint(equalToConstant: 700).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    let dividendStocksView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .green
        uv.heightAnchor.constraint(equalToConstant: 200).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    let exchangeRateView: UIView = {
       let uv = UIView()
        uv.backgroundColor = .systemBlue
        uv.heightAnchor.constraint(equalToConstant: 150).isActive = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    let carouselCollectionView: UICollectionView = {
            
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white

        return collectionView
    }()
    let scrollView = UIScrollView()
    let contentView = UIView()
    var currentIdx: Int = 0
    let tableView = UITableView(frame: .zero, style: .plain)
  
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MyFavoriteTableViewCell.self, forCellReuseIdentifier: "MyFavoriteTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 50
        tableView.separatorStyle = .none
        initLayout()
        test()
       startAutoScroll()
        
    }
    //MARK: - Actions
    //MARK: - Helpers

    func initLayout(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        contentView.backgroundColor = .systemGray4
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [slideShowView,myFavoriteView,stocksView,dividendStocksView,exchangeRateView])
        stackView.axis = .vertical
        
//        stackView.alignment = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        
        myFavoriteView.addSubview(myFavoriteBackView)
        myFavoriteBackView.topAnchor.constraint(equalTo: myFavoriteView.topAnchor, constant: 10).isActive = true
        myFavoriteBackView.leadingAnchor.constraint(equalTo: myFavoriteView.leadingAnchor, constant: 0).isActive = true
        myFavoriteBackView.trailingAnchor.constraint(equalTo: myFavoriteView.trailingAnchor).isActive = true
        myFavoriteBackView.bottomAnchor.constraint(equalTo: myFavoriteView.bottomAnchor, constant: -10).isActive = true
        
        myFavoriteBackView.addSubview(myFavoriteLabel)
        myFavoriteLabel.topAnchor.constraint(equalTo: myFavoriteBackView.topAnchor, constant: 15).isActive = true
        myFavoriteLabel.leadingAnchor.constraint(equalTo: myFavoriteBackView.leadingAnchor, constant: 15).isActive = true
        
        myFavoriteBackView.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: myFavoriteLabel.bottomAnchor,constant: 15).isActive = true
        tableView.leadingAnchor.constraint(equalTo: myFavoriteLabel.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: myFavoriteBackView.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: myFavoriteBackView.bottomAnchor).isActive = true
        tableView.backgroundColor = .red
      
    }
    func test(){
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        carouselCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
                
        
        slideShowView.addSubview(carouselCollectionView)
        carouselCollectionView.isPagingEnabled = true
        NSLayoutConstraint.activate([
            carouselCollectionView.centerXAnchor.constraint(equalTo: slideShowView.centerXAnchor, constant: 0),
            carouselCollectionView.centerYAnchor.constraint(equalTo: slideShowView.centerYAnchor, constant: 0),
            carouselCollectionView.widthAnchor.constraint(equalTo: slideShowView.widthAnchor),
            carouselCollectionView.heightAnchor.constraint(equalTo: slideShowView.heightAnchor)

            ])
    }
    func startAutoScroll() {
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

extension MainViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("->end ",indexPath.row,currentIdx)

    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("->will ",indexPath.row,currentIdx)
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            CGSize.init(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }
        
        //section 내부 cell간의 공간을 제거
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            0
        }
        
        //section 사이의 공간을 제거
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            0
        }
    

}



extension MainViewController : UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        self.currentIdx = page
        
        }
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFavoriteTableViewCell", for: indexPath) as! MyFavoriteTableViewCell?
        
        return cell!
    }
    
    
}
