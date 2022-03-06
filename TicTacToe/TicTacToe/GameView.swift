//
//  ContentView.swift
//  TicTacToe
//
//  Created by Igor Manakov on 06.03.2022.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                Spacer()
                
                Text("Tic Tac Toe")
                    .font(.system(size: 50, weight: .semibold, design: .default))
                    .foregroundColor(.blue)
                    .shadow(radius: 5)
                
                Spacer()
                
                LazyVGrid(columns: viewModel.columns, spacing: 5) {
                    ForEach(0..<9) { index in
                        ZStack {
                            Circle()
                                .foregroundColor(.blue).opacity(0.7)
                                .frame(width: geometry.size.width / 3 - 15, height: geometry.size.width / 3 - 15)
                                .shadow(radius: 5)
                            
                            Image(systemName: viewModel.moves[index]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            viewModel.processPlayerMove(for: index)
                        }
                    }
                }
                Spacer()
            }
            .disabled(viewModel.isBoardDisabled)
            .padding()
            .alert(item: $viewModel.alertItem, content: { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: { viewModel.resetGame() }))

            })
        }
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
        GameView()
    }
}
