//
//  SmallCardPresenterTests.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 5.06.2021.
//

import XCTest
@testable import HeroicGameStore
class SmallCardPresenterTests: XCTestCase {

    var presenter: SmallCardCollectionViewCellPresenter!
    var view: MockSmallCardViewCell!
    var delegate: SmallCardCollectionViewCellDelegate!
    let userDefault = UserDefaults.standard
    
    override func setUp() {
        view = .init()
        presenter = .init(view: view, game: HeroicModel.response[18], delegate: delegate)
    }
    
    func test_load(){
        userDefault.removeObject(forKey: "id")
        userDefault.removeObject(forKey: "name")
        XCTAssertFalse(view.invokedPrepareCell)
        XCTAssertFalse(view.invokedPrepareGameImage)
        XCTAssertFalse(view.invokedPrepareNameLabel)
        XCTAssertFalse(view.invokedPrepareNameColor)
        presenter.load()
        XCTAssertTrue(view.invokedPrepareCell)
        XCTAssertTrue(view.invokedPrepareGameImage)
        XCTAssertTrue(view.invokedPrepareNameLabel)
        XCTAssertTrue(view.invokedPrepareNameColor)
    }
    func test_wishListButtonTapped(){
        presenter.wishListButtonTapped()
    }
    func test_loadWithExistDefaultIDsAndContain(){
        let tempArray = [HeroicModel.response[0].id]
        userDefault.setValue(tempArray, forKey: "id")
        presenter.load()
    }
    func test_loadWithExistsDefaultNameAndContain(){
        let tempArray = [HeroicModel.response[0].name]
        userDefault.setValue(tempArray, forKey: "name")
        presenter.load()
    }
    func test_loadWithExistsDefaulButNotContainName(){
        presenter = .init(view: view, game: HeroicModel.response[17], delegate: delegate)
        presenter.load()
    }
}
