//
//  UIViewExtension.swift
//  Practica
//
//  Created by Nicolas on 12/07/22.
//

import UIKit

extension UIView {
    //This function will add a layer on any 'UIView' to make that 'UIView' look darkened
    func addoverlay(color: UIColor = .black,alpha : CGFloat = 0.6) {
        let overlay = UIView()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.frame = bounds
        overlay.backgroundColor = color
        overlay.alpha = alpha
        addSubview(overlay)
    }
    
}
