//
//  ViewController.swift
//  NeflixClon
//
//  Created by rom on 19/07/2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        let homeVc = UINavigationController(rootViewController: HomeViewController())
        let comingVc = UINavigationController(rootViewController: UpcomingViewController())
        let searchVc = UINavigationController(rootViewController: SearchViewController())
        let downloadVc = UINavigationController(rootViewController: DownloadsViewController())
        
        homeVc.tabBarItem.image = UIImage(systemName: "house")
        comingVc.tabBarItem.image = UIImage(systemName: "play.circle")
        searchVc.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadVc.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        homeVc.title = "Home"
        comingVc.title = "Coming"
        searchVc.title = "Search"
        downloadVc.title = "Download"
        
        //Set the item tint colors
        tabBar.tintColor = .label
        // Set TabBarController
        setViewControllers([homeVc,comingVc,searchVc,downloadVc], animated: true)

    }


}

