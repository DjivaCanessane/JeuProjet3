//
//  game.swift
//  JeuProjet3
//
//  Created by Djiva Canessane on 25/02/2020.
//  Copyright © 2020 Djiva Canessane. All rights reserved.
//

import Foundation

class Game {
    
    var playerOneName: String = ""

    func startGame() {
        print("Hello, welcome into the Game!")
        askPlayerName()   
    }

    func askPlayerName()  {
        print("Please enter a name")
        guard let playerOneNameBis = readLine() else {
            return askPlayerName()
        }
        playerOneName = playerOneNameBis
    }
}
