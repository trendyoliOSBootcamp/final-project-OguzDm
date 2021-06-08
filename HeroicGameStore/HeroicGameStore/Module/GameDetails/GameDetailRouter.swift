//
//  GameDetailRouter.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 2.06.2021.
//

import Foundation
import UIKit

protocol GameDetailRouterInterface: AnyObject {
    
}

final class GameDetailRouter: GameDetailRouterInterface {

    static func createModule(with id: Int ) -> GameDetailViewController {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let view = storyBoard.instantiateViewController(identifier: "GameDetailViewController") as! GameDetailViewController
        let interactor = GameDetailInteractor()
        let router = GameDetailRouter()
        let presenter = GameDetailPresenter.init(view: view, interactor: interactor, router: router, id: id )
        
        interactor.output = presenter
        view.presenter = presenter
        
        return view
    }
}
