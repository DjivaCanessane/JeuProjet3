//
//  game.swift
//  JeuProjet3
//
//  Created by Djiva Canessane on 25/02/2020.
//  Copyright © 2020 Djiva Canessane. All rights reserved.
//

import Foundation

class Game {
    
    var players: [Player] = []
    
    
    func startGame() {
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
    }

    func askPlayerName(index: Int)  {
        print("\nPlease enter a name for player \(index + 1)")
        guard let playerName = readLine() else {
            print("\n\n⚠️ Player name can't be nil ! ⚠️")
            return askPlayerName(index: index) }
        guard playerName != "" else {
            print("\n\n⚠️ Player name can't be empty ! ⚠️")
            return askPlayerName(index: index) }
        players.append(Player(name: playerName))
        
    }
    
    func askPlayerWarriorName(playerIndex: Int, warriorIndex: Int) -> String {
        print("\nPlayer \(playerIndex + 1), enter a name for warrior \(warriorIndex + 1)")
        guard let warriorName = readLine() else {
            print("\n\n⚠️ Warrior name can't be nil ! ⚠️")
            return askPlayerWarriorName(playerIndex: playerIndex, warriorIndex: warriorIndex) }
        guard warriorName != "" else {
            print("\n\n⚠️ Warrior name can't be empty ! ⚠️")
            return askPlayerWarriorName(playerIndex: playerIndex, warriorIndex: warriorIndex) }
        return warriorName
    }
    
    func askPlayerWarriorWeapon(playerIndex: Int, warriorIndex: Int, warriorName: String) -> Weapon {
        print("\nPlayer \(playerIndex + 1), select a weapon, by entering a number, for warrior \(warriorIndex + 1) among:"
            + "\n1.Sword"
            + "\n2.Arc"
            + "\n3.Gun")
        
        guard let warriorWeapon = readLine() else {
            print("\n\n⚠️ Warrior weapon can't be nil ! ⚠️")
            return askPlayerWarriorWeapon(playerIndex: playerIndex, warriorIndex: warriorIndex, warriorName: warriorName) }
        guard let warriorWeaponIndex = Int(warriorWeapon) else {
            print("\n\n⚠️ Select a weapon by entering a number ! ⚠️")
            return askPlayerWarriorWeapon(playerIndex: playerIndex, warriorIndex: warriorIndex, warriorName: warriorName) }
        guard 1...3 ~= warriorWeaponIndex else {
            print("\n\n⚠️ Enter a number between 1 to 3 ! ⚠️")
            return askPlayerWarriorWeapon(playerIndex: playerIndex, warriorIndex: warriorIndex, warriorName: warriorName) }
        return Weapon(type: WeaponType.allCases[warriorWeaponIndex - 1])
    }
    
    func createWarrior(playerIndex: Int, warriorName: String, warriorWeapon: Weapon) {
        players[playerIndex].warriors.append(Warrior(name: warriorName, weapon: warriorWeapon))
    }
    
    
}
