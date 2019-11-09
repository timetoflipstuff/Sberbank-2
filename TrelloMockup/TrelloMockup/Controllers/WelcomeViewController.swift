//
//  WelcomeViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Добро\nпожаловать!"
        label.font = .boldSystemFont(ofSize: 44)
        return label
    }()
    
    let startButton = UIButton(title: "Начать", fontSize: 30, cornerRadius: 24)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        
        view.addSubview(welcomeLabel)
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        welcomeLabel.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        welcomeLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        view.addSubview(startButton)
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: view.frame.width / 1.5).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        startButton.addTarget(self, action: #selector(handleStart), for: .touchUpInside)
    }
    
    
    @objc private func handleStart() {
        if AppDelegate.defaults.bool(forKey: "loggedIn") {
            AppDelegate.shared.rootViewController.switchToMainScreen()
        } else {
            AppDelegate.shared.rootViewController.switchToLogout()
        }
    }

}
