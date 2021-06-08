//
//  WishListRouter.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 1.06.2021.
//

import Foundation
import UIKit

protocol WishListRouterInterface: AnyObject {
    func navigateToVC(with id: Int)
}
final class WishListRouter {
    weak var navigationController: UINavigationController?
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    static func createModule(navigationController: UINavigationController) -> WishListViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "WishListViewController") as! WishListViewController
        let interactor = WishListInteractor()
        let router = WishListRouter(navigationController: navigationController)
        let presenter = WishListPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.output = presenter

        return view
    }
    
}

extension WishListRouter: WishListRouterInterface {
    func navigateToVC(with id: Int) {
        let gameDetailVC = GameDetailRouter.createModule(with: id)
        self.navigationController?.pushViewController(gameDetailVC, animated: true)
    }
    
    
}
