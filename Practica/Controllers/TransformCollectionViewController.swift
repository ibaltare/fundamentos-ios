//
//  TransformCollectionViewController.swift
//  Practica
//
//  Created by Nicolas on 18/07/22.
//

import UIKit

private let reuseIdentifier = "Cell"

final class TransformCollectionViewController: UICollectionViewController {
    
    private var transformations: [Transformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.register(UINib(nibName: "TFCollectionViewCell", bundle: nil),
                                      forCellWithReuseIdentifier: reuseIdentifier)
        
        title = "Transformaciones"
        
    }
    
    func set(model: [Transformation]){
        transformations = model
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return transformations.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        (cell as? TFCollectionViewCell)?.set(model: transformations[indexPath.row])
        return cell
    }

    // MARK: Select Cell
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = DetailViewController()
        let heroTransform = Hero(
            id: transformations[indexPath.row].id,
            name: transformations[indexPath.row].name,
            description: transformations[indexPath.row].description,
            photo: transformations[indexPath.row].photo,
            favorite: nil
        )
        nextVC.set(model: heroTransform, callTransform: false)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: call Animation
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.transform = CGAffineTransform(scaleX: 1, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
}
