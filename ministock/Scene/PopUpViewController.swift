import UIKit

final class PopUpViewController: UIViewController{
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "최근 기간별"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let collectionBackView: UIView = {
        let uv = UIView()
        uv.layer.cornerRadius = 5
        uv.layer.borderColor = UIColor.systemGray4.cgColor
        uv.layer.borderWidth = 1
        return uv
    }()
    
    private let collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.layer.cornerRadius = 5
        
        return collectionView
    }()
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0 //화면 아래 300만큼 내려가있던게.. 0올라오면서..
            self.view.layoutIfNeeded()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        let tap = UITapGestureRecognizer(target: self, action: #selector(animateDismissView))
        dimmedView.addGestureRecognizer(tap)
        dimmedView.isUserInteractionEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        setupConstraints()
        
    }
    
    @objc func animateDismissView() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 300 // 다시 화면아래 300
            self.view.layoutIfNeeded()
        }
        dimmedView.alpha = 0.6
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
    func setupConstraints() {
        
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        
        containerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 300)
        
        containerViewBottomConstraint?.isActive = true
        
        containerView.addSubview(collectionBackView)
        collectionBackView.translatesAutoresizingMaskIntoConstraints = false
        collectionBackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        collectionBackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        collectionBackView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 3/4).isActive = true
        collectionBackView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.4).isActive = true
        
        collectionBackView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray4
        collectionView.topAnchor.constraint(equalTo: collectionBackView.topAnchor,constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: collectionBackView.leadingAnchor,constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: collectionBackView.trailingAnchor,constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: collectionBackView.bottomAnchor, constant: 0).isActive = true
        
        
        containerView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor,constant: -15).isActive = true
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
        
        return CGSize.init(width: collectionBackView.bounds.width/3.0, height: collectionBackView.frame.height/2.0 - 0.5)
        
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
}
