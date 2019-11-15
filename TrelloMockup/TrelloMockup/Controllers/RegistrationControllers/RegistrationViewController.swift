//
//  RegistrationViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let signInButton = UIButton(title: "Sign in", fontSize: 30, cornerRadius: 24)
    let signUpButton = UIButton(title: "Sign up", fontSize: 30, cornerRadius: 24)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        
        imageView.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        imageView.image = UIImage(named: "sberbank")
        
        signInButton.heightAnchor.constraint(equalToConstant: view.frame.height / 12).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant:  view.frame.width / 1.5).isActive = true
        
        signUpButton.heightAnchor.constraint(equalToConstant: view.frame.height / 12).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: view.frame.width / 1.5).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [imageView, signInButton, signUpButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 16
        view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        signInButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc private func handleSignIn() {
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    @objc private func handleSignUp() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }

}
