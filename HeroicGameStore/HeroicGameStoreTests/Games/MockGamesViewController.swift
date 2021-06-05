//
//  MockGamesViewController.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 3.06.2021.
//

@testable import HeroicGameStore
import UIKit

final class MockGamesViewController: GamesViewInterface {
    func prepareEmptyState() {
        
    }
    
    func removeFromSubViews() {
        
    }
    

    var invokedPrepareCollectionViews = false
    var invokedPrepareCollectionViewsCount = 0

    func prepareCollectionViews() {
        invokedPrepareCollectionViews = true
        invokedPrepareCollectionViewsCount += 1
    }

    var invokedReloadGames = false
    var invokedReloadGamesCount = 0

    func reloadGames() {
        invokedReloadGames = true
        invokedReloadGamesCount += 1
    }

    var invokedReloadPlatforms = false
    var invokedReloadPlatformsCount = 0

    func reloadPlatforms() {
        invokedReloadPlatforms = true
        invokedReloadPlatformsCount += 1
    }

    var invokedSetTitle = false
    var invokedSetTitleCount = 0
    var invokedSetTitleParameters: (title: String, Void)?
    var invokedSetTitleParametersList = [(title: String, Void)]()

    func setTitle(_ title: String) {
        invokedSetTitle = true
        invokedSetTitleCount += 1
        invokedSetTitleParameters = (title, ())
        invokedSetTitleParametersList.append((title, ()))
    }

    var invokedPrepareNavBar = false
    var invokedPrepareNavBarCount = 0

    func prepareNavBar() {
        invokedPrepareNavBar = true
        invokedPrepareNavBarCount += 1
    }

    var invokedPrepareSearchController = false
    var invokedPrepareSearchControllerCount = 0

    func prepareSearchController() {
        invokedPrepareSearchController = true
        invokedPrepareSearchControllerCount += 1
    }
}
