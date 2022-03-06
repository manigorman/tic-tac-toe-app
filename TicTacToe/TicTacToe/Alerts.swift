//
//  Alerts.swift
//  TicTacToe
//
//  Created by Igor Manakov on 06.03.2022.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWins = AlertItem(title: Text("You Win!"),
                              message: Text("You are so smart. You beat your own AI."),
                              buttonTitle: Text("Hell Yeah"))
    
    static let computerWins = AlertItem(title: Text("You Lost"),
                              message: Text("You programmed a super AI."),
                              buttonTitle: Text("Rematch"))
    
    static let draw = AlertItem(title: Text("Draw"),
                              message: Text("What a battle..."),
                              buttonTitle: Text("Try Again"))
}
