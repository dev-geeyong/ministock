//
//  MainTapViewController.swift
//  ministock
//
//  Created by IT on 2022/02/21.
//

import UIKit
 

class MainTapBarController: UITabBarController {
    //MARK: - Propertie
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        
    }
    //MARK: - Actions
    //MARK: - Helpers
    func configureViewController(){
        let main = templateNavigationController(unselectedImage: UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, rootViewController: MainViewController())
        let search = templateNavigationController(unselectedImage: UIImage(systemName: "magnifyingglass")!, selectedImage: UIImage(systemName: "magnifyingglass")!, rootViewController: SearchViewController())
        let themes = templateNavigationController(unselectedImage: UIImage(systemName: "chart.line.uptrend.xyaxis")!, selectedImage: UIImage(systemName: "chart.line.uptrend.xyaxis")!, rootViewController: ThemesViewController())
        let account = templateNavigationController(unselectedImage: UIImage(systemName: "wallet.pass")!, selectedImage: UIImage(systemName: "wallet.pass.fill")!, rootViewController: AccountViewController())
        let setting = templateNavigationController(unselectedImage: UIImage(systemName: "ellipsis")!, selectedImage: UIImage(systemName: "ellipsis")!, rootViewController: SettingViewController())
        
        
        viewControllers = [main,search,themes,account,setting]
        tabBar.tintColor = .systemMint
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
    }
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController{
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.isHidden = true
        
        return nav
    }
}
