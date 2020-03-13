//
//  battle.swift
//  JeuProjet3
//
//  Created by Djiva Canessane on 26/02/2020.
//  Copyright © 2020 Djiva Canessane. All rights reserved.
//

import Foundation

//Class where the fight takes place between the 2 players
class Battle {
    //round lets you know the current number of rounds and determine which player should play
    var round: Int = 0
    
    //Main method
    func battle(players: [Player]) {
        print("\n\n\nLet the battle begin !")
        
        //Loop executed as long as both players have at least one living fighter
        while !isGameOver(players: players) {
            round += 1
            let playerIndex: Int = round % 2 != 0 ? 0 : 1
            let warrior: Warrior = chooseWarrior(player: players[playerIndex])
            surpriseChest(number: Int.random(in: 0...4), warrior: warrior)
            let action: Int = askAction(warrior: warrior)
            doAction(action: action, warrior: warrior, playerToAttack: playerIndex == 0 ? players[1] : players[0], players: players)
        }
        let looserPlayerIndex: Int = players[0].isDead() ? 0 : 1
        EndGame().endGame(players: players, looserPlayerIndex: looserPlayerIndex, round: round)
    }
    
    //Method to check if one of the two teams is dead
    func isGameOver(players: [Player]) -> Bool {
        return players[0].isDead() || players[1].isDead()
    }
    
    //Method that generates a chest randomly
    func surpriseChest(number: Int, warrior: Warrior) {
        guard number == 2 else { return }
        print("A chest has appeared, let see what it contains...")
        let newWeapon: Weapon = Weapon(type: WeaponType.allCases[Int.random(in: 0...2)])
        print("Your warrior got a new weapon:"
            + "\nDamage: \(newWeapon.damage)"
            + "\nStamina consumed: \(newWeapon.consumedEnergy)")
        warrior.weapon = newWeapon
    }
    
    //Method for choosing a fighter from his team
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
    
    //Method for proposing possible actions by the combatant
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
    
    //Method for performing the previously selected action
    func doAction(action: Int, warrior: Warrior, playerToAttack: Player, players: [Player]) {
        let reAction: Int
        switch action {
        //Attaquer
        case 1:
            if (warrior.stamina < warrior.weapon.consumedEnergy) {
                //If the fighter does not have enough stamina to attack we invite him to choose another action
                warning(text: "Your warrior is too weak, let him meditate before attack !")
                reAction = askAction(warrior: warrior)
                doAction(action: reAction, warrior: warrior, playerToAttack: playerToAttack, players: players)
                return
            }
            
            attack(playerToAttack: playerToAttack, warrior: warrior)
        //Regénèrer l'endurance
        case 2:
            if (warrior.stamina == 100) {
                //If the fighter already has all his stamina we invite him to choose another action
                warning(text: "Choose another action, because his stamina is full")
                reAction = askAction(warrior: warrior)
                doAction(action: reAction, warrior: warrior, playerToAttack: playerToAttack, players: players)
                return
            }
            let oldStamina: Int = warrior.stamina
            warrior.meditate()
            print("\(warrior.name)  Stm: \(oldStamina) -> \(warrior.stamina)")
        //Regenerate health points
        case 3:
            if (warrior.life == 100) {
                //If the fighter got all of his HP, we invite him to choose another action
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
    
    //Method for selecting and attacking an opposing fighter
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
