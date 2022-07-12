import UIKit

final class PopUpViewController: UIViewController {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()
    private lazy var titleLabel: UILabel = {
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
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.layer.cornerRadius = 5
        collectionView.backgroundColor = .systemGray4
        return collectionView
    }()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5) {
            self.containerView.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(0)
            }
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
        initLayout()
    }
    @objc func animateDismissView() {
        UIView.animate(withDuration: 0.3) {
            self.containerView.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(300)
            }
            self.view.layoutIfNeeded()
        }
        dimmedView.alpha = 0.6
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    func initLayout() {
        view.addSubview(dimmedView)
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        view.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
            $0.bottom.equalToSuperview().offset(300)
        }
        containerView.addSubview(collectionBackView)
        collectionBackView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(containerView)
            $0.width.equalTo(containerView.snp.width).multipliedBy(0.75)
            $0.height.equalTo(containerView).multipliedBy(0.4)
        }
        collectionBackView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(collectionBackView)
        }
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(collectionBackView.snp.leading)
            $0.bottom.equalTo(collectionView.snp.top).offset(-15)
        }
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionBackView.bounds.width/3.0, height: collectionBackView.frame.height/2.0 - 0.5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
