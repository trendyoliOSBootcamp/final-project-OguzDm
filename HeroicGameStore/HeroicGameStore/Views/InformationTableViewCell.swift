//
//  InformationTableViewCell.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 26.05.2021.
//

import UIKit

class InformationTableViewCell: UITableViewCell {

    static let reuseIdentifier = "InformationTableViewCell"
    @IBOutlet weak var informationTitleLabel: UILabel!
    @IBOutlet weak var informationDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(title: String, description: String) {
        informationTitleLabel.text = title
        informationDescriptionLabel.text = description
    }
    
}
