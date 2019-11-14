//
//  AddColumnVC.swift
//  TrelloMockup
//
//  Created by Alex Mikhaylov on 12/11/2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

protocol AddColumnVCDelegate {
    func didAddColumn(name: String)
}

class AddColumnVC: UIViewController {
    
    let placeholder = "Введите название колонки"
    var delegate: AddColumnVCDelegate?
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleColumnAdd))
    }
    
    @objc private func handleColumnAdd() {
        self.delegate!.didAddColumn(name: textView.text)
        textView.text = "Колонка добавлена"
        textView.textColor = .lightGray
    }
    
}

extension AddColumnVC: UITextViewDelegate {
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
