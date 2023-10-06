//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 18.02.2023.
//

import UIKit

/// Controller to house tabs and root tab controllers
final class RMTabBarController: UITabBarController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }

    private func setUpTabs() {
        let characterVC = RMCharacterViewController()
        let locationVC = RMLocationViewController()
        let episodeVC = RMEpisodeViewController()

        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        locationVC.navigationItem.largeTitleDisplayMode = .automatic
        episodeVC.navigationItem.largeTitleDisplayMode = .automatic

        let nav1 = UINavigationController(rootViewController: characterVC)
        let nav2 = UINavigationController(rootViewController: locationVC)
        let nav3 = UINavigationController(rootViewController: episodeVC)

        nav1.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 1)

        let navigations = [nav1, nav2, nav3]
        for nav in navigations {
            nav.navigationBar.prefersLargeTitles = true
        }
        setViewControllers(navigations, animated: true)
    }
}

