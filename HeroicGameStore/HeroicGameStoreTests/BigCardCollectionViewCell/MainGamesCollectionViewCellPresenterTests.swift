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
        reCreate(image: nil, released: nil,genre: nil,platform: [ParentPlatform(platform: Platform(name: ""))], metacritic: nil)
    }
    
    private func reCreate(image: String?,
                          released: String?,
                          genre:[Genre]?,platform: [ParentPlatform]?,metacritic:Int?) {
        let result = HeroicResult(id: 56,
                                  name: "bla",
                                  metacritic: metacritic,
                                  released: released,
                                  background_image: image,
                                  playtime: 12,
                                  parent_platforms: platform ,
                                  genres: genre)
        
        presenter = .init(view: view, game: result)
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
        XCTAssertEqual(presenter.numberOfItems, 1)
    }
    func test_numberOfCellIfCaseReturnFour(){
        presenter = .init(view: view, game: HeroicModel.response[1])
        XCTAssertEqual(presenter.numberOfCell, 4)
    }
    func test_platformForIndex(){
        XCTAssertEqual(presenter.platformForIndex(0),Platform(name: ""))
    }
    func test_wishListButtonTappedUserDefaultNotExists(){
        userDefaults.removeObject(forKey: "id")
        presenter.wishListButtonTapped()
    }
    func test_loadWithValidImage(){
        reCreate(image: "dsqd",released: nil, genre: nil,platform: [ParentPlatform(platform: Platform(name: ""))], metacritic: nil)
        presenter.load()
    }
    func test_loadWithValidTableViewData(){
        reCreate(image: "dummyImage", released: "dummyReleased", genre: [Genre(name: "dummyGenre"),Genre(name: "dummyAnotherGenre")],platform: [ParentPlatform(platform: Platform(name: ""))], metacritic: nil)
        presenter.load()
    }
    func test_calculateCellSizeForIndexThree(){
    XCTAssertEqual(presenter.calculateCellSize(3), 30)
    }
    func test_calculateCellSizeFor10_20(){
        reCreate(image: "dummyImage", released: "dummyReleased", genre: [Genre(name: "dummyGenre"),Genre(name: "dummyAnotherGenre")],platform: [ParentPlatform(platform: Platform(name: "aaaaaaaaaaa"))], metacritic: nil)
        XCTAssertEqual(presenter.calculateCellSize(0), 70)
    }
    func test_calculateCellSizeFor2(){
        reCreate(image: "dummyImage", released: "dummyReleased", genre: [Genre(name: "dummyGenre"),Genre(name: "dummyAnotherGenre")],platform: [ParentPlatform(platform: Platform(name: "aa"))], metacritic: nil)
        XCTAssertEqual(presenter.calculateCellSize(0), 30)
    }
    func test_calculateCellSizeForDefaulCase(){
        reCreate(image: "dummyImage", released: "dummyReleased", genre: [Genre(name: "dummyGenre"),Genre(name: "dummyAnotherGenre")],platform: [ParentPlatform(platform: Platform(name: "aaa"))], metacritic: nil)
        XCTAssertEqual(presenter.calculateCellSize(0), 33)
    }
    func test_numberOfItemsNilPlatforms(){
        reCreate(image: "dummyImage", released: "dummyReleased", genre: [Genre(name: "dummyGenre"),Genre(name: "dummyAnotherGenre")],platform: nil, metacritic: nil)
        XCTAssertEqual(presenter.numberOfItems, 0)
    }
    func test_platformsCountWithValid(){
        reCreate(image: "dummyImage", released: "dummyReleased", genre: [Genre(name: "dummyGenre"),Genre(name: "dummyAnotherGenre")],platform: [ParentPlatform(platform: Platform(name: "aaa"))], metacritic: nil)
        XCTAssertEqual(presenter.platformsCount, 1)
    }
    func test_platformsCountWithNilPlatforms(){
        reCreate(image: "dummyImage", released: "dummyReleased", genre: [Genre(name: "dummyGenre"),Genre(name: "dummyAnotherGenre")],platform: nil, metacritic: nil)
        XCTAssertEqual(presenter.platformsCount, 0)
    }
    func test_PlatformForIndexNil(){
        reCreate(image: "dummyImage", released: "dummyReleased", genre: [Genre(name: "dummyGenre"),Genre(name: "dummyAnotherGenre")],platform: nil, metacritic: nil)
        XCTAssertEqual(presenter.platformForIndex(0), Platform(name: ""))
    }
    func test_numberOfCellAboveThree(){
        reCreate(image: "dummyImage", released: "dummyReleased", genre: [Genre(name: "dummyGenre"),Genre(name: "dummyAnotherGenre")],platform: [ParentPlatform(platform: Platform(name: "bbb")),ParentPlatform(platform: Platform(name: "ccc")),ParentPlatform(platform: Platform(name: "ddd")),ParentPlatform(platform: Platform(name: "eee"))], metacritic: nil)
        XCTAssertGreaterThan(presenter.numberOfCell, 3)
    }
    func test_numberOfCellElseCase(){
        reCreate(image: "dummyImage", released: "dummyReleased", genre: [Genre(name: "dummyGenre"),Genre(name: "dummyAnotherGenre")],platform: [ParentPlatform(platform: Platform(name: "bbb")),ParentPlatform(platform: Platform(name: "ccc")),ParentPlatform(platform: Platform(name: "ddd"))], metacritic: nil)
        XCTAssertLessThan(presenter.numberOfCell, 4)
    }
    func test_load_With75_100Metacritic(){
        reCreate(image: "dummyImage", released: "dummyReleased", genre: nil, platform: nil, metacritic: 80)
        presenter.load()
    }
    func test_load_With50_74Metacritic(){
        reCreate(image: "dummyImage", released: "dummyReleased", genre: nil, platform: nil, metacritic: 73)
        presenter.load()
    }
}

extension HeroicModel {
    static var Result: [HeroicResult] {
        let bundle = Bundle(for: MainGamesCollectionViewCellPresenterTests.self)
        let path = bundle.path(forResource: "GamesPageTwo", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let homeResponse = try! JSONDecoder().decode(HeroicModel.self, from: data)
        print(homeResponse.results[0].name)
        return homeResponse.results
    }

}

