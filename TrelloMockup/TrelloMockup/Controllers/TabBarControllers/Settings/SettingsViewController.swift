//
//  SettingsViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let signOutButton = UIButton(title: "Sign out", fontSize: 30, cornerRadius: 24)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(signOutButton)
        signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        signOutButton.widthAnchor.constraint(equalToConstant: view.frame.width / 1.5).isActive = true
        signOutButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        signOutButton.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
    }
    
    @objc private func handleSignOut() {
        AppDelegate.defaults.removeObject(forKey: "token")
        AppDelegate.shared.rootViewController.switchToLogout()
        tabBarController?.tabBar.isHidden = true
    }

}

