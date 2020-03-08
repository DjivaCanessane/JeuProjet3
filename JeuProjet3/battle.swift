//
//  battle.swift
//  JeuProjet3
//
//  Created by Djiva Canessane on 26/02/2020.
//  Copyright © 2020 Djiva Canessane. All rights reserved.
//

import Foundation

//Classe où se déroule le combat entre les 2 joueurs
class Battle {
    //round permet de connaitre le nombre de tours actuel et déterminer quel joueur doit jouer
    var round: Int = 0
    
    //Méthode principale
    func battle(players: [Player]) {
        print("\n\n\nLet the battle begin !")
        
        //Boucle exécuté tant que les deux joueurs ont au moins un combattant vivant
        while !isGameOver(players: players) {
            round += 1
            let playerIndex: Int = round % 2 != 0 ? 0 : 1
            let warrior: Warrior = chooseWarrior(player: players[playerIndex])
            surpriseChest(number: Int.random(in: 0...2), warrior: warrior)
            let action: Int = askAction(warrior: warrior)
            doAction(action: action, warrior: warrior, playerToAttack: playerIndex == 0 ? players[1] : players[0], players: players)
        }
        let looserPlayerIndex: Int = players[0].isDead() ? 0 : 1
        EndGame().endGame(players: players, looserPlayerIndex: looserPlayerIndex, round: round)
    }
    
    //Méthode pour vérifier si une des deux équipes est morte
    func isGameOver(players: [Player]) -> Bool {
        return players[0].isDead() || players[1].isDead()
    }
    
    //Méthode qui génère un coffre aléatoirement
    func surpriseChest(number: Int, warrior: Warrior) {
        guard number == 2 else { return }
        
    }
    
    //Méthode pour choir un combattant de son équipe
    func chooseWarrior(player: Player) -> Warrior {
        print("\(player.name), select a warrior, by entering a number, to attack, meditate or heal"
            + "\n1. \(player.warriors[0].name)  HP: \(player.warriors[0].life)  Stm: \(player.warriors[0].stamina)"
            + "\n2. \(player.warriors[1].name)  HP: \(player.warriors[1].life)  Stm: \(player.warriors[1].stamina)"
            + "\n3. \(player.warriors[2].name)  HP: \(player.warriors[2].life)  Stm: \(player.warriors[2].stamina)")
        guard let warrior = readLine() else {
            warning(text: "Warrior can't be nil !")
            return chooseWarrior(player: player) }
        guard let warriorIndex = Int(warrior) else {
            warning(text: "Select a warrior by entering a number !")
            return chooseWarrior(player: player) }
        guard 1...3 ~= warriorIndex else {
            warning(text: "Enter a number between 1 to 3 !")
            return chooseWarrior(player: player) }
        if (player.warriors[warriorIndex - 1].life == 0) {
            warning(text: "This warrior is dead, let him him rest in peace...")
            return chooseWarrior(player: player)
        }
        return player.warriors[warriorIndex - 1]
    }
    
    //Méthode pour proposer les actions possible par le combattant
    func askAction(warrior: Warrior) -> Int {
        print("Choose an action for \(warrior.name), by entering a number"
            + "\n1. Attack"
            + "\n2. Meditate"
            + "\n3. Heal")
        guard let action = readLine() else {
            warning(text: "Action can't be nil !")
            return askAction(warrior: warrior) }
        guard let actionIndex = Int(action) else {
            warning(text: "Select a warrior by entering a number !")
            return askAction(warrior: warrior) }
        guard 1...3 ~= actionIndex else {
            warning(text: "Enter a number between 1 to 3 !")
            return askAction(warrior: warrior) }
        return actionIndex
    }
    
