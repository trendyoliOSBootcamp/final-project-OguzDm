//
//  PlatformsCollectionViewCellPresenter.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 1.06.2021.
//

import Foundation

protocol PlatformsCollectionViewCellPresenterInterface {
    func load()
}

final class PlatformsCollectionViewCellPresenter {
    weak var view: PlatformsCollectionViewCellInterface?
    private let platform: Platform
    
    init(view: PlatformsCollectionViewCellInterface?, platform: Platform) {
        self.view = view
        self.platform = platform
    }
    private func setTextLabel(){
        let text = platform.name
        view?.prepareTextLabel(with: text)
    }
}

extension PlatformsCollectionViewCellPresenter: PlatformsCollectionViewCellPresenterInterface {
    func load() {
        view?.prepareCell()
        setTextLabel()
    }
    
    
}
