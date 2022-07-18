//
//  HeroTableViewCell.swift
//  Practica
//
//  Created by Nicolas on 15/07/22.
//

import UIKit

final class HeroTableViewCell: UITableViewCell {

    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backView.layer.cornerRadius = 15
        self.backView.clipsToBounds = true
        self.backView.dropShadow(color: UIColor.black,opacity: 0.3, offSet: CGSize(width: 0, height: 0),radius: 15)
        self.heroImage.layer.cornerRadius = (self.heroImage.bounds.height)/2
    }

    func set(model: Hero){
        self.heroName.text = model.name
        self.heroDescription.text = model.description
        self.heroImage.setImage(url: model.photo)
    }
    
}
