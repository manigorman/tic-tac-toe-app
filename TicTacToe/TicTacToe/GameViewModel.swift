//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Igor Manakov on 06.03.2022.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isBoardDisabled: Bool = false
    @Published var alertItem: AlertItem?
    
    func processPlayerMove(for position: Int) {
            if isSquareOccupied(in: moves, for: position) {return}
            moves[position] = Move(player: .human, boardIndex: position)
            isBoardDisabled = true
            
            if checkWinCondition(for: .human, in: moves) {
                alertItem = AlertContext.humanWins
                return
            }
            
            if checkDrawCondition(in: moves) {
                alertItem = AlertContext.draw
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                let computerPosition = determineComputerMovePosition(in: moves)
                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                isBoardDisabled = false
                
                if checkWinCondition(for: .computer, in: moves) {
                    alertItem = AlertContext.computerWins
                    return
                }
                
                if checkDrawCondition(in: moves) {
                    alertItem = AlertContext.draw
                    return
                }
            }
        
    }
    
    func isSquareOccupied(in moves: [Move?], for index: Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index})
    }
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        let winPatterns: Set<Set<Int>> = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            [0, 4, 8],
            [2, 4, 6]
        ]
        
        //If AI can win, win
        let computerMoves = moves.compactMap{ $0 }.filter{ $0.player == .computer }
        let computerPositions = Set(computerMoves.map{ $0.boardIndex })
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPositions)
            if winPositions.count == 1 {
                let isAvaiable = !isSquareOccupied(in: moves, for: winPositions.first!)
                if isAvaiable { return winPositions.first! }
            }
        }
        
        //If AI can't win, block
        let humanMoves = moves.compactMap{ $0 }.filter{ $0.player == .human }
        let humanPositions = Set(humanMoves.map{ $0.boardIndex })
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            if winPositions.count == 1 {
                let isAvaiable = !isSquareOccupied(in: moves, for: winPositions.first!)
                if isAvaiable { return winPositions.first! }
            }
        }
        
        //If AI can't block, take a middle square
        let centerSquare = 4
        let isAvaiable = !isSquareOccupied(in: moves, for: centerSquare)
        if isAvaiable { return centerSquare }
        
        //If AI can't take middle square, take a random available square
        var movePosition = Int.random(in: 0..<9)
        while isSquareOccupied(in: moves, for: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            [0, 4, 8],
            [2, 4, 6]
        ]
        
        let playerMoves = moves.compactMap{ $0 }.filter{ $0.player == player }
        let playerPositions = Set(playerMoves.map{ $0.boardIndex })
        
        for pattern in winPatterns {
            if pattern.isSubset(of: playerPositions) {
                return true
            }
        }
        
        return false
    }
    
    func checkDrawCondition(in moves: [Move?]) -> Bool {
        return moves.compactMap{ $0 }.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        isBoardDisabled = false
    }
}
