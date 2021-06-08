//
//  PlatformsCollectionViewCell.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 25.05.2021.
//

import UIKit
protocol PlatformsCollectionViewCellInterface: AnyObject{
    func prepareCell()
    func prepareTextLabel(with text: String)
}

class PlatformsCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "PlatformsCollectionViewCell"
    @IBOutlet weak var platformBackgroundView: UIView!
    @IBOutlet weak var platformLabel: UILabel!
    var presenter: PlatformsCollectionViewCellPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension PlatformsCollectionViewCell: PlatformsCollectionViewCellInterface {
    func prepareTextLabel(with text: String) {
        platformLabel.text = text
    }
    
    func prepareCell() {
        platformBackgroundView.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.1764705882, blue: 0.1764705882, alpha: 1)
        platformBackgroundView.layer.cornerRadius = 4
    }
    
    
}
