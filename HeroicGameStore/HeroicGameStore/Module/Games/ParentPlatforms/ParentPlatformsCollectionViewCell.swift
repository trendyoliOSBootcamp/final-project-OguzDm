//
//  ParentPlatformsCollectionViewCell.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 2.06.2021.
//

import UIKit

protocol ParentPlatformsCollectionViewCellInterface: AnyObject {
    func prepareCell()
    func prepareTextLabel(with text: String)
}

class ParentPlatformsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var platformsTextLabel: UILabel!
    @IBOutlet weak var platformsBackgroundView: UIView!
        var presenter: ParentPlatformsPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
    static let reuseIdentifier = "ParentPlatformsCollectionViewCell"
    
}

extension ParentPlatformsCollectionViewCell: ParentPlatformsCollectionViewCellInterface {
    func prepareCell() {
        platformsBackgroundView.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.1764705882, blue: 0.1764705882, alpha: 1)
        platformsTextLabel.textColor = .white
        platformsBackgroundView.layer.cornerRadius = 4
    }
    func prepareTextLabel(with text: String) {
        platformsTextLabel.text = text
    }
    
    
}
