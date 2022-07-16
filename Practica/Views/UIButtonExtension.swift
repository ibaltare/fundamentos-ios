//
//  UIButtonExtension.swift
//  Practica
//
//  Created by Nicolas on 12/07/22.
//

import UIKit

extension UIButton {
    
    //round edge
    func round(){
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    
    func bounce(){
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = .identity
            })
        }
    }
    
}
