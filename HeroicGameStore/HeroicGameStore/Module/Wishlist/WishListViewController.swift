//
//  WishListViewController.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 31.05.2021.
//

import UIKit

protocol WishListViewInterface : AnyObject{
    func prepareCollectionView()
    func prepareTitle(with text: String)
    func reloadData()
    func prepareNavBar()
    func prepareEmptyState()
}

class WishListViewController: UIViewController, SmallCardCollectionViewCellDelegate{
    func reload(id: Int) {
        presenter?.removeGame(with: id)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    var presenter : WishListPresenterInterface?
    var collectionView: UICollectionView!
    let userDefault = UserDefaults.standard
    var wishListedGames = [GameDetailModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
}
extension WishListViewController {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSmallCardLayout()
        }
        return layout
    }
    
    private func createSmallCardLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.625))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top:0, leading: 8, bottom: 0, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0) , heightDimension: .fractionalWidth(0.625))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item,count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 16
        return section
    }
}
extension WishListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.selectGame(at: indexPath.item)
    }
}
extension WishListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfGames ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallCardCollectionViewCell.reuseIdentifier, for: indexPath) as! SmallCardCollectionViewCell
        
        if let game = presenter?.gameForIndex(indexPath.item) {
            cell.presenter = SmallCardCollectionViewCellPresenter(view: cell, game: game, delegate: self)
        }
        return cell
    }
}

extension WishListViewController: WishListViewInterface {
    func prepareEmptyState() {
        DispatchQueue.main.async {
            let emptyStateLabel = UILabel(frame: .zero)
            emptyStateLabel.text = "No Wishlisted game has been found."
            emptyStateLabel.textColor = .white
            emptyStateLabel.font = .systemFont(ofSize: 20)
            emptyStateLabel.textAlignment = .center
            emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(emptyStateLabel)
            NSLayoutConstraint.activate([
                emptyStateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                emptyStateLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        }
    }
    func prepareNavBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2282045484, green: 0.2282429636, blue: 0.2281961739, alpha: 1)
    }
    
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    func prepareTitle(with text: String) {
        navigationItem.title = text
    }
    
    func prepareCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delaysContentTouches = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.loadNib(name: SmallCardCollectionViewCell.reuseIdentifier), forCellWithReuseIdentifier: SmallCardCollectionViewCell.reuseIdentifier)
        view.addSubview(collectionView)
    }
}

