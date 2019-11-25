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
        backgroundColor = .orange
    }
}

extension UIColor {
    static let lighterGray = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1)
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

extension Dictionary where Value: RangeReplaceableCollection {
    @discardableResult 
    public mutating func append(element: Value.Iterator.Element, toValueOfKey key: Key) -> Value? {
        var value: Value = self[key] ?? Value()
        value.append(element)
        self[key] = value
        return value
    }
}
