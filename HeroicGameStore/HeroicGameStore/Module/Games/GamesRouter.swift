//
//  GamesRouter.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 31.05.2021.
//

import Foundation
import UIKit

protocol GamesRouterInterface : AnyObject {
    func navigateToVC(with id : Int)
}

final class GamesRouter {
    weak var navigationController: UINavigationController?
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    static func createModule(navigationController: UINavigationController) -> GamesViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "GamesViewController") as! GamesViewController
        let interactor = GamesInteractor()
        let router = GamesRouter(navigationController: navigationController)
        let presenter = GamesPresenter(view: view, interactor: interactor,router: router)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}
extension GamesRouter: GamesRouterInterface {
    func navigateToVC(with id: Int) {
        let gameDetailVC = GameDetailRouter.createModule(with: id)
        self.navigationController?.pushViewController(gameDetailVC, animated: true)
    }
    
    
}

