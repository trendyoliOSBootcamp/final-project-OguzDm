//
//  MockSmallCardViewCell.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 5.06.2021.
//

import Foundation
@testable import HeroicGameStore

final class MockSmallCardViewCell: SmallCardCollectionViewCellInterface {

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
}
