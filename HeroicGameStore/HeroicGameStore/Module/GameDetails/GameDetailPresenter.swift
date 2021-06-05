//
//  GameDetailPresenter.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 2.06.2021.
//

import Foundation

protocol GameDetailPresenterInterface {
    func viewDidLoad()
    func setTableViewData() -> (titles:[String],descriptions:[String])
    func wishListButtonTapped()
    
}
final class GameDetailPresenter {
    weak var view: GameDetailViewInterface?
    private let interactor: GameDetailInteractorInterface
    private var game: GameDetailModel?
    private var router: GameDetailRouterInterface
    private let id: Int
    let userDefault = UserDefaults.standard
    init(view:GameDetailViewInterface?, interactor:GameDetailInteractorInterface,router: GameDetailRouterInterface, id: Int  ) {
        self.view = view
        self.interactor = interactor
        self.id = id
        self.router = router
    }
    private func fetchGameDetail() {
        self.interactor.fetchGameDetail(with: self.id)
    }
}

extension GameDetailPresenter: GameDetailPresenterInterface {
    func wishListButtonTapped() {
        if UserDefaults.exists(key: "id") {
            var tempArray = userDefault.array(forKey: "id") as! [Int]
            if tempArray.contains(id) {
                let removedArray = tempArray.filter(){$0 != id}
                userDefault.set(removedArray, forKey: "id")
                view?.prepareWishlistButton(with: "#1D1D1DFF")
            }
            else {
                tempArray.append(id)
                userDefault.set(tempArray, forKey: "id")
                view?.prepareWishlistButton(with: "#5DC534FF")
            }
        }
        else {
            let tempArray = [id]
            userDefault.set(tempArray, forKey: "id")
            view?.prepareWishlistButton(with: "#5DC534FF")
        }
    }
    
    func setTableViewData() -> (titles: [String], descriptions: [String]) {
        var titles = [String]()
        var descriptions = [String]()
        if let game = game {
            if game.released != "" {
                titles.append("Release Date:")
                descriptions.append(game.released)
            }
            var genresString = ""
            game.genres.forEach({
                if $0.name == game.genres.last?.name {
                    genresString.append($0.name)
                }
                else {
                    genresString.append($0.name + ",")
                }
            })
            if genresString != "" {
                titles.append("Genres:")
                descriptions.append(genresString)
            }
            if game.playtime != 0 {
                titles.append("Play Time:")
                descriptions.append(String(game.playtime))
            }
            
            if game.publishers != nil {
                var publisherString = ""
                game.publishers.forEach({
                    if $0.name == game.publishers.last?.name {
                        publisherString.append($0.name)
                    }
                })
                titles.append("Publishers:")
                descriptions.append(publisherString)
            }
            
            return (titles,descriptions)
        }
        
        return([""],[""])

    }
    
    func viewDidLoad() {
        view?.configureViewHiearchy()
        view?.prepareTableView()
        view?.prepareNavBar()
        fetchGameDetail()
    }
}

extension GameDetailPresenter: GameDetailInteractorOutput {
    func handleGameResult(_ result: GameDetailModel?) {
        game = result
        if let result = result {
            view?.showGameDetail(with: result)
        }
        
    }
    
    
}
