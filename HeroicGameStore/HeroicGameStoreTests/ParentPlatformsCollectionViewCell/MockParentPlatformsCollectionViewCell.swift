//
//  MockParentPlatformsCollectionViewCell.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 5.06.2021.
//

import Foundation
@testable import HeroicGameStore

final class MockParentPlatformsCollectionViewCell: ParentPlatformsCollectionViewCellInterface {

    var invokedPrepareCell = false
    var invokedPrepareCellCount = 0

    func prepareCell() {
        invokedPrepareCell = true
        invokedPrepareCellCount += 1
    }

    var invokedPrepareTextLabel = false
    var invokedPrepareTextLabelCount = 0
    var invokedPrepareTextLabelParameters: (text: String, Void)?
    var invokedPrepareTextLabelParametersList = [(text: String, Void)]()

    func prepareTextLabel(with text: String) {
        invokedPrepareTextLabel = true
        invokedPrepareTextLabelCount += 1
        invokedPrepareTextLabelParameters = (text, ())
        invokedPrepareTextLabelParametersList.append((text, ()))
    }
}
