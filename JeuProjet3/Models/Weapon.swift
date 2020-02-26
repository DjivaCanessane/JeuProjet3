//
//  Weapon.swift
//  JeuProjet3
//
//  Created by Djiva Canessane on 25/02/2020.
//  Copyright © 2020 Djiva Canessane. All rights reserved.
//

import Foundation

class Weapon {
    var damage: Int
    var consumedEnergy: Int
    
    init(type: WeaponType) {
        
        switch type {
        case .sword:
            self.damage = 35
            self.consumedEnergy = 40
        case .arc:
            self.damage = 20
            self.consumedEnergy = 25
        case .gun:
            self.damage = 10
            self.consumedEnergy = 5
        }
    }
    
}
