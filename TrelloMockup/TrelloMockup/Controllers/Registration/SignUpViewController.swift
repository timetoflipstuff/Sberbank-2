//
//  SignUpViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Извините, данная функция сейчас недоступна.\n\nЗарегестрируйтесь через сайт."
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(messageLabel)
        messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        messageLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 44).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    
}
