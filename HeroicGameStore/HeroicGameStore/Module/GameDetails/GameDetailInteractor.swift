//
//  GameDetailInteractor.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 2.06.2021.
//

import Foundation
//presenter -> here
protocol GameDetailInteractorInterface {
    func fetchGameDetail(with id: Int)
}
//here -> presenter
protocol GameDetailInteractorOutput: AnyObject {
    func handleGameResult(_ result: GameDetailModel?)
}

final class GameDetailInteractor {
    weak var output: GameDetailInteractorOutput?
}

extension GameDetailInteractor: GameDetailInteractorInterface {
    func fetchGameDetail(with id: Int) {
        Service.shared.fetchGameDetail(id: id) { [weak self] results in
            guard let self = self else{return}
            switch results {
            case .success(let data):
                self.output?.handleGameResult(data)
            case .failure(_):
                break
            }
        }
    }
    
    
}
