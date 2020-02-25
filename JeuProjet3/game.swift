//
//  game.swift
//  JeuProjet3
//
//  Created by Djiva Canessane on 25/02/2020.
//  Copyright © 2020 Djiva Canessane. All rights reserved.
//

import Foundation

class Game {
    
    var players: [Player] = [
        Player(name: nil, warriors: []),
        Player(name: nil, warriors: [])
    ]
    
    func startGame() {
        print("Hello, welcome into the Game!")
        
        askPlayerName(index: 0)
        askPlayerName(index: 1)
        
        
    }

    func askPlayerName(index: Int)  {
        print("Please enter a name for player \(index + 1)")
        guard let playerName = readLine() else { return askPlayerName(index: index) }
        guard playerName != "" else { return askPlayerName(index: index) }
        players[index].name = playerName
    }
    
    
}
