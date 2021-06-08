//
//  PlatformsPresenterTests.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 5.06.2021.
//

import XCTest
@testable import HeroicGameStore
class PlatformsPresenterTests: XCTestCase {
    
    var presenter: PlatformsCollectionViewCellPresenter!
    var view: MockPlatformsCollectionViewCell!

    override func setUp() {
        super.setUp()
        view = .init()
        presenter = .init(view: view, platform: HeroicModel.response[0].parent_platforms![0].platform)
    }
    
    func test_load(){
        XCTAssertFalse(view.invokedPrepareCell)
        presenter.load()
        XCTAssertTrue(view.invokedPrepareCell)
    }

}
