//
//  SmallCardCollectionViewCell.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 28.05.2021.
//

import UIKit

protocol SmallCardCollectionViewCellInterface : AnyObject{
    func prepareCell()
    func prepareNameLabel(with text: String)
    func prepareGameImage(with url: String)
    func prepareWishlistBackgroundView(with color: String)
    func prepareNameColor(with color: String)
}

class SmallCardCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "SmallCardCollectionViewCell"
    let userDefault = UserDefaults.standard
    @IBOutlet weak var smallCardImageView: UIImageView!
    @IBOutlet weak var wishListBackgroundView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var gameNameLabel: UILabel!
    
    var presenter : SmallCardCollectionViewCellPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @objc func wishListButtonTapped(){
        presenter.wishListButtonTapped()
    }
}

extension SmallCardCollectionViewCell: SmallCardCollectionViewCellInterface {
    func prepareNameColor(with color: String) {
        gameNameLabel.textColor = UIColor(hex: color)
    }
    
    func prepareWishlistBackgroundView(with color: String) {
        wishListBackgroundView.backgroundColor = UIColor(hex: color)
    }
    
    func prepareNameLabel(with text: String) {
        gameNameLabel.text = text
    }
    
    func prepareGameImage(with url: String) {
        smallCardImageView.kf.setImage(with: URL(string: url))
    }
    
    func prepareCell() {
        let gestureRecog = UITapGestureRecognizer(target: self, action: #selector(wishListButtonTapped))
        bottomView.layer.cornerRadius = 8
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        smallCardImageView.layer.cornerRadius = 8
        smallCardImageView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        wishListBackgroundView.layer.cornerRadius = 4
        wishListBackgroundView.addGestureRecognizer(gestureRecog)
    }
}
