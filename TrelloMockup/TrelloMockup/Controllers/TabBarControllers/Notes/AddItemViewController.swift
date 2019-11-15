//
//  AddNoteViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

protocol AddItemDelegate {
    func didAddItem(name: String)
}

class AddItemViewController: UIViewController {
    
    let placeholder = "Введите текст"
    var delegate: AddItemDelegate?
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = placeholder
        textView.font = .systemFont(ofSize: 24)
        textView.textColor = .lightGray
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        view.backgroundColor = .white
        view.addSubview(textView)
        textView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSave))
    }
    
    @objc private func handleSave() {
        if textView.textColor != .black || textView.text == "" {
            let keyPath = "position.x"
            let multistep = CAKeyframeAnimation(keyPath: keyPath)
            multistep.values = [textView.center.x, textView.center.x - 10, textView.center.x + 10, textView.center.x - 10, textView.center.x + 10, textView.center.x]
            multistep.keyTimes = [0, 0.1, 0.2, 0.3, 0.4, 0.5]
            multistep.duration = 1
            textView.layer.add(multistep, forKey: "shake")
        } else {
            self.delegate?.didAddItem(name: textView.text)
            navigationController?.popViewController(animated: true)
        }
    }
    
}

extension AddItemViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
}
