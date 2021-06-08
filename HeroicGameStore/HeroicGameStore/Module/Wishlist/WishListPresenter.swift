//
//  WishListPresenter.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 1.06.2021.
//

import Foundation


protocol WishListPresenterInterface {
    func viewWillAppear()
    var numberOfGames: Int {get}
    func gameForIndex(_ index: Int) -> HeroicResult?
    func removeGame(with id: Int)
    func selectGame(at indexPath: Int)
    
}


final class WishListPresenter {
    let userDefault = UserDefaults.standard
    
    weak var view: WishListViewInterface?
    private let interactor: WishListInteractorInterface
    private let router: WishListRouterInterface
    private var games = [HeroicResult]()
    
    init(view: WishListViewInterface?,interactor: WishListInteractorInterface ,router: WishListRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    private func fetchGames(){
        if UserDefaults.exists(key:"id") {
            let tempArray = userDefault.array(forKey: "id") as! [Int]
            if tempArray.count == 0 {
                view?.prepareEmptyState()
            }
            tempArray.forEach { i in
                interactor.fetchGames(with: i)
            }
        }
        else {
            view?.prepareEmptyState()
        }
    }
    
}

extension WishListPresenter: WishListPresenterInterface {
    func selectGame(at indexPath: Int) {
        let game = games[indexPath]
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
        self.router.navigateToVC(with: game.id)
        
    }
    func removeGame(with id: Int) {
        let removedArray = games.filter{$0.id != id}
        games = removedArray
    }
    
    func gameForIndex(_ index: Int) -> HeroicResult? {
        games[safe: index]
    }
    
    var numberOfGames: Int {
        games.count
    }
    
    func viewWillAppear() {
        games.removeAll()
        view?.prepareTitle(with: "Wish List")
        view?.prepareNavBar()
        view?.prepareCollectionView()
        fetchGames()
    }
    
}
extension WishListPresenter: WishListInteractorOutput {
    func handleWishListResult(_ result: HeroicResult) {
        games.append(result)
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }
    
    
    
}
