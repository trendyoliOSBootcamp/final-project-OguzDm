//
//  GameDetailsViewController.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 26.05.2021.
//

import UIKit
import WebKit

protocol GameDetailViewInterface: AnyObject {
    func showGameDetail(with model: GameDetailModel)
    func prepareNavBar()
    func prepareTableView()
    func configureViewHiearchy()  // first
    func prepareGameImageView(with url: String)
    func prepareMetacriticColor(with color: String)
    func prepareMetacriticText(with text: String)
    func prepareNameLabel(with text: String)
    func prepareWishlistButton(with color: String)
    func prepareDescriptionText(with text: String)
    func prepareInformations(titles: [String], descriptions: [String])
    func prepareWebView()
    func reloadData()
}

final class GameDetailViewController: UIViewController {
    private let webView: WKWebView = {
        let defaultWebPref = WKWebpagePreferences()
        defaultWebPref.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = defaultWebPref
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()
    let userDefault = UserDefaults.standard
    let wishListButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    var presenter: GameDetailPresenterInterface?
    var gameImageView: UIImageView!
    var tableView: UITableView!
    var topView: UIView!
    var metacriticBackgroundView: UIView!
    var metacriticLabel = UILabel()
    let nameLabel = UILabel()
    var currentID: Int?
    var model: GameDetailModel?
    var descriptionText = ""
    var descriptionsForInfos = [String]()
    var informationType = [String]()
    var selectedRow = false
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
extension GameDetailViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if model?.reddit_url != "" {
            return 4
        }
        else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if model?.reddit_url != "" {
            if indexPath.section == 2 {
                view.addSubview(webView)
                webView.frame = view.bounds
                let url = model!.reddit_url
                guard let redditURL = URL(string: url) else {return}
                webView.load(URLRequest(url: redditURL))
            }
        }
        if indexPath.section == 0 {
            selectedRow.toggle()
            let cell = tableView.dequeueReusableCell(withIdentifier: DescritionsTableViewCell.reuseIdentifier, for: indexPath) as! DescritionsTableViewCell
            if selectedRow {
                cell.descriptionTextLabel.numberOfLines = 0
            }
            else{
                    cell.descriptionTextLabel.numberOfLines = 4
            }
            self.tableView.reloadData()
        }
    }
    
    @objc func wishListButtonAction() {
        presenter?.wishListButtonTapped()
    }
}
extension GameDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return informationType.count
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if model?.reddit_url != ""{                     //to-do make DRY
                switch indexPath.section {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: DescritionsTableViewCell.reuseIdentifier, for: indexPath) as! DescritionsTableViewCell
                    cell.configure(description: descriptionText)
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.reuseIdentifier, for: indexPath) as! InformationTableViewCell
                    cell.configure(title: informationType[indexPath.row], description: descriptionsForInfos[indexPath.row])
                    return cell
                case 2:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                    cell.textLabel?.text = "Visit reddit"
                    cell.textLabel?.textColor = .white
                    cell.backgroundColor = #colorLiteral(red: 0.1137086675, green: 0.1137354299, blue: 0.1137049273, alpha: 1)
                    cell.accessoryType = .disclosureIndicator
                    return cell
                case 3:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                    cell.textLabel?.text = "Visit website"
                    cell.textLabel?.textColor = .white
                    cell.backgroundColor = #colorLiteral(red: 0.1137086675, green: 0.1137354299, blue: 0.1137049273, alpha: 1)
                    cell.accessoryType = .disclosureIndicator
                    return cell
                default:
                    return UITableViewCell()
                }
            }
        else {
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: DescritionsTableViewCell.reuseIdentifier, for: indexPath) as! DescritionsTableViewCell
                cell.configure(description: descriptionText)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.reuseIdentifier, for: indexPath) as! InformationTableViewCell
                cell.configure(title: informationType[indexPath.row], description: descriptionsForInfos[indexPath.row])
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.text = "Visit website"
                cell.textLabel?.textColor = .white
                cell.backgroundColor = #colorLiteral(red: 0.1137086675, green: 0.1137354299, blue: 0.1137049273, alpha: 1)
                cell.accessoryType = .disclosureIndicator
                return cell
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if selectedRow {
                return CGFloat(Double(descriptionText.count) / 2.7)
            }
            return 113
        case 1:
            return 40
        default:
            return 40
        }
    }
}

extension GameDetailViewController: GameDetailViewInterface {

    func prepareMetacriticText(with text: String) {
        metacriticLabel.text = text
    }
    
    func prepareMetacriticColor(with color: String) {
        metacriticBackgroundView.layer.borderColor = UIColor(hex: color)?.cgColor
        metacriticLabel.textColor = UIColor(hex: color)
    }
    
    func prepareWishlistButton(with color: String) {
        self.wishListButton.tintColor = UIColor(hex: color)
    }
    
