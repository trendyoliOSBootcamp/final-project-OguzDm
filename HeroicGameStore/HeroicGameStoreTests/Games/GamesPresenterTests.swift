//
//  GamesPresenterTests.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 3.06.2021.
//

import XCTest
@testable import HeroicGameStore

class GamesPresenterTests: XCTestCase {

    var presenter: GamesPresenter!
    var view: MockGamesViewController!
    var interactor: MockGamesInteractor!
    var router: MockGamesRouter!
    let userDefault = UserDefaults.standard

    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, interactor: interactor, router: router)
    }
    
    func test_viewDidLoad_InvokesRequiredViewMethods() {
        XCTAssertFalse(view.invokedPrepareNavBar)
        XCTAssertFalse(view.invokedPrepareSearchController)
        XCTAssertFalse(view.invokedPrepareCollectionViews)
        XCTAssertFalse(view.invokedSetTitle)
        XCTAssertFalse(interactor.invokedFetchGames)
        XCTAssertFalse(interactor.invokedFetchPlatforms)
        presenter.viewDidLoad()
        XCTAssertTrue(view.invokedPrepareNavBar)
        XCTAssertTrue(view.invokedPrepareSearchController)
        XCTAssertTrue(view.invokedPrepareCollectionViews)
        XCTAssertTrue(view.invokedSetTitle)
        XCTAssertEqual(view.invokedSetTitleParameters?.title, "Games")
        XCTAssertTrue(interactor.invokedFetchGames)
        XCTAssertEqual(interactor.invokedFetchGamesParameters?.url,"https://api.rawg.io/api/games?key=3bcebfccf85d42b2aa562a5f52139179&page=1")
    }

    func test_willDisplay_WithValidIndex_InvokesFetchGames(){
        presenter.handleGamesResult(HeroicModel.response, next:"https://api.rawg.io/api/games?key=3bcebfccf85d42b2aa562a5f52139179&page=2")
        XCTAssertFalse(interactor.invokedFetchGames)
        presenter.willDisplay(18)
        XCTAssertTrue(interactor.invokedFetchGames)

    }



    func test_fetchWithFilter_InvokesFetchGames(){
        XCTAssertFalse(interactor.invokedFetchGames)
        presenter.fetchWithFilter(query: "&parent_platforms=4")
        XCTAssertTrue(interactor.invokedFetchGames)
    }
    func test_platformForIndex_ReturnPlatform(){
        presenter.handlePlatformResult(PlatformModel.response)
        XCTAssertEqual(presenter.platformForIndex(0), PlatformModel.response[0])
    }

    func test_numberOfPlatforms(){
        presenter.handlePlatformResult(PlatformModel.response)
        XCTAssertEqual(presenter.numberOfPlatforms, PlatformModel.response.count)
    }

    func test_selectGame_InvokesNavigate(){
        presenter.handleGamesResult(HeroicModel.response, next: "https://api.rawg.io/api/games?key=3bcebfccf85d42b2aa562a5f52139179&page=2")
        presenter.selectGame(at: presenter.numberOfGames - 1)
    }

    func test_gameForIndexReturnGame() {
        presenter.handleGamesResult(HeroicModel.response, next: "https://api.rawg.io/api/games?key=3bcebfccf85d42b2aa562a5f52139179&page=2")
        XCTAssertEqual(presenter.gameForIndex(0), HeroicModel.response[0])
    }
    func test_checkUserDefultWithContainNameFalse(){
        presenter.handleGamesResult(HeroicModel.response, next: "https://api.rawg.io/api/games?key=3bcebfccf85d42b2aa562a5f52139179&page=2")
        presenter.selectGame(at: 8)
    }

    func test_checkUserDefaultWithNotExist(){
        userDefault.removeObject(forKey: "name")
        presenter.handleGamesResult(HeroicModel.response, next: "https://api.rawg.io/api/games?key=3bcebfccf85d42b2aa562a5f52139179&page=2")
        presenter.selectGame(at: 8)
    }
    
    func test_fetchWithSearch_WithEmptyResults(){
        presenter.handleGamesResult([HeroicResult](), next: "")
    }
    
    func test_fetchWithSearch_WithValidSearch(){
        presenter.fetchWithSearch(query: "&search=overwatch")
    }
    
    func test_fechMainGames(){
        XCTAssertFalse(interactor.invokedFetchGames)
        presenter.fetchMainGames()
        XCTAssertTrue(interactor.invokedFetchGames)
    }
    
    
    
  
    
}
extension HeroicModel {
    static var response: [HeroicResult] {
        let bundle = Bundle(for: GamesPresenterTests.self)
        let path = bundle.path(forResource: "Games", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let homeResponse = try! JSONDecoder().decode(HeroicModel.self, from: data)
        print(homeResponse.results[0].name)
        return homeResponse.results
    }

}

extension PlatformModel {
    static var response: [PlatformResults] {
        let bundle = Bundle(for: GamesPresenterTests.self)
        let path = bundle.path(forResource: "Platforms", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let homeResponse = try! JSONDecoder().decode(PlatformModel.self, from: data)
        return homeResponse.results
    }

}

