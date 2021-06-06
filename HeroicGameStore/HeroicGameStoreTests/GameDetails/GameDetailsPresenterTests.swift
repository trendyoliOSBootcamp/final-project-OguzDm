//
//  GameDetailsPresenterTests.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 5.06.2021.
//

import XCTest
@testable import HeroicGameStore
class GameDetailsPresenterTests: XCTestCase {

    var presenter: GameDetailPresenter!
    var view: MockGameDetailsViewController!
    var interactor: MockGameDetailsInteractor!
    var router: MockGameDetailsRouter!
    let userDefaults = UserDefaults.standard
 
    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, interactor: interactor, router: router, id: 33451)
    }
    
    func test_viewDidLoad_InvokesFertchGameDetail(){
        XCTAssertFalse(view.invokedConfigureViewHiearchy)
        XCTAssertFalse(view.invokedPrepareTableView)
        XCTAssertFalse(view.invokedPrepareNavBar)
        XCTAssertFalse(interactor.invokedFetchGameDetail)
        presenter.viewDidLoad()
        XCTAssertTrue(view.invokedConfigureViewHiearchy)
        XCTAssertTrue(view.invokedPrepareTableView)
        XCTAssertTrue(view.invokedPrepareNavBar)
        XCTAssertTrue(interactor.invokedFetchGameDetail)
    }
    func test_setTableViewData(){
        presenter.handleGameResult(GameDetailModel.response)
        print(presenter.setTableViewData())
    }
    func test_wishListButtonTappedWithExistUserDefaultsAndId(){
        presenter.handleGameResult(GameDetailModel.response)
        userDefaults.removeObject(forKey: "id")
        let temp = [GameDetailModel.response.id]
        userDefaults.set(temp, forKey: "id")
        presenter.wishListButtonTapped()
    }
    func test_wishListButtonTappedWithNotExistsUserDefaults(){
        userDefaults.removeObject(forKey: "id")
        presenter.wishListButtonTapped()
    }
    func test_wishListButtonTappedWithExistsUserDefaultsButNotContain(){
        presenter.wishListButtonTapped()
    }
    func test_qdsq(){
        presenter.handleGameResult(nil)
        presenter.setTableViewData()
    }
    
}
extension GameDetailModel {
    static var response: GameDetailModel {
        let bundle = Bundle(for: GameDetailsPresenterTests.self)
        let path = bundle.path(forResource: "result", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let homeResponse = try! JSONDecoder().decode(GameDetailModel.self, from: data)
        print(homeResponse)
        return homeResponse
    }
}
