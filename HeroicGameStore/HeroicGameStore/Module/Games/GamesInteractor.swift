//
//  GamesInteractor.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 31.05.2021.
//

import Foundation
// GamesPresenter -> GamesInteractorInterface
protocol GamesInteractorInterface {
    func fetchGames(with url: String)
    func fetchPlatforms()
    
}
// GamesInteractorOutput -> GamesPresenter
protocol GamesInteractorOutput: AnyObject{
    func handleGamesResult(_ results:[HeroicResult],next: String)
    func handlePlatformResult(_ result: [PlatformResults])
}
final class GamesInteractor {
    weak var output: GamesInteractorOutput?
}
extension GamesInteractor: GamesInteractorInterface {
    func fetchPlatforms() {
        Service.shared.fetchPlatforms { [weak self] results in
            guard let self = self else {return}
            switch results {
            case .success(let platforms):
                self.output?.handlePlatformResult(platforms.results)
            case .failure(_):
                break
            }
        }
    }
    
    func fetchGames(with url: String) {
        Service.shared.fetchGames(next: url) { [weak self] results in
            guard let self = self else {return}
            switch results {
            case .success(let games):
                self.output?.handleGamesResult(games.results, next: games.next ?? "")
            case .failure(_):
                break
            }
        }
    }
}