    //Methode pour exécuter l'action préablement choisi
    func doAction(action: Int, warrior: Warrior, playerToAttack: Player, players: [Player]) {
        let reAction: Int
        switch action {
        //attaquer
        case 1:
            if (warrior.stamina < warrior.weapon.consumedEnergy) {
                //Si le combattant n'a pas suffisamment d'endurance pour attaquer nous l'invitons à re choisir une autre action
                warning(text: "Your warrior is too weak, let him meditate before attack !")
                reAction = askAction(warrior: warrior)
                doAction(action: reAction, warrior: warrior, playerToAttack: playerToAttack, players: players)
                return
            }
            
            attack(playerToAttack: playerToAttack, warrior: warrior)
        //Regénèrer l'endurance
        case 2:
            if (warrior.stamina == 100) {
                //Si le combattant a déjà toute son endurance nous l'invitons à re choisir une autre action
                warning(text: "Choose another action, because his stamina is full")
                reAction = askAction(warrior: warrior)
                doAction(action: reAction, warrior: warrior, playerToAttack: playerToAttack, players: players)
                return
            }
            let oldStamina: Int = warrior.stamina
            warrior.meditate()
            print("\(warrior.name)  Stm: \(oldStamina) -> \(warrior.stamina)")
        //Regénèrer les points de vie
        case 3:
            if (warrior.life == 100) {
                //Si le combattant a déjà la vie pleine nous l'invitons à re choisir une autre action
                warning(text: "Choose another action, because his HP is full")
                reAction = askAction(warrior: warrior)
                doAction(action: reAction, warrior: warrior, playerToAttack: playerToAttack, players: players)
                return
            }
            let oldLife: Int = warrior.life
            warrior.heal()
            print("\(warrior.name)  Stm: \(oldLife) -> \(warrior.life)")
        default:
            return
        }
    }
    
    //Méthode pour sélectionner un combattant adverse et l'attaquer
    func attack(playerToAttack: Player, warrior: Warrior) {
        print("\n\n\(warrior.name), select a warrior, by entering a number, to attack"
            + "\n1. \(playerToAttack.warriors[0].name)  HP: \(playerToAttack.warriors[0].life)  Stm: \(playerToAttack.warriors[0].stamina)"
            + "\n2. \(playerToAttack.warriors[1].name)  HP: \(playerToAttack.warriors[1].life)  Stm: \(playerToAttack.warriors[1].stamina)"
            + "\n3. \(playerToAttack.warriors[2].name)  HP: \(playerToAttack.warriors[2].life)  Stm: \(playerToAttack.warriors[2].stamina)")
        guard let warriorAttacked = readLine() else {
            warning(text: "Warrior can't be nil !")
            return attack(playerToAttack: playerToAttack, warrior: warrior) }
        guard let warriorAttackedIndex = Int(warriorAttacked) else {
            warning(text: "Select a warrior by entering a number !")
            return attack(playerToAttack: playerToAttack, warrior: warrior) }
        guard 1...3 ~= warriorAttackedIndex else {
            warning(text: "Enter a number between 1 to 3 !")
            return attack(playerToAttack: playerToAttack, warrior: warrior) }
        
        if (playerToAttack.warriors[warriorAttackedIndex - 1].life == 0) {
            warning(text: "This warrior is already dead, please select an another one to attack")
            return attack(playerToAttack: playerToAttack, warrior: warrior)
        }
        let oldLife: Int = playerToAttack.warriors[warriorAttackedIndex - 1].life
        let oldStamina: Int = warrior.stamina
        playerToAttack.warriors[warriorAttackedIndex - 1].life -= warrior.weapon.damage > playerToAttack.warriors[warriorAttackedIndex - 1].life ? playerToAttack.warriors[warriorAttackedIndex - 1].life : warrior.weapon.damage
        warrior.stamina -= warrior.weapon.consumedEnergy
        print("\(playerToAttack.warriors[warriorAttackedIndex - 1].name) HP: \(oldLife) -> \(playerToAttack.warriors[warriorAttackedIndex - 1].life)"
            + "\n\(warrior.name) Stm: \(oldStamina) -> \(warrior.stamina)\n\n")
        
    }
}
