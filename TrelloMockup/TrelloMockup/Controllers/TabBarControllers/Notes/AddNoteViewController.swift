//
//  AddNoteViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

protocol AddNewNoteViewControllerDelegate {
    func didAddNote(name: String)
}

class AddNoteViewController: UIViewController {
    
    let placeholder = "Введите вашу заметку"
    var delegate: AddNewNoteViewControllerDelegate?
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSaveNote))
    }
    
    @objc private func handleSaveNote() {
        self.delegate!.didAddNote(name: textView.text)
        textView.text = "Заметка сохранена"
        textView.textColor = .lightGray
    }
    
}

extension AddNoteViewController: UITextViewDelegate {
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
