//
//  ViewController.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 23.05.2021.
//

import UIKit
protocol GamesViewInterface: AnyObject{
    func prepareCollectionViews()
    func reloadGames()
    func reloadPlatforms()
    func setTitle(_ title: String)
    func prepareNavBar()
    func prepareSearchController()
    func prepareEmptyState()
    func removeFromSubViews()
}
class GamesViewController: UIViewController{
    var presenter : GamesPresenterInterface!
    var filteredGames = [HeroicResult]()
    var platforms = [PlatformResults]()
    var collectionView: UICollectionView!
    var platformsCollectionView: UICollectionView!
    let searchController = UISearchController()
    var isSmallCardGrid = false
    var heightConstraints: NSLayoutConstraint!
    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2282045484, green: 0.2282429636, blue: 0.2281961739, alpha: 1)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWilAppear()
        collectionView.scrollToItem(at: [0,0], at: .bottom, animated: true)
    }
    @objc func switchGrid() {
        DispatchQueue.main.async {
            self.isSmallCardGrid.toggle()
            self.collectionView.reloadData()
        }
    }
}
extension GamesViewController {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            if self.isSmallCardGrid {
                self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "bigLayoutButton")
                return self.createSmallCardLayout()
            }
            else {
                self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "smallLayoutButton")
                return self.createListLayout()
            }
        }
        return layout
    }
    private func createListLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0) , heightDimension: .fractionalWidth(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    private func createPlatformLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(36))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16)
        section.interGroupSpacing = 12
        
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    private func createSmallCardLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.625))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top:0, leading: 8, bottom: 0, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0) , heightDimension: .fractionalWidth(0.625))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item,count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        return section
    }
}
extension GamesViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter?.willDisplay(indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case platformsCollectionView:
            if presenter.isSearching {
                presenter.fetchWithSearch(query: presenter.currentSearchQuery + "&parent_platforms=\(indexPath.item+1)")
                presenter.isSearching = false
            }
            else {
            let selectedCell = platformsCollectionView.cellForItem(at: indexPath) as! ParentPlatformsCollectionViewCell
            if presenter.selectedIndex == indexPath.item{
//                selectedCell.platformsBackgroundView.backgroundColor = UIColor(displayP3Red: 45/256, green: 45/256, blue: 45/256, alpha: 1.0)
//                selectedCell.platformsTextLabel.textColor = .white
                presenter.fetchMainGames()
                
            }else {
//                selectedCell.platformsBackgroundView.backgroundColor = .white
//                selectedCell.platformsTextLabel.textColor = UIColor(displayP3Red: 45/256, green: 45/256, blue: 45/256, alpha: 1.0)
                presenter.fetchWithFilter(query: "&parent_platforms=\(indexPath.item + 1)")
            }
            presenter.selectedIndex = indexPath.item
            }
        default:
            presenter?.selectGame(at: indexPath.item)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard collectionView == platformsCollectionView else {return}
        if let indexPath = platformsCollectionView.indexPathsForSelectedItems?.first{
            let cellToDeselect =  platformsCollectionView.cellForItem(at: indexPath) as! ParentPlatformsCollectionViewCell
            cellToDeselect.platformsBackgroundView.backgroundColor = UIColor(displayP3Red: 45/256, green: 45/256, blue: 45/256, alpha: 1.0)
            cellToDeselect.platformsTextLabel.textColor = .white
        }
    }
}
extension GamesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case platformsCollectionView:
            return presenter?.numberOfPlatforms ?? 0
        default:
            return presenter?.numberOfGames ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case platformsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParentPlatformsCollectionViewCell.reuseIdentifier, for: indexPath) as! ParentPlatformsCollectionViewCell
            if let platform = presenter?.platformForIndex(indexPath.item) {
                    cell.presenter = ParentPlatformsPresenter(view: cell, platform: platform)
            }
            return cell
        default:
            if isSmallCardGrid {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallCardCollectionViewCell.reuseIdentifier, for: indexPath) as! SmallCardCollectionViewCell
                if let game = presenter?.gameForIndex(indexPath.item){
                    cell.presenter = SmallCardCollectionViewCellPresenter(view: cell, game: game, delegate: nil)
                }
                return cell
            }else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainGamesCollectionViewCell.reuseIdentifier, for: indexPath) as! MainGamesCollectionViewCell
                if let game = presenter?.gameForIndex(indexPath.item) {
                    cell.presenter = MainGamesCollectionViewCellPresenter(view: cell, game: game)
                }
                return cell
            }
        }
    }
}
extension GamesViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        presenter.isSearching = true
        presenter.currentSearchQuery = "&search=\(searchBar.text!)"
        presenter.fetchWithSearch(query: "&search=\(searchBar.text!)")
    }
}
extension GamesViewController: GamesViewInterface {
    func removeFromSubViews() {
        DispatchQueue.main.async {
            let subviews = self.view.subviews
            for view in subviews {
                if view is UILabel {
                   view.removeFromSuperview()
               }
            }
        }
    }
    func prepareEmptyState() {
        DispatchQueue.main.async {
            let emptyStateLabel = UILabel(frame: .zero)
            emptyStateLabel.text = "No game has been found."
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
    func prepareSearchController() {
        searchController.searchBar.delegate = self
    }
    func prepareNavBar() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
        let gridItem = UIBarButtonItem(image: #imageLiteral(resourceName: "smallLayoutButton"), style: .plain, target: self, action: #selector(switchGrid))
        gridItem.tintColor = .white
        navigationItem.rightBarButtonItem = gridItem
    }
    func setTitle(_ title: String) {
        navigationItem.title = title
    }
    func prepareCollectionViews() {
        platformsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createPlatformLayout())
        platformsCollectionView.delegate = self
        platformsCollectionView.dataSource = self
        platformsCollectionView.register(UINib.loadNib(
        name:ParentPlatformsCollectionViewCell.reuseIdentifier),
        forCellWithReuseIdentifier: ParentPlatformsCollectionViewCell.reuseIdentifier)
        platformsCollectionView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(platformsCollectionView)
        platformsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            platformsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            platformsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            platformsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        heightConstraints = platformsCollectionView.heightAnchor.constraint(equalToConstant: 68)
        heightConstraints.isActive = true
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.loadNib(name: MainGamesCollectionViewCell.reuseIdentifier), forCellWithReuseIdentifier: MainGamesCollectionViewCell.reuseIdentifier)
        collectionView.register(UINib.loadNib(name: SmallCardCollectionViewCell.reuseIdentifier), forCellWithReuseIdentifier: SmallCardCollectionViewCell.reuseIdentifier)
        collectionView.allowsMultipleSelection = false
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: platformsCollectionView.bottomAnchor)
        ])
    }
    func reloadGames() {
        collectionView.reloadData()
    }
    
    func reloadPlatforms() {
        platformsCollectionView.reloadData()
    }
}
extension GamesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if(offset > 68 && heightConstraints.constant == 68 ){
            heightConstraints.constant = 0
          }else{
                if offset < 0 {
                    heightConstraints.constant = 68
                }
                else {
                    heightConstraints.constant = 68 - offset
                }
          }
        print(heightConstraints.constant)
    }
}


