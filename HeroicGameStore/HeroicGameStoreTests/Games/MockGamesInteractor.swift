//
//  MockGamesInteractor.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 3.06.2021.
//

import Foundation
@testable import HeroicGameStore

final class MockGamesInteractor: GamesInteractorInterface {

    var invokedFetchGames = false
    var invokedFetchGamesCount = 0
    var invokedFetchGamesParameters: (url: String, Void)?
    var invokedFetchGamesParametersList = [(url: String, Void)]()

    func fetchGames(with url: String) {
        invokedFetchGames = true
        invokedFetchGamesCount += 1
        invokedFetchGamesParameters = (url, ())
        invokedFetchGamesParametersList.append((url, ()))
    }

    var invokedFetchPlatforms = false
    var invokedFetchPlatformsCount = 0

    func fetchPlatforms() {
        invokedFetchPlatforms = true
        invokedFetchPlatformsCount += 1
    }
}
