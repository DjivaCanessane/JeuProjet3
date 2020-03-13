//
//  Player.swift
//  JeuProjet3
//
//  Created by Djiva Canessane on 25/02/2020.
//  Copyright © 2020 Djiva Canessane. All rights reserved.
//

import Foundation

// Player model
class Player{
    var name: String
    var warriors: [Warrior] = []
    
    init(name: String) {
        self.name = name
    }
    
    func isDead() -> Bool {
        let w1IsDead: Bool = warriors[0].life == 0
        let w2IsDead: Bool = warriors[1].life == 0
        let w3IsDead: Bool = warriors[2].life == 0
        
        return w1IsDead && w2IsDead && w3IsDead
    }
}
