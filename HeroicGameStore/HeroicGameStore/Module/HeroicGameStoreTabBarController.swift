//
//  HeroicGameStoreViewController.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 1.06.2021.
//

import UIKit

class HeroicGameStoreTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
        tabBar.barTintColor = #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.5)
        tabBar.tintColor = .white
        heroicTabbar()
    }
    
    private func heroicTabbar() {
        let gamesNav = UINavigationController()
        let wishListNav = UINavigationController()
        let gamesVC = GamesRouter.createModule(navigationController: gamesNav)
        let wishListVC = WishListRouter.createModule(navigationController: wishListNav)
        gamesNav.viewControllers = [gamesVC]
        wishListNav.viewControllers = [wishListVC]
        self.addChild(gamesNav)
        self.addChild(wishListNav)
        gamesNav.tabBarItem.image = UIImage(systemName: "gamecontroller")
        gamesNav.tabBarItem.title = "Games"
        wishListNav.tabBarItem.image = #imageLiteral(resourceName: "gift")
        wishListNav.tabBarItem.title = "Wishlist"
    }
}
