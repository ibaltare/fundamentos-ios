//
//  DetailViewController.swift
//  Practica
//
//  Created by Nicolas on 17/07/22.
//

import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var contentImageView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentImageHeight: NSLayoutConstraint!
    @IBOutlet weak var transformButtom: UIButton!
    
    private var hero: Hero?
    var transformations: [Transformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        
        guard let hero = hero else {
            return
        }
        
        self.imageView.setImage(url: hero.photo)
        self.nameLabel.text = hero.name
        self.descriptionTextView.text = hero.description
        getTransformations(id: hero.id)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.contentImageView.layer.cornerRadius = 15
        self.contentImageView.clipsToBounds = true
        //self.contentImageView.dropShadow(color: UIColor.black,opacity: 0.5, offSet: CGSize(width: 0, height: 0),radius: 15)
        self.imageView.layer.cornerRadius = 15
        self.transformButtom.round()
        self.transformButtom.isHidden = true
    }

    func setHero(model: Hero){
        hero = model
    }
    
    @IBAction func showTransformation(_ sender: Any) {
    }
    
    private func getTransformations(id: String) {
        
        let networkModel = NetworkModel.shared
        
        networkModel.getTransformations(id: id) { [weak self] transformations, error in
            guard let self = self else { return }
            
            if let msg = error {
                self.showAlert(title: "Error", message: msg)
                return
            }
            
            self.transformations = transformations
            
            DispatchQueue.main.async {
                if !self.transformations.isEmpty {
                    self.transformButtom.isHidden = false
                }
            }
        }
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let correctedOffset = scrollView.contentOffset.y + view.safeAreaInsets.top
        contentImageHeight.constant = 250.0 - correctedOffset
        self.contentImageView.dropShadow(color: UIColor.black,opacity: 0.7, offSet: CGSize(width: 0, height: 0),radius: 15)
    }
    
}
