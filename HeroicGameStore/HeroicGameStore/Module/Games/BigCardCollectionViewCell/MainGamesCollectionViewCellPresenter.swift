//
//  MainGamesCollectionViewCellPresenter.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 1.06.2021.
//

import Foundation

protocol MainGamesCollectionViewCellPresenterInterface {
    func load()
    func wishListButtonTapped()
    func calculateCellSize(_ index: Int) ->Int
    var numberOfItems : Int {get}
    var platformsCount: Int {get}
    func platformForIndex(_ index: Int) -> Platform?
    var numberOfCell: Int {get}
}

final class MainGamesCollectionViewCellPresenter {
    weak var view: MainGamesCollectionViewCellInterface?
    private let game: HeroicResult
    let userDefault = UserDefaults.standard
    
    init(view: MainGamesCollectionViewCellInterface?,game: HeroicResult){
        self.view = view
        self.game = game
    }
    
    private func setNameLabel(){
        let name = game.name
        view?.prepareNameLabel(with: name)
    }
    private func setImage() {
        let imageURL = game.background_image
        view?.prepareGameImage(with: imageURL)
    }
    private func setMetaCriticLabel(){
         let metacritic = game.metacritic
        view?.prepareMetacriticLabel(with: String(metacritic ?? 0))
    }
    private func setNameLabelColor() {
        if UserDefaults.exists(key: "name") {
            let tempArray = userDefault.array(forKey: "name") as! [String]
            if tempArray.contains(game.name) {
                view?.prepareNameColor(with: "#777777FF")
            }else {
                view?.prepareNameColor(with: "#FFFFFFFF")
            }
        }
        else {
            view?.prepareNameColor(with: "#FFFFFFFF")
        }
    }
    
    private func setWishlistBackgroundView() {
        if UserDefaults.exists(key:"id") {
            let tempArray = userDefault.array(forKey: "id") as! [Int]
            if tempArray.contains(game.id) {
                view?.prepareWishlistBackgroundView(with: "#5DC534FF")
            }
            else {
                view?.prepareWishlistBackgroundView(with: "#1D1D1DFF")
            }
        }
        else {
            view?.prepareWishlistBackgroundView(with: "#1D1D1DFF")
        }
    }
    private func setMetacriticColor(){
        switch game.metacritic ?? 0 {
        case 75...100:
            view?.prepareMetacriticColor(with: "#5DC534FF")
        case 50...74:
            view?.prepareMetacriticColor(with: "#FDC236FF")
        default:
            view?.prepareMetacriticColor(with: "#FE0500FF")
        }
    }
    
    private func setTableViewData() {
        var informationTitles = [String]()
        var informationDescription = [String]()
        
        if let released = game.released {
            informationTitles.append("Released Date:")
            informationDescription.append(released)
        }
          
        var genresString = ""
        if let genres = game.genres {
            for genre in genres {
                if genre.name == genres.last!.name {
                    genresString.append(genre.name)
                }else {
                    genresString.append(genre.name + ",")
                }
            }
        }
        if genresString != "" {
            informationTitles.append("Genres:")
            informationDescription.append(genresString)
        }
        if game.playtime != 0 {
            informationTitles.append("Play Time:")
            informationDescription.append(String(game.playtime))
        }
        view?.prepareTableView(titles: informationTitles, descriptions: informationDescription)
    }
}

extension MainGamesCollectionViewCellPresenter: MainGamesCollectionViewCellPresenterInterface {
    var numberOfCell: Int {
        if numberOfItems > 3 {
            return 4
        }else{
            return numberOfItems
        }
    }
    
    func platformForIndex(_ index: Int) -> Platform? {
        game.parent_platforms?[index].platform ?? Platform(name: "")
    }
    
    var platformsCount: Int {
        return game.parent_platforms?.count ?? 0
    }
    
    var numberOfItems: Int {
        game.parent_platforms?.count ?? 0
    }
    
    func calculateCellSize(_ index: Int) -> Int {
        if index == 3 {
            return (30)
        }
        if var textCount = game.parent_platforms?[index].platform.name.count {
            switch textCount {
            case 10...20:
                textCount = 7
                return (10 * textCount)
            case 2:
                return ( 15 * textCount)
            default:
                return (11 * textCount)
            }
        }
        return 0
    }
    
    func load() {
        view?.prepareCell()
        setNameLabel()
        setImage()
        setMetaCriticLabel()
        setWishlistBackgroundView()
        setTableViewData()
        setNameLabelColor()
        setMetacriticColor()
        view?.reloadTableView()
        view?.reloadCollectionView()
        
    }
    
    func wishListButtonTapped() {
        if UserDefaults.exists(key: "id") {
            var tempArray = userDefault.array(forKey: "id") as! [Int]
            if tempArray.contains(game.id) {
                let removedArray = tempArray.filter(){$0 != game.id}
                userDefault.set(removedArray, forKey: "id")
                view?.prepareWishlistBackgroundView(with: "#1D1D1DFF")
            }
            else {
                tempArray.append(game.id)
                userDefault.set(tempArray, forKey: "id")
                view?.prepareWishlistBackgroundView(with: "#5DC534FF")
            }
        }
        else {
            let tempArray = [game.id]
            userDefault.set(tempArray, forKey: "id")
            view?.prepareWishlistBackgroundView(with: "#5DC534FF")
        }
    }
}
