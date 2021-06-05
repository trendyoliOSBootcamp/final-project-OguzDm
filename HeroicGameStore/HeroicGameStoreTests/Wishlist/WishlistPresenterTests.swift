//
//  WishlistPresenterTests.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 4.06.2021.
//

import XCTest
@testable import HeroicGameStore

class WishlistPresenterTests: XCTestCase {

    var presenter: WishListPresenter!
    var view: MockWishlistViewController!
    var interactor: MockWishlistInteractor!
    var router: MockWishlistRouter!
    let userDefaults = UserDefaults.standard
    
    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, interactor: interactor, router: router)
        print(HeroicModel.game)
    }
    
    func test_viewWillAppear_InvokesFetchGames(){
        XCTAssertFalse(view.invokedPrepareTitle)
        XCTAssertFalse(view.invokedPrepareNavBar)
        XCTAssertFalse(view.invokedPrepareCollectionView)
        presenter.viewWillAppear()
        XCTAssertTrue(view.invokedPrepareTitle)
        XCTAssertTrue(view.invokedPrepareNavBar)
        XCTAssertTrue(view.invokedPrepareCollectionView)
    }
    
    func test_numberOfGames(){
        XCTAssertEqual(presenter.numberOfGames, 0)
        presenter.handleWishListResult(HeroicModel.game)
        XCTAssertEqual(presenter.numberOfGames, 1)
    }
    func test_selectGameWithExistsUserDefault(){
        presenter.handleWishListResult(HeroicModel.game)
        presenter.selectGame(at: 0)
    }
    func test_selectGameWithoutExistsUserDefault() {
        userDefaults.removeObject(forKey: "name")
        presenter.handleWishListResult(HeroicModel.game)
        presenter.selectGame(at: 0)
    }
    func test_selectGameWithExistsUserDefaultButNotContain(){
        presenter.handleWishListResult(HeroicModel.response[9])
        presenter.selectGame(at: 0)
    }
    func test_removeGame(){
        presenter.handleWishListResult(HeroicModel.game)
        presenter.removeGame(with: 0)
    }
    
    func test_gameForIndex(){
        presenter.handleWishListResult(HeroicModel.game)
        XCTAssertEqual(presenter.gameForIndex(0), HeroicModel.game)
    }
    func test_viewWillAppear_InvokesFetchGamesWithNotExistUserDefaults(){
        userDefaults.removeObject(forKey: "id")
        presenter.viewWillAppear()
    }
    func test_viewWillAppear_InvokesFetchGamesWithExistsUserDefaults(){
        presenter.handleWishListResult(HeroicModel.game)
        userDefaults.removeObject(forKey: "id")
        let tempArray = [HeroicModel.game.id]
        userDefaults.set(tempArray, forKey: "id")
        presenter.viewWillAppear()
    }
    func test_viewWillAppear_InvokesFetchGamesWithExistsUserDefaultsCountZero(){
        presenter.handleWishListResult(HeroicModel.game)
        userDefaults.set([Int](), forKey: "id")
        presenter.viewWillAppear()
    }
    

}

extension HeroicModel {
    static var game: HeroicResult {
        let bundle = Bundle(for: WishlistPresenterTests.self)
        let path = bundle.path(forResource: "Game", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let homeResponse = try! JSONDecoder().decode(HeroicResult.self, from: data)
        print(homeResponse.name)
        return homeResponse
    }

}
