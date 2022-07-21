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

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
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
