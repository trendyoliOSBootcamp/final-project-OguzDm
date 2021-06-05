//
//  SmallCardCollectionViewCellPresenter.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 2.06.2021.
//

import Foundation

protocol SmallCardCollectionViewCellPresenterInterface {
    func load()
    func wishListButtonTapped()
}

protocol SmallCardCollectionViewCellDelegate: AnyObject {
    func reload(id: Int)
}

final class SmallCardCollectionViewCellPresenter {
    weak var view: SmallCardCollectionViewCellInterface?
    weak var delegate: SmallCardCollectionViewCellDelegate?
    private let game: HeroicResult
    let userDefault = UserDefaults.standard
    
    init(view: SmallCardCollectionViewCellInterface?, game: HeroicResult,delegate: SmallCardCollectionViewCellDelegate?) {
        self.view = view
        self.game = game
        self.delegate = delegate
    }
    
    private func setImage() {
        let imageURL = game.background_image
        view?.prepareGameImage(with: imageURL)
    }
    private func setNameLabel(){
        let name = game.name
        view?.prepareNameLabel(with: name)
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
}

extension SmallCardCollectionViewCellPresenter: SmallCardCollectionViewCellPresenterInterface {
    
    func wishListButtonTapped() {
        if UserDefaults.exists(key: "id") {
            let tempArray = userDefault.array(forKey: "id") as! [Int]
            let removedArray = tempArray.filter(){$0 != game.id}
            userDefault.set(removedArray, forKey: "id")
            delegate?.reload(id: game.id)
            load()
        }
    }
    
    func load() {
        view?.prepareCell()
        setImage()
        setNameLabel()
        setWishlistBackgroundView()
        setNameLabelColor()
    }
}
