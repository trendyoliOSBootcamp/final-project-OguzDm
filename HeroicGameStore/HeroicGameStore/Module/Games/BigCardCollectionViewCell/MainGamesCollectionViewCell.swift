//
//  MainGamesCollectionViewCell.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 24.05.2021.
//

import UIKit
import Kingfisher

protocol MainGamesCollectionViewCellInterface: AnyObject {
    func prepareCell()
    func prepareNameLabel(with text: String)
    func prepareNameColor(with color: String)
    func prepareGameImage(with url: String)
    func prepareMetacriticLabel(with text: String)
    func prepareWishlistBackgroundView(with color: String)
    func prepareMetacriticColor(with color: String)
    func reloadCollectionView()
    func reloadTableView()
    func prepareTableView(titles: [String], descriptions: [String])
}
class MainGamesCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfCell
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlatformsCollectionViewCell.reuseIdentifier, for: indexPath) as! PlatformsCollectionViewCell
        if indexPath.item == 3 {
            cell.presenter = PlatformsCollectionViewCellPresenter(view: cell, platform: Platform(name: "+\(presenter.numberOfItems - 3)"))
            return cell
        }else {
            cell.presenter = PlatformsCollectionViewCellPresenter(view: cell, platform: presenter.platformForIndex(indexPath.item)!)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        informationTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.reuseIdentifier, for: indexPath) as! InformationTableViewCell
        cell.configure(title: informationTitles[indexPath.row], description: informationDescriptions[indexPath.item])
        return cell
    }
    static let reuseIdentifier = "MainGamesCollectionViewCell"
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var metaCriticLabel: UILabel!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var wishListBackground: UIView!
    @IBOutlet weak var metaCriticBackgroundView: UIView!
    @IBOutlet weak var informationTableView: UITableView!
    @IBOutlet weak var platformsCollectionView: UICollectionView!
    var presenter: MainGamesCollectionViewCellPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
    var informationTitles = [String]()
    var informationDescriptions = [String]()
    override func awakeFromNib() {
        print(#function)
    }
    @objc func wishListButtonTapped() {
        presenter.wishListButtonTapped()
    }
}
extension MainGamesCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = presenter.calculateCellSize(indexPath.item)
        return CGSize(width: size, height: 18)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension MainGamesCollectionViewCell: MainGamesCollectionViewCellInterface {
    func prepareMetacriticColor(with color: String) {
        metaCriticBackgroundView.layer.borderColor = UIColor(hex: color)?.cgColor
        metaCriticLabel.textColor = UIColor(hex: color)
    }
    
    func prepareNameColor(with color: String) {
        self.gameNameLabel.textColor = UIColor(hex: color)
    }
    
    func prepareTableView(titles: [String], descriptions: [String]) {
        self.informationTitles = titles
        self.informationDescriptions = descriptions
    }
    
    func reloadCollectionView() {
        self.platformsCollectionView.reloadData()
    }
    
    func reloadTableView() {
        self.informationTableView.reloadData()
    }
    
    func prepareWishlistBackgroundView(with color: String) {
        self.wishListBackground.backgroundColor = UIColor(hex: color)
    }
    
    func prepareMetacriticLabel(with text: String) {
        self.metaCriticLabel.text = text
    }
    
    func prepareGameImage(with url: String) {
        self.gameImageView.kf.setImage(with: URL(string: url))
    }
    
    func prepareNameLabel(with text: String) {
        gameNameLabel.text = text
    }
    
    func prepareCell() {
        platformsCollectionView.delegate = self
        platformsCollectionView.dataSource = self
        platformsCollectionView.register(UINib.loadNib(name: PlatformsCollectionViewCell.reuseIdentifier), forCellWithReuseIdentifier: PlatformsCollectionViewCell.reuseIdentifier)
        platformsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        platformsCollectionView.isUserInteractionEnabled = false
        informationTableView.delegate = self
        informationTableView.dataSource = self
        informationTableView.register(UINib.loadNib(name: InformationTableViewCell.reuseIdentifier), forCellReuseIdentifier: InformationTableViewCell.reuseIdentifier)
        informationTableView.layer.cornerRadius = 8
        informationTableView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        informationTableView.isUserInteractionEnabled = false
        informationTableView.tableFooterView = UIView()
        wishListBackground.isUserInteractionEnabled = true
        let gestureRecog = UITapGestureRecognizer(target: self, action: #selector(wishListButtonTapped))
        wishListBackground.addGestureRecognizer(gestureRecog)
        gameImageView.contentMode = .scaleAspectFill
        bottomView.layer.cornerRadius = 8
        bottomView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        gameImageView.layer.cornerRadius = 8
        gameImageView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        wishListBackground.layer.cornerRadius = 6
        metaCriticBackgroundView.layer.cornerRadius = 4
        metaCriticBackgroundView.layer.borderWidth = 0.5
        metaCriticBackgroundView.layer.borderColor = UIColor.green.cgColor
        metaCriticBackgroundView.backgroundColor = .clear
    }
}

