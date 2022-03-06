//
//  ContentView.swift
//  TicTacToe
//
//  Created by Igor Manakov on 06.03.2022.
//

import SwiftUI

struct ContentView: View {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isHumanTurn = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                Spacer()
                
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(0..<9) { index in
                        ZStack {
                            Circle()
                                .foregroundColor(.blue).opacity(0.7)
                                .frame(width: geometry.size.width / 3 - 15, height: geometry.size.width / 3 - 15)
                                .shadow(radius: 5)
                            
                            Image(systemName: moves[index]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            if isSquareOccupied(in: moves, for: index) {return}
                            moves[index] = Move(player: isHumanTurn ? .human : .computer, boardIndex: index)
                            isHumanTurn.toggle()
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
    
    func isSquareOccupied(in moves: [Move?], for index: Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index})
    }
    
}

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
