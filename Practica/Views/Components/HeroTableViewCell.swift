//
//  HeroTableViewCell.swift
//  Practica
//
//  Created by Nicolas on 15/07/22.
//

import UIKit

class HeroTableViewCell: UITableViewCell {

    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backView.layer.cornerRadius = 15
        backView.clipsToBounds = true
        backView.dropShadow(color: UIColor.black,opacity: 0.3, offSet: CGSize(width: 0, height: 0),radius: 15)
        heroImage.layer.cornerRadius = (heroImage.bounds.height)/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
