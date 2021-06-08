//
//  MockGameDetailsInteractor.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 5.06.2021.
//

import Foundation
@testable import HeroicGameStore

final class MockGameDetailsInteractor: GameDetailInteractorInterface {

    var invokedFetchGameDetail = false
    var invokedFetchGameDetailCount = 0
    var invokedFetchGameDetailParameters: (id: Int, Void)?
    var invokedFetchGameDetailParametersList = [(id: Int, Void)]()

    func fetchGameDetail(with id: Int) {
        invokedFetchGameDetail = true
        invokedFetchGameDetailCount += 1
        invokedFetchGameDetailParameters = (id, ())
        invokedFetchGameDetailParametersList.append((id, ()))
    }
}
