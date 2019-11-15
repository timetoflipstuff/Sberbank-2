//
//  Extensions.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title: String, fontSize: CGFloat, cornerRadius: CGFloat) {
        self.init()
        setTitle(title, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: fontSize)
        layer.cornerRadius = cornerRadius
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
    }
}

extension String {
    
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
}
