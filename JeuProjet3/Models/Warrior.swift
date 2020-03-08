//
//  Warrior.swift
//  JeuProjet3
//
//  Created by Djiva Canessane on 25/02/2020.
//  Copyright © 2020 Djiva Canessane. All rights reserved.
//

import Foundation

//Modèle d'un combattant avec ses méthodes
class Warrior{
    var name: String
    var weapon: Weapon
    var life: Int = 100
    var stamina: Int = 100
    
    init(name: String, weapon: Weapon) {
        self.name = name
        self.weapon = weapon
    }
    
    func heal() {
        let healPoints: Int = self.life > 70 ? 100 - self.life : 30
        self.life += healPoints
    }
    
    func meditate() {
        let staminaPoints: Int = self.stamina > 80 ? 100 - self.stamina : 20
        self.stamina += staminaPoints
    }
}
