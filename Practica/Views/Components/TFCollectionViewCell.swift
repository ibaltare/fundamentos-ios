//
//  TFCollectionViewCell.swift
//  Practica
//
//  Created by Nicolas on 18/07/22.
//

import UIKit

final class TFCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentImageView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    private var transformation: Transformation?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentImageView.layer.cornerRadius = 15
        self.contentImageView.clipsToBounds = true
        self.contentImageView.dropShadow(
            color: UIColor.black,
            opacity: 0.7,
            offSet: CGSize(width: 0, height: 0),
            radius: 15)
        self.imageView.roundCorners([.topLeft, .topRight], radius: 15)
    }
    
    func set(model: Transformation){
        transformation = model
        self.nameLabel.text = model.name
        self.imageView.setImage(url: model.photo)
    }

}
