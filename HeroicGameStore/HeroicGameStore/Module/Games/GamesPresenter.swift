//
//  GamesPresenter.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 31.05.2021.
//

import Foundation

protocol GamesPresenterInterface {
    func viewDidLoad()
    func viewWilAppear()
    var numberOfGames: Int{ get }
    var numberOfPlatforms: Int{ get }
    func gameForIndex(_ index: Int) -> HeroicResult?
    func platformForIndex(_ index: Int) -> PlatformResults?
    func willDisplay(_ index: Int)
    func selectGame(at indexPath: Int)
    func fetchWithFilter(query: String)
    func fetchWithSearch(query: String)
    var selectedIndex : Int {get set}
    func fetchMainGames()
    var isSearching: Bool {get set}
    var currentSearchQuery: String {get set}
}

extension GamesPresenter {
    fileprivate enum Constants {
        static let basePageURL = "https://api.rawg.io/api/games?key=3bcebfccf85d42b2aa562a5f52139179&page=1"
    }
}

final class GamesPresenter {
    weak var view: GamesViewInterface?
    private let interactor: GamesInteractorInterface
    private let router: GamesRouterInterface
    let userDefault = UserDefaults.standard
    private var games: [HeroicResult] = []
    private var platforms: [PlatformResults] = []
    var selectedIndex = 0
    var isSearching = false
    var currentSearchQuery = ""
    private var requestURL = Constants.basePageURL
    
    init(view: GamesViewInterface?, interactor: GamesInteractorInterface, router: GamesRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    private func fetchGames(url: String) {
        interactor.fetchGames(with: url)
    }
    private func fetchPlatforms(){
        interactor.fetchPlatforms()
    }
    private func checkUserDefault(game: HeroicResult){
        if UserDefaults.exists(key: "name") {
            var tempArray = userDefault.array(forKey: "name") as! [String]
            if !tempArray.contains(game.name) {
                tempArray.append(game.name)
                userDefault.set(tempArray, forKey: "name")
            }
        }
        else {
            let tempArray = [game.name]
            userDefault.set(tempArray, forKey: "name")
        }

    }
}
extension GamesPresenter : GamesPresenterInterface {
    func fetchMainGames() {
        requestURL = Constants.basePageURL
        games.removeAll()
        fetchGames(url: requestURL)
    }
    

    func viewWilAppear() {
        view?.reloadGames()
    }
    
    func fetchWithSearch(query: String) {
        games.removeAll()
        let tempQuery = query.split(separator: " ")
        var searchQuery = ""
        tempQuery.map { searchQuery.append($0.description + "%20")}
        print(searchQuery)
        fetchGames(url: "https://api.rawg.io/api/games?key=3bcebfccf85d42b2aa562a5f52139179&page=1\(searchQuery)")
    }
    
    func fetchWithFilter(query: String) {
        games.removeAll()
        fetchGames(url:"https://api.rawg.io/api/games?key=3bcebfccf85d42b2aa562a5f52139179&page=1\(query)" )
    }
    
    func platformForIndex(_ index: Int) -> PlatformResults? {
        platforms[safe: index]
    }
    
    var numberOfPlatforms: Int {
        platforms.count
    }
    
    func selectGame(at indexPath: Int) {
        let game = games[indexPath]
        checkUserDefault(game: game)
        self.router.navigateToVC(with: game.id)
    }
    
    
    func gameForIndex(_ index: Int) -> HeroicResult? {
        games[safe: index]
    }
    func willDisplay(_ index: Int) {
        if index == (games.count - 2) {
            fetchGames(url: requestURL)
        }
    }
    
    var numberOfGames: Int {
        games.count
    }
    
    func viewDidLoad() {
            view?.prepareNavBar()
            view?.prepareSearchController()
            view?.prepareCollectionViews()
            view?.setTitle("Games")
        fetchGames(url: requestURL)
        fetchPlatforms()
    }
}

extension GamesPresenter: GamesInteractorOutput {
    func handlePlatformResult(_ result: [PlatformResults]) {
        platforms = result
        DispatchQueue.main.async {
            self.view?.reloadPlatforms()
        }
    }
    
    func handleGamesResult(_ results: [HeroicResult], next: String) {
        games.append(contentsOf: results)
        if games.count == 0 {
            view?.prepareEmptyState()
        }
        else {
            view?.removeFromSubViews()
            requestURL = next
            print(requestURL)
            print("count: \(games.last?.name)")
            DispatchQueue.main.async {
                self.view?.reloadGames()
            }
        }
    }
}

