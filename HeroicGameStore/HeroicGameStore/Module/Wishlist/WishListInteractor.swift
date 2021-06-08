//
//  WishListInteractor.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 1.06.2021.
//

import Foundation
//Presenter -> here
protocol WishListInteractorInterface {
    func fetchGames(with id: Int)
}

//here-> presenter
protocol WishListInteractorOutput: AnyObject {
    func handleWishListResult(_ result:HeroicResult)
}

final class WishListInteractor {
    weak var output: WishListInteractorOutput?
}
extension WishListInteractor: WishListInteractorInterface {
    func fetchGames(with id: Int) {
            Service.shared.fetchGameWithID(id: id) { [weak self] results in
                guard let self = self else{return}
                switch results {
                case .success(let data):
                    self.output?.handleWishListResult(data)
                case .failure(_):
                    break
            }
        }
    }
}
