//
//  InitViewController.swift
//  Practica
//
//  Created by Nicolas on 11/07/22.
//

import UIKit

final class InitViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.text = LocalDataModel.getEmail() ?? ""
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        backgroundImage.addoverlay()
        loginButton.round()
        emailTextField.round()
        passwordTextField.round()
    }

    @IBAction func loginAction(_ sender: Any) {
        
        loginButton.bounce()
        loginButton.isEnabled = false
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
            
        guard !email.isEmpty, !password.isEmpty else {
            showAlert(title: "Missing fields", message: "please complete all fields to login")
            loginButton.isEnabled = true
          return
        }
        
        let model = NetworkModel.shared
        
        model.login(user: email, password: password) { [weak self] response in
            
            DispatchQueue.main.async {
                if let msg = response {
                    self?.showAlert(title: "Error", message: msg)
                    self?.loginButton.isEnabled = true
                    return
                }
                
                let nextVC = HeroTableViewController()
                self?.navigationController?.setViewControllers([nextVC], animated: true)
                
            }

        }
            
    }
    

}
