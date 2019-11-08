//
//  SignInViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    let proceedRegistrationButton = UIButton(title: "Нажмите на кнопку", fontSize: 30, cornerRadius: 24)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Регистрация"
        view.addSubview(proceedRegistrationButton)
        proceedRegistrationButton.titleLabel?.numberOfLines = 0
        proceedRegistrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        proceedRegistrationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        proceedRegistrationButton.widthAnchor.constraint(equalToConstant: view.frame.width / 1.5).isActive = true
        proceedRegistrationButton.heightAnchor.constraint(equalToConstant: 128).isActive = true
        
        proceedRegistrationButton.addTarget(self, action: #selector(handleProceedRegistation), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc private func handleProceedRegistation() {
        AppDelegate.defaults.set(true, forKey: "loggedIn")
        navigationController?.setViewControllers([BaseTabBarController()], animated: true)
    }
    
}
