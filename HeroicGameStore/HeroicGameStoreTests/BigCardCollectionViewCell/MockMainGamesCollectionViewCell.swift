//
//  MockMainGamesCollectionViewCell.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 5.06.2021.
//

import Foundation
@testable import HeroicGameStore

final class MockMainGamesCollectionViewCell: MainGamesCollectionViewCellInterface {

    var invokedPrepareCell = false
    var invokedPrepareCellCount = 0

    func prepareCell() {
        invokedPrepareCell = true
        invokedPrepareCellCount += 1
    }

    var invokedPrepareNameLabel = false
    var invokedPrepareNameLabelCount = 0
    var invokedPrepareNameLabelParameters: (text: String, Void)?
    var invokedPrepareNameLabelParametersList = [(text: String, Void)]()

    func prepareNameLabel(with text: String) {
        invokedPrepareNameLabel = true
        invokedPrepareNameLabelCount += 1
        invokedPrepareNameLabelParameters = (text, ())
        invokedPrepareNameLabelParametersList.append((text, ()))
    }

    var invokedPrepareNameColor = false
    var invokedPrepareNameColorCount = 0
    var invokedPrepareNameColorParameters: (color: String, Void)?
    var invokedPrepareNameColorParametersList = [(color: String, Void)]()

    func prepareNameColor(with color: String) {
        invokedPrepareNameColor = true
        invokedPrepareNameColorCount += 1
        invokedPrepareNameColorParameters = (color, ())
        invokedPrepareNameColorParametersList.append((color, ()))
    }

    var invokedPrepareGameImage = false
    var invokedPrepareGameImageCount = 0
    var invokedPrepareGameImageParameters: (url: String, Void)?
    var invokedPrepareGameImageParametersList = [(url: String, Void)]()

    func prepareGameImage(with url: String) {
        invokedPrepareGameImage = true
        invokedPrepareGameImageCount += 1
        invokedPrepareGameImageParameters = (url, ())
        invokedPrepareGameImageParametersList.append((url, ()))
    }

    var invokedPrepareMetacriticLabel = false
    var invokedPrepareMetacriticLabelCount = 0
    var invokedPrepareMetacriticLabelParameters: (text: String, Void)?
    var invokedPrepareMetacriticLabelParametersList = [(text: String, Void)]()

    func prepareMetacriticLabel(with text: String) {
        invokedPrepareMetacriticLabel = true
        invokedPrepareMetacriticLabelCount += 1
        invokedPrepareMetacriticLabelParameters = (text, ())
        invokedPrepareMetacriticLabelParametersList.append((text, ()))
    }

    var invokedPrepareWishlistBackgroundView = false
    var invokedPrepareWishlistBackgroundViewCount = 0
    var invokedPrepareWishlistBackgroundViewParameters: (color: String, Void)?
    var invokedPrepareWishlistBackgroundViewParametersList = [(color: String, Void)]()

    func prepareWishlistBackgroundView(with color: String) {
        invokedPrepareWishlistBackgroundView = true
        invokedPrepareWishlistBackgroundViewCount += 1
        invokedPrepareWishlistBackgroundViewParameters = (color, ())
        invokedPrepareWishlistBackgroundViewParametersList.append((color, ()))
    }

    var invokedPrepareMetacriticColor = false
    var invokedPrepareMetacriticColorCount = 0
    var invokedPrepareMetacriticColorParameters: (color: String, Void)?
    var invokedPrepareMetacriticColorParametersList = [(color: String, Void)]()

    func prepareMetacriticColor(with color: String) {
        invokedPrepareMetacriticColor = true
        invokedPrepareMetacriticColorCount += 1
        invokedPrepareMetacriticColorParameters = (color, ())
        invokedPrepareMetacriticColorParametersList.append((color, ()))
    }

    var invokedReloadCollectionView = false
    var invokedReloadCollectionViewCount = 0

    func reloadCollectionView() {
        invokedReloadCollectionView = true
        invokedReloadCollectionViewCount += 1
    }

    var invokedReloadTableView = false
    var invokedReloadTableViewCount = 0

    func reloadTableView() {
        invokedReloadTableView = true
        invokedReloadTableViewCount += 1
    }

    var invokedPrepareTableView = false
    var invokedPrepareTableViewCount = 0
    var invokedPrepareTableViewParameters: (titles: [String], descriptions: [String])?
    var invokedPrepareTableViewParametersList = [(titles: [String], descriptions: [String])]()

    func prepareTableView(titles: [String], descriptions: [String]) {
        invokedPrepareTableView = true
        invokedPrepareTableViewCount += 1
        invokedPrepareTableViewParameters = (titles, descriptions)
        invokedPrepareTableViewParametersList.append((titles, descriptions))
    }
}
