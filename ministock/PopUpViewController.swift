import UIKit

final class PopUpViewController: UIViewController {
    
    private let popUpView = UIView()
    private let dismissButton = UIButton()
    private let popUpBtnView: UIView = {
       let uv = UIView()
        uv.layer.cornerRadius = 5
        uv.layer.borderColor = UIColor.systemGray4.cgColor
        uv.layer.borderWidth = 1
        return uv
    }()
    private let label: UILabel = {
       let lb = UILabel()
        lb.text = "최근 기간별"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.layer.cornerRadius = 5
        
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemGray.withAlphaComponent(0.6)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        popUpView.backgroundColor = UIColor.white


        dismissButton.addTarget(self, action: #selector(didTapDismissButton(_:)), for: .touchUpInside)
        dismissButton.backgroundColor = .clear
        view.addSubview(dismissButton)
        

        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dismissButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

        
        dismissButton.addSubview(popUpView)
        popUpView.layer.cornerRadius = 10
        popUpView.translatesAutoresizingMaskIntoConstraints = false
        popUpView.bottomAnchor.constraint(equalTo: dismissButton.bottomAnchor).isActive = true
        popUpView.leadingAnchor.constraint(equalTo: dismissButton.leadingAnchor).isActive = true
        popUpView.trailingAnchor.constraint(equalTo: dismissButton.trailingAnchor).isActive = true
        popUpView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        popUpView.addSubview(popUpBtnView)
        popUpBtnView.translatesAutoresizingMaskIntoConstraints = false
        popUpBtnView.centerXAnchor.constraint(equalTo: popUpView.centerXAnchor).isActive = true
        popUpBtnView.centerYAnchor.constraint(equalTo: popUpView.centerYAnchor).isActive = true
        popUpBtnView.widthAnchor.constraint(equalTo: popUpView.widthAnchor, multiplier: 3/4).isActive = true
        popUpBtnView.heightAnchor.constraint(equalTo: popUpView.heightAnchor, multiplier: 1/2).isActive = true
        
        popUpView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: popUpBtnView.leadingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: popUpBtnView.topAnchor,constant: -10).isActive = true
        
        popUpBtnView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray4
        collectionView.topAnchor.constraint(equalTo: popUpBtnView.topAnchor,constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: popUpBtnView.leadingAnchor,constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: popUpBtnView.trailingAnchor,constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: popUpBtnView.bottomAnchor, constant: 0).isActive = true
        
    }
    
    @objc func didTapDismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
extension PopUpViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize.init(width: popUpBtnView.bounds.width/3.0, height: popUpBtnView.frame.height/2.0 - 0.5)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 1.0
       }
       
       // CollectionView Cell의 옆 간격
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 1.0
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    //"전일","1개월","3개월","6개월","1년","3년"
}
