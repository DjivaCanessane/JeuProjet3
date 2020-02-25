//
//  Warrior.swift
//  JeuProjet3
//
//  Created by Djiva Canessane on 25/02/2020.
//  Copyright © 2020 Djiva Canessane. All rights reserved.
//

import Foundation

class Warrior{
    var name: String
    var id: String = UUID().uuidString
    var weapon: Weapon
    var life: Int = 100
    var stamina: Int = 100
    
    init(name: String, weapon: Weapon) {
        self.name = name
        self.weapon = weapon
    }
}
extension Warrior: Hashable, Equatable {
    static func == (lhs: Warrior, rhs: Warrior) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id.hashValue)
        
    }
}
