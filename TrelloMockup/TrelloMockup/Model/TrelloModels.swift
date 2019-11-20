//
//  TrelloModels.swift
//  TrelloMockup
//
//  Created by Alexander on 15.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import Foundation

struct Board: Decodable {
    var id: String
    var name: String
}

struct List: Decodable {
    var id: String
    var idBoard: String
    var name: String
    var cards: [Card]?
}

struct Card: Decodable {
    var name: String
    var idList: String
}
