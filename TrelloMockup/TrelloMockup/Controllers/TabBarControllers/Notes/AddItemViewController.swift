//
//  AddNoteViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

protocol AddItemDelegate {
    func didAddItem(_: UINote)
}

class AddItemViewController: UIViewController{
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
    
    private var titleImg: UIImageView!

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
        
        titleImg = UIImageView(image: UIImage(named: "note"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navHeight = navigationController?.navigationBar.frame.size.height ?? 70
        titleImg.frame = CGRect(x: 0, y: 0, width: navHeight*0.8, height: navHeight*0.8)
        titleImg.center = CGPoint(x: view.bounds.midX, y: navHeight/2)
        titleImg.layer.cornerRadius = titleImg.bounds.maxX/4
        titleImg.layer.masksToBounds = true
        
        titleImg.isUserInteractionEnabled = true
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(handleImgEdition))
        titleImg.addGestureRecognizer(tapGest)
        
        navigationController?.navigationBar.addSubview(titleImg)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        titleImg.removeFromSuperview()
    }
    
    @objc private func handleSave() {
        self.delegate?.didAddItem(UINote(name: textView.text, img: titleImg.image))
        textView.text = "Сохранено"
        textView.textColor = .lightGray
        navigationController?.popViewController(animated: true)        
    }
    
    @objc private func handleImgEdition() {
        print("want to change Img")
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.allowsEditing = false
        self.present(picker, animated: true, completion: nil)
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

extension AddItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            
            let selectedImage : UIImage = image // вот картинка
            titleImg.image = selectedImage
            dismiss(animated: true)
        }
    }
}

