//
//  endGame.swift
//  JeuProjet3
//
//  Created by Djiva Canessane on 26/02/2020.
//  Copyright © 2020 Djiva Canessane. All rights reserved.
//

import Foundation

//Classe s'exécutant en dernier et montre les statistiques liées à la partie
class EndGame {
    
    //Méthode principale
    func endGame(players: [Player], looserPlayerIndex: Int, round: Int) {
        print("\n\n\n\n EndGame STATS")
        let looser: Player = players[looserPlayerIndex]
        let winner : Player = looserPlayerIndex == 0 ? players[1] : players[0]
        
        print("\nRounds: \(round)")
        
        //Afficher l'équipe gagnante
        print("\n\nWINNER: \(winner.name)")
        print("\n WINNER Team:"
            + "\n1. \(winner.warriors[0].name)  HP: \(winner.warriors[0].life)  Stm: \(winner.warriors[0].stamina)"
            + "\n2. \(winner.warriors[1].name)  HP: \(winner.warriors[1].life)  Stm: \(winner.warriors[1].stamina)"
            + "\n3. \(winner.warriors[2].name)  HP: \(winner.warriors[2].life)  Stm: \(winner.warriors[2].stamina)")
        
        //Afficher l'équipe perdante
        print("\n\nLOOSER: \(looser.name)")
        print("\n LOOSER Team:"
            + "\n1. \(looser.warriors[0].name)  HP: \(looser.warriors[0].life)  Stm: \(looser.warriors[0].stamina)"
            + "\n2. \(looser.warriors[1].name)  HP: \(looser.warriors[1].life)  Stm: \(looser.warriors[1].stamina)"
            + "\n3. \(looser.warriors[2].name)  HP: \(looser.warriors[2].life)  Stm: \(looser.warriors[2].stamina)")
    }
    
}
