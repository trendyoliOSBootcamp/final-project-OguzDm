//
//  MockWislistInteractor.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 4.06.2021.
//

import Foundation
@testable import HeroicGameStore

final class MockWishlistInteractor: WishListInteractorInterface {

    var invokedFetchGames = false
    var invokedFetchGamesCount = 0
    var invokedFetchGamesParameters: (id: Int, Void)?
    var invokedFetchGamesParametersList = [(id: Int, Void)]()

    func fetchGames(with id: Int) {
        invokedFetchGames = true
        invokedFetchGamesCount += 1
        invokedFetchGamesParameters = (id, ())
        invokedFetchGamesParametersList.append((id, ()))
    }
}
