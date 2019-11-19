//
//  Column.swift
//  TrelloMockup
//
//  Created by Alexander on 13.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import Foundation
struct Column {
    
    var name: String
    var tasks: [Task]
    
}

class Task {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
