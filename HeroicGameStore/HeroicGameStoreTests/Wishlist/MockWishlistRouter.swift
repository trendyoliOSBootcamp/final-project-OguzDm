//
//  MockWishlistRouter.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 4.06.2021.
//

import Foundation
@testable import HeroicGameStore

final class MockWishlistRouter: WishListRouterInterface {

    var invokedNavigateToVC = false
    var invokedNavigateToVCCount = 0
    var invokedNavigateToVCParameters: (id: Int, Void)?
    var invokedNavigateToVCParametersList = [(id: Int, Void)]()

    func navigateToVC(with id: Int) {
        invokedNavigateToVC = true
        invokedNavigateToVCCount += 1
        invokedNavigateToVCParameters = (id, ())
        invokedNavigateToVCParametersList.append((id, ()))
    }
}
