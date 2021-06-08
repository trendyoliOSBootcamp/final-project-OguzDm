//
//  ParentPlatformsPresenterTests.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 5.06.2021.
//

import XCTest
@testable import HeroicGameStore
class ParentPlatformsPresenterTests: XCTestCase {

    var view : MockParentPlatformsCollectionViewCell!
    var presenter: ParentPlatformsPresenter!
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        presenter = .init(view: view, platform: PlatformModel.response[0])
    }
    
    func test_load(){
        XCTAssertFalse(view.invokedPrepareCell)
        presenter.load()
        XCTAssertTrue(view.invokedPrepareCell)
    }
    
}
