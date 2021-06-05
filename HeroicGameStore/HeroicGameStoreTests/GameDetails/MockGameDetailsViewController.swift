//
//  MockGameDetailsViewController.swift
//  HeroicGameStoreTests
//
//  Created by Oguz Demırhan on 5.06.2021.
//

import Foundation
@testable import HeroicGameStore

final class MockGameDetailsViewController: GameDetailViewInterface {

    var invokedShowGameDetail = false
    var invokedShowGameDetailCount = 0
    var invokedShowGameDetailParameters: (model: GameDetailModel, Void)?
    var invokedShowGameDetailParametersList = [(model: GameDetailModel, Void)]()

    func showGameDetail(with model: GameDetailModel) {
        invokedShowGameDetail = true
        invokedShowGameDetailCount += 1
        invokedShowGameDetailParameters = (model, ())
        invokedShowGameDetailParametersList.append((model, ()))
    }

    var invokedPrepareNavBar = false
    var invokedPrepareNavBarCount = 0

    func prepareNavBar() {
        invokedPrepareNavBar = true
        invokedPrepareNavBarCount += 1
    }

    var invokedPrepareTableView = false
    var invokedPrepareTableViewCount = 0

    func prepareTableView() {
        invokedPrepareTableView = true
        invokedPrepareTableViewCount += 1
    }

    var invokedConfigureViewHiearchy = false
    var invokedConfigureViewHiearchyCount = 0

    func configureViewHiearchy() {
        invokedConfigureViewHiearchy = true
        invokedConfigureViewHiearchyCount += 1
    }

    var invokedPrepareGameImageView = false
    var invokedPrepareGameImageViewCount = 0
    var invokedPrepareGameImageViewParameters: (url: String, Void)?
    var invokedPrepareGameImageViewParametersList = [(url: String, Void)]()

    func prepareGameImageView(with url: String) {
        invokedPrepareGameImageView = true
        invokedPrepareGameImageViewCount += 1
        invokedPrepareGameImageViewParameters = (url, ())
        invokedPrepareGameImageViewParametersList.append((url, ()))
    }

    var invokedPrepareMetacriticColor = false
    var invokedPrepareMetacriticColorCount = 0
    var invokedPrepareMetacriticColorParameters: (color: String, Void)?
    var invokedPrepareMetacriticColorParametersList = [(color: String, Void)]()

    func prepareMetacriticColor(with color: String) {
        invokedPrepareMetacriticColor = true
        invokedPrepareMetacriticColorCount += 1
        invokedPrepareMetacriticColorParameters = (color, ())
        invokedPrepareMetacriticColorParametersList.append((color, ()))
    }

    var invokedPrepareMetacriticText = false
    var invokedPrepareMetacriticTextCount = 0
    var invokedPrepareMetacriticTextParameters: (text: String, Void)?
    var invokedPrepareMetacriticTextParametersList = [(text: String, Void)]()

    func prepareMetacriticText(with text: String) {
        invokedPrepareMetacriticText = true
        invokedPrepareMetacriticTextCount += 1
        invokedPrepareMetacriticTextParameters = (text, ())
        invokedPrepareMetacriticTextParametersList.append((text, ()))
    }

    var invokedPrepareNameLabel = false
    var invokedPrepareNameLabelCount = 0
    var invokedPrepareNameLabelParameters: (text: String, Void)?
    var invokedPrepareNameLabelParametersList = [(text: String, Void)]()

    func prepareNameLabel(with text: String) {
        invokedPrepareNameLabel = true
        invokedPrepareNameLabelCount += 1
        invokedPrepareNameLabelParameters = (text, ())
        invokedPrepareNameLabelParametersList.append((text, ()))
    }

    var invokedPrepareWishlistButton = false
    var invokedPrepareWishlistButtonCount = 0
    var invokedPrepareWishlistButtonParameters: (color: String, Void)?
    var invokedPrepareWishlistButtonParametersList = [(color: String, Void)]()

    func prepareWishlistButton(with color: String) {
        invokedPrepareWishlistButton = true
        invokedPrepareWishlistButtonCount += 1
        invokedPrepareWishlistButtonParameters = (color, ())
        invokedPrepareWishlistButtonParametersList.append((color, ()))
    }

    var invokedPrepareDescriptionText = false
    var invokedPrepareDescriptionTextCount = 0
    var invokedPrepareDescriptionTextParameters: (text: String, Void)?
    var invokedPrepareDescriptionTextParametersList = [(text: String, Void)]()

    func prepareDescriptionText(with text: String) {
        invokedPrepareDescriptionText = true
        invokedPrepareDescriptionTextCount += 1
        invokedPrepareDescriptionTextParameters = (text, ())
        invokedPrepareDescriptionTextParametersList.append((text, ()))
    }

    var invokedPrepareInformations = false
    var invokedPrepareInformationsCount = 0
    var invokedPrepareInformationsParameters: (titles: [String], descriptions: [String])?
    var invokedPrepareInformationsParametersList = [(titles: [String], descriptions: [String])]()

    func prepareInformations(titles: [String], descriptions: [String]) {
        invokedPrepareInformations = true
        invokedPrepareInformationsCount += 1
        invokedPrepareInformationsParameters = (titles, descriptions)
        invokedPrepareInformationsParametersList.append((titles, descriptions))
    }

    var invokedPrepareWebView = false
    var invokedPrepareWebViewCount = 0

    func prepareWebView() {
        invokedPrepareWebView = true
        invokedPrepareWebViewCount += 1
    }

    var invokedReloadData = false
    var invokedReloadDataCount = 0

    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }
}
