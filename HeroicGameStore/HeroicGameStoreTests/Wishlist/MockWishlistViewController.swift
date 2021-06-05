//
//  MockWishlistViewController.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 4.06.2021.
//

@testable import HeroicGameStore
import UIKit

final class MockWishlistViewController: WishListViewInterface {

    var invokedPrepareCollectionView = false
    var invokedPrepareCollectionViewCount = 0

    func prepareCollectionView() {
        invokedPrepareCollectionView = true
        invokedPrepareCollectionViewCount += 1
    }

    var invokedPrepareTitle = false
    var invokedPrepareTitleCount = 0
    var invokedPrepareTitleParameters: (text: String, Void)?
    var invokedPrepareTitleParametersList = [(text: String, Void)]()

    func prepareTitle(with text: String) {
        invokedPrepareTitle = true
        invokedPrepareTitleCount += 1
        invokedPrepareTitleParameters = (text, ())
        invokedPrepareTitleParametersList.append((text, ()))
    }

    var invokedReloadData = false
    var invokedReloadDataCount = 0

    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }

    var invokedPrepareNavBar = false
    var invokedPrepareNavBarCount = 0

    func prepareNavBar() {
        invokedPrepareNavBar = true
        invokedPrepareNavBarCount += 1
    }

    var invokedPrepareEmptyState = false
    var invokedPrepareEmptyStateCount = 0

    func prepareEmptyState() {
        invokedPrepareEmptyState = true
        invokedPrepareEmptyStateCount += 1
    }
}