    func prepareNavBar() {
        wishListButton.setImage(#imageLiteral(resourceName: "gift"), for: .normal)
        wishListButton.addTarget(self, action: #selector(wishListButtonAction), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: wishListButton)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
    }
    
    func prepareWebView() {
        //to-do
    }
    func showGameDetail(with model: GameDetailModel) {
        DispatchQueue.main.async {
                if UserDefaults.exists(key:"id") {
                    let tempArray = self.userDefault.array(forKey: "id") as! [Int]
                    if tempArray.contains(model.id) {
                        self.wishListButton.tintColor = UIColor(hex: "#5DC534FF")
                    }
                    else {
                        self.wishListButton.tintColor = UIColor(hex: "#1D1D1DFF")
                    }
                }
                else {
                    self.wishListButton.tintColor = UIColor(hex: "#1D1D1DFF")
                }
            self.metacriticLabel.text = String(model.metacritic ?? 0)
            self.gameImageView.kf.setImage(with: URL(string: model.background_image))
            self.descriptionText = model.description_raw
            self.nameLabel.text = model.name
            let tableViewData = self.presenter?.setTableViewData()
            self.informationType = tableViewData!.titles
            self.descriptionsForInfos = tableViewData!.descriptions
            self.tableView.reloadData()
            self.model = model
            guard let metacritic = model.metacritic else {
                self.metacriticBackgroundView.layer.borderColor = UIColor(hex:"#FE0500FF" )?.cgColor
                self.metacriticLabel.textColor = UIColor(hex:"#FE0500FF" )
                return
            }
            switch metacritic {
            case 75...100 :
                self.metacriticBackgroundView.layer.borderColor = UIColor(hex:"#5DC534FF" )?.cgColor
                self.metacriticLabel.textColor = UIColor(hex:"#5DC534FF" )
            case 50...74:
                self.metacriticBackgroundView.layer.borderColor = UIColor(hex:"#FDC236FF" )?.cgColor
                self.metacriticLabel.textColor = UIColor(hex:"#FDC236FF" )
            default:
                self.metacriticBackgroundView.layer.borderColor = UIColor(hex:"#FE0500FF" )?.cgColor
                self.metacriticLabel.textColor = UIColor(hex:"#FE0500FF" )
            }
        }
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func prepareInformations(titles: [String], descriptions: [String]) {
        self.informationType = titles
        self.descriptionsForInfos = descriptions
    }
    
    func prepareGameImageView(with url: String) {
        self.gameImageView.kf.setImage(with: URL(string: url))
    }
    
    func prepareNameLabel(with text: String) {
        self.nameLabel.text = text
    }
    
    func prepareDescriptionText(with text: String) {
        self.descriptionText = text
    }
    
    func configureViewHiearchy() {
        gameImageView = UIImageView(frame:.zero)
        self.view.addSubview(gameImageView)
        topView = UIView(frame: .zero)
        topView.backgroundColor = #colorLiteral(red: 0.08233924955, green: 0.08236102015, blue: 0.08233617991, alpha: 1)
        self.view.addSubview(topView)
        tableView = UITableView(frame:.zero,style: .insetGrouped)
        self.view.addSubview(tableView)
        gameImageView.backgroundColor = #colorLiteral(red: 0.08233924955, green: 0.08236102015, blue: 0.08233617991, alpha: 1)
        gameImageView.contentMode = .scaleAspectFill
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gameImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            gameImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.53),
            gameImageView.bottomAnchor.constraint(equalTo: topView.topAnchor),
            gameImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        NSLayoutConstraint.activate([
            topView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topView.heightAnchor.constraint(equalToConstant: 50),
            topView.centerXAnchor.constraint(equalTo: gameImageView.centerXAnchor)
        ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor)
        ])
        nameLabel.text = ""
        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.textColor = UIColor.white
        nameLabel.backgroundColor = UIColor.clear
        nameLabel.textAlignment = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: topView.leftAnchor,constant: 20),
            nameLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor,constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor,constant: 16)
        ])
        metacriticBackgroundView = UIView(frame: .zero)
        metacriticBackgroundView.backgroundColor = .clear
        metacriticBackgroundView.layer.cornerRadius = 4
        metacriticBackgroundView.layer.cornerRadius = 4
        metacriticBackgroundView.layer.borderWidth = 0.5
        metacriticBackgroundView.layer.borderColor = UIColor.green.cgColor
        topView.addSubview(metacriticBackgroundView)
        metacriticBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            metacriticBackgroundView.rightAnchor.constraint(equalTo: topView.rightAnchor,constant: -20),
            metacriticBackgroundView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            metacriticBackgroundView.widthAnchor.constraint(equalToConstant: 25),
            metacriticBackgroundView.heightAnchor.constraint(equalToConstant: 18)
        ])
        metacriticLabel.text = "96"
        metacriticLabel.font = .systemFont(ofSize: 10)
        metacriticLabel.textColor = UIColor.green
        metacriticLabel.backgroundColor = UIColor.clear
        metacriticLabel.textAlignment = .center
        metacriticLabel.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(metacriticLabel)
        NSLayoutConstraint.activate([
            metacriticLabel.rightAnchor.constraint(equalTo: metacriticBackgroundView.rightAnchor,constant: -4),
            metacriticLabel.leftAnchor.constraint(equalTo: metacriticBackgroundView.leftAnchor,constant: 4),
            metacriticLabel.topAnchor.constraint(equalTo: metacriticBackgroundView.topAnchor, constant: 3),
            metacriticLabel.bottomAnchor.constraint(equalTo: metacriticBackgroundView.bottomAnchor,constant: -3)
        ])
    }
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UINib.loadNib(name: DescritionsTableViewCell.reuseIdentifier), forCellReuseIdentifier: DescritionsTableViewCell.reuseIdentifier)
        tableView.register(UINib.loadNib(name: InformationTableViewCell.reuseIdentifier), forCellReuseIdentifier: InformationTableViewCell.reuseIdentifier)
        tableView.backgroundColor = #colorLiteral(red: 0.08233924955, green: 0.08236102015, blue: 0.08233617991, alpha: 1)
    }
}

