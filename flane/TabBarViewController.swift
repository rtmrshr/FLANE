//
//  ViewController.swift
//  flane
//
//  Created by  ratmir on 22.02.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let mapVC = MapViewController()
    let searchVC = SearchViewController()
    let settingsVC = SettingsViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapVC.tabBarItem.image = UIImage(systemName: "map")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        settingsVC.tabBarItem.image = UIImage(systemName: "gear")
        
        self.setViewControllers([mapVC, searchVC, settingsVC], animated: false)
        self.modalPresentationStyle = .fullScreen
    }


}

