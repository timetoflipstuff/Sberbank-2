//
//  NotesViewCellController.swift
//  TrelloMockup
//
//  Created by Alex Mikhaylov on 11/11/2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class NotesViewCellController: UIViewController {

    var innerText: String = ""
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = innerText
        textView.font = .systemFont(ofSize: 24)
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
}

