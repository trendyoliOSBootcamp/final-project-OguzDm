//
//  ParentPlatformsPresenter.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 2.06.2021.
//

import Foundation

protocol ParentPlatformsPresenterInterface {
    func load()
}

final class ParentPlatformsPresenter {
    weak var view: ParentPlatformsCollectionViewCellInterface?
    private let platform: PlatformResults
    init(view: ParentPlatformsCollectionViewCellInterface?, platform: PlatformResults) {
        self.view = view
        self.platform = platform
    }
    
    private func setTextLabel() {
        let text = platform.name
        view?.prepareTextLabel(with: text)
    }
}
extension ParentPlatformsPresenter: ParentPlatformsPresenterInterface {
    
    
    func load() {
        view?.prepareCell()
        setTextLabel()
    }
}
