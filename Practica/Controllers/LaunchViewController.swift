//
//  LaunchViewController.swift
//  Practica
//
//  Created by Nicolas on 20/07/22.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var sphereImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        animation2()
    }
    
    func animation2() {
        let sizeW = self.view.frame.size.width
        let sizeH = self.view.frame.size.height
        let sizeM = sizeH > sizeW ? sizeH : sizeW
        let size = (sizeM / self.sphereImage.bounds.height) * 1.3
        UIView.animate(withDuration: 1.5) {
            self.sphereImage.transform = CGAffineTransform(scaleX: size, y: size)
        } completion: { _ in
            let nextVC = InitViewController()
            self.navigationController?.setViewControllers([nextVC], animated: false)
        }
    }
    
    func animation() {
        UIView.animate(withDuration: 1.5) {
            let size = self.view.frame.size.width * 3
            let diffx = size - self.view.frame.size.width
            let diffy = self.view.frame.size.height - size
            
            self.sphereImage.frame = CGRect(
                x: -(diffx/2),
                y: diffy/2,
                width: size,
                height: size
            )
        } completion: { _ in
            let nextVC = InitViewController()
            self.navigationController?.setViewControllers([nextVC], animated: false)
        }
    }

}
