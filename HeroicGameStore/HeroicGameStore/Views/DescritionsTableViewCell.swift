//
//  DescritionsTableViewCell.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 26.05.2021.
//

import UIKit

class DescritionsTableViewCell: UITableViewCell {

    static let reuseIdentifier = "DescritionsTableViewCell"

    @IBOutlet weak var descriptionTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }
    
    func configure(description: String) {
        self.descriptionTextLabel.text = description
    }
    
}
