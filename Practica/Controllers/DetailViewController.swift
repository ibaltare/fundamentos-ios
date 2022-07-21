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
    private var callTransform: Bool = false
    private var transformations: [Transformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Descripción"
        scrollView.delegate = self
        
        guard let hero = hero else {
            return
        }
        
        self.imageView.setImage(url: hero.photo)
        self.nameLabel.text = hero.name
        self.descriptionTextView.text = hero.description
        if callTransform {
            getTransformations(id: hero.id)
        }

        showAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.contentImageView.layer.cornerRadius = 15
        self.contentImageView.clipsToBounds = true
        self.contentImageView.dropShadow(color: UIColor.black,opacity: 0.5, offSet: CGSize(width: 0, height: 0),radius: 15)
        self.imageView.layer.cornerRadius = 15
        self.transformButtom.round()
        self.transformButtom.isHidden = true
        
        if !self.transformations.isEmpty && self.transformButtom.isHidden{
            self.transformButtom.isHidden = false
        }
        
    }
    
    func showAnimation() {
        self.contentImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.descriptionTextView.transform = CGAffineTransform(scaleX: 10, y: 10)
        self.nameLabel.transform = CGAffineTransform(scaleX: 10, y: 10)
        self.descriptionTextView.alpha = 0
        self.nameLabel.alpha = 0
        
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.75,
            initialSpringVelocity: 0,
            options: []) {
                self.contentImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            } completion: { _ in
                UIView.animate(
                    withDuration: 0.75,
                    delay: 0,
                    usingSpringWithDamping: 0.75,
                    initialSpringVelocity: 0,
                    options: []) {
                        self.nameLabel.transform = .identity
                        self.descriptionTextView.transform = .identity
                        self.descriptionTextView.alpha = 1
                        self.nameLabel.alpha = 1
                    } completion: { _ in }
            }
    }

    func set(model: Hero, callTransform: Bool){
        hero = model
        self.callTransform = callTransform
    }
    
    @IBAction func showTransformation(_ sender: Any) {
        let layout = getLayout()
        let nextVC = TransformCollectionViewController(collectionViewLayout: layout)
        nextVC.set(model: self.transformations)
        
        self.navigationController?.pushViewController(nextVC, animated: true)
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
                    self.transformButtom.transform = CGAffineTransform(scaleX: 0, y: 0)
                    self.transformButtom.isHidden = false
                    UIView.animate(withDuration: 0.5, delay: 1.5) {
                        self.transformButtom.transform = .identity
                    }
                    
                }
            }
        }
    }
    
    func getLayout() -> UICollectionViewFlowLayout {
        //Define Layout here
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

            //Get device width
            let width = UIScreen.main.bounds.width

            //set section inset as per your requirement.
            //layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)

            //set cell item size here
            layout.itemSize = CGSize(width: width / 2, height: 245)

            //set Minimum spacing between 2 items
            layout.minimumInteritemSpacing = 0

            //set minimum vertical line spacing here between two lines in collectionview
            layout.minimumLineSpacing = 0
        
        return layout
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let correctedOffset = scrollView.contentOffset.y + view.safeAreaInsets.top
        contentImageHeight.constant = 250.0 - correctedOffset
        self.contentImageView.dropShadow(color: UIColor.black,opacity: 0.7, offSet: CGSize(width: 0, height: 0),radius: 15)
    }
    
}
