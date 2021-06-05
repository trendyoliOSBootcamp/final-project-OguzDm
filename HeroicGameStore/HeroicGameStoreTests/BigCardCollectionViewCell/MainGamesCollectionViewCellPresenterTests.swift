//
//  MainGamesCollectionViewCellPresenterTests.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 5.06.2021.
//

import XCTest
@testable import HeroicGameStore
class MainGamesCollectionViewCellPresenterTests: XCTestCase {

    var presenter: MainGamesCollectionViewCellPresenter!
    var view: MockMainGamesCollectionViewCell!
    let userDefaults = UserDefaults.standard
    override func setUp() {
        super.setUp()
        view = .init()
        presenter = .init(view: view, game: HeroicModel.response[0])//gtaV
    }
    
    func test_load(){
        XCTAssertFalse(view.invokedPrepareCell)
        XCTAssertFalse(view.invokedReloadTableView)
        XCTAssertFalse(view.invokedReloadCollectionView)
        presenter.load()
        XCTAssertTrue(view.invokedPrepareCell)
        XCTAssertTrue(view.invokedReloadTableView)
        XCTAssertTrue(view.invokedReloadCollectionView)
    }
    func test_numberOfItems(){
        XCTAssertEqual(presenter.numberOfItems, 3)
    }
    func test_numberOfCellElseCase(){
        XCTAssertEqual(presenter.numberOfCell, 3)
    }
    func test_numberOfCellIfCaseReturnFour(){
        presenter = .init(view: view, game: HeroicModel.response[1])//portal 2
        XCTAssertEqual(presenter.numberOfCell, 4)
    }
    func test_platformForIndex(){
        XCTAssertEqual(presenter.platformForIndex(1),HeroicModel.response[1].parent_platforms![1].platform)
    }
    func test_wishListButtonTappedUserDefaultNotExists(){
        userDefaults.removeObject(forKey: "id")
        presenter.wishListButtonTapped()
    }

}

