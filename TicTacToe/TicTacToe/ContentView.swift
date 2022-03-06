//
//  ContentView.swift
//  TicTacToe
//
//  Created by Igor Manakov on 06.03.2022.
//

import SwiftUI

let columns: [GridItem] = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]

struct ContentView: View {
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                Spacer()
                
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        ZStack {
                            Circle()
                                .foregroundColor(.blue).opacity(0.7)
                                .frame(width: geometry.size.width / 3 - 15, height: geometry.size.width / 3 - 15)
                                .shadow(radius: 5)
                            
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
