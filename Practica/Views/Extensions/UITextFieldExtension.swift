//
//  UITextFieldExtension.swift
//  Practica
//
//  Created by Nicolas on 12/07/22.
//

import UIKit

extension UITextField {
    
    //round edge
    func round(){
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
}
