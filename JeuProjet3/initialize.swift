//
//  game.swift
//  JeuProjet3
//
//  Created by Djiva Canessane on 25/02/2020.
//  Copyright © 2020 Djiva Canessane. All rights reserved.
//

import Foundation

class Initialize {
    
    var players: [Player] = []
    var names: [String] = []
    
    func initializePlayersWithWarriors() {
        print("🎊 Hello, welcome into the Game! 🎊")
        
        askPlayerName(index: 0)
        askPlayerName(index: 1)
        
        for i in 0...2 {
            let warriorNameBuffer: String = askPlayerWarriorName(playerIndex: 0, warriorIndex: i)
            let warriorWeapon: Weapon = askPlayerWarriorWeapon(playerIndex: 0, warriorIndex: i, warriorName: warriorNameBuffer)
            createWarrior(playerIndex: 0, warriorName: warriorNameBuffer, warriorWeapon: warriorWeapon)
        }
        
        for i in 0...2 {
            let warriorNameBuffer: String = askPlayerWarriorName(playerIndex: 1, warriorIndex: i)
            let warriorWeapon: Weapon = askPlayerWarriorWeapon(playerIndex: 1, warriorIndex: i, warriorName: warriorNameBuffer)
            createWarrior(playerIndex: 1, warriorName: warriorNameBuffer, warriorWeapon: warriorWeapon)
        }
        
        Battle().battle(players: players)
    }

    func askPlayerName(index: Int)  {
        
        print("\nPlease enter a name for player \(index + 1)")
        guard let playerName = readLine() else {
            warning(text: "Player name can't be nil !")
            return askPlayerName(index: index) }
        guard playerName != "" else {
            warning(text: "Player name can't be empty !")
            return askPlayerName(index: index) }
        if (names.contains(playerName)) {
            warning(text: "This name is already used, please insert another name")
            return askPlayerName(index: index)
        }
        names.append(playerName)
        players.append(Player(name: playerName))
        
    }
    
    func askPlayerWarriorName(playerIndex: Int, warriorIndex: Int) -> String {
        print("\n\(players[playerIndex].name), enter a name for warrior \(warriorIndex + 1)")
        guard let warriorName = readLine() else {
            warning(text: "Warrior name can't be nil !")
            return askPlayerWarriorName(playerIndex: playerIndex, warriorIndex: warriorIndex) }
        guard warriorName != "" else {
            warning(text: "Warrior name can't be empty !")
            return askPlayerWarriorName(playerIndex: playerIndex, warriorIndex: warriorIndex) }
        if (names.contains(warriorName)) {
            warning(text: "This name is already used, please insert another name")
            return askPlayerWarriorName(playerIndex: playerIndex, warriorIndex: warriorIndex)
        }
        names.append(warriorName)
        return warriorName
    }
    
    func askPlayerWarriorWeapon(playerIndex: Int, warriorIndex: Int, warriorName: String) -> Weapon {
        print("\n\(players[playerIndex].name), select a weapon, by entering a number, for \(warriorName), among:"
            + "\n1. Sword"
            + "\n2. Arc"
            + "\n3. Gun")
        
        guard let warriorWeapon = readLine() else {
            warning(text: "Warrior weapon can't be nil !")
            return askPlayerWarriorWeapon(playerIndex: playerIndex, warriorIndex: warriorIndex, warriorName: warriorName) }
        guard let warriorWeaponIndex = Int(warriorWeapon) else {
            warning(text: "Select a weapon by entering a number !")
            return askPlayerWarriorWeapon(playerIndex: playerIndex, warriorIndex: warriorIndex, warriorName: warriorName) }
        guard 1...3 ~= warriorWeaponIndex else {
            warning(text: "Enter a number between 1 to 3 !")
            return askPlayerWarriorWeapon(playerIndex: playerIndex, warriorIndex: warriorIndex, warriorName: warriorName) }
        return Weapon(type: WeaponType.allCases[warriorWeaponIndex - 1])
    }
    
    func createWarrior(playerIndex: Int, warriorName: String, warriorWeapon: Weapon) {
        players[playerIndex].warriors.append(Warrior(name: warriorName, weapon: warriorWeapon))
    }
    
    
}
