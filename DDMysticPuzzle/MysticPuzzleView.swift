//
//  MysticPuzzleView.swift
//  DDMysticPuzzle
//
//  Created by joe on 8/7/25.
//

import SwiftUI

struct MysticPuzzleView: View {
    @StateObject var mysticPuzzleViewModel: MysticPuzzleViewModel = .init()
    
    let title = "Mystic Puzzle"
    let newGamePrompt = "New Game"
    let shufflePrompt = "Shuffle"
    let easyGamePrompt = "Easy Game"
    let tileDimensions: CGFloat = 70
    
    var body: some View {
        ZStack {
            Image(.waterBackground)
                .opacity(0.9).ignoresSafeArea()
            
            VStack {
                ChalkboardTextView(text: title, size: 42, color: .white)
                
                ZStack {
                    let last = mysticPuzzleViewModel.mysticPuzzleModel.tiles.count - 1
                    
                    ForEach(0 ..< last, id: \.self) { index in
                        let tile = mysticPuzzleViewModel.mysticPuzzleModel.tiles[index]
                        TileView(tileNumber: tile.value, tileDimensions: tileDimensions, offset: tile.currentPoint)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    if mysticPuzzleViewModel.move(index: index) {
                                        // TODO: add sound effect here
                                        print("Make a sound")
                                    }
                                }
                            }
                    }
                }
                .frame(maxWidth: tileDimensions * 4, maxHeight: tileDimensions * 4)
                .padding()
                .background(
                    Image(.blueMarbleBackground)
                        .resizable()
                        .opacity(0.9)
                )
                .clipShape(.rect(cornerRadius: 20))
                .padding()
                .padding(.vertical)
                .shadow(color: .black, radius: 10, x: 3, y: 3)
                
                HStack {
                    Button(action: {
                        mysticPuzzleViewModel.createInitialItems()
                        mysticPuzzleViewModel.shuffle()
                    }, label: {
                        ChalkboardTextView(text: mysticPuzzleViewModel.done() ? newGamePrompt : shufflePrompt, size: 24, color: .yellow)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.yellow, lineWidth: 3)
                            }
                            .padding(.vertical)
                    })
                    
                    Button(action: {
                        mysticPuzzleViewModel.createInitialItems()
                    }, label: {
                        ChalkboardTextView(text: easyGamePrompt, size: 24, color: .green)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.green, lineWidth: 3)
                            }
                            .padding(.vertical)
                    })
                }
            }
        }
    }
}

struct ChalkboardTextView: View {
    let text: String
    let size: CGFloat
    let color: Color
    
    var body: some View {
        Text(text)
            .font(Font.custom("ChalkboardSE-Bold", size: size))
            .fontWeight(.bold)
            .foregroundStyle(color)
    }
}

struct TileView: View {
    let tileNumber: Int
    let tileDimensions: CGFloat
    let offset: CGPoint
    
    let somePadding: CGFloat = 3
    let digitResizeFactor: CGFloat = 0.8
    
    var body: some View {
        let direction = offset * tileDimensions
        
        let deltaX = direction.x + tileDimensions / 2
        let deltaY = direction.y - 3 * tileDimensions / 2
        
        Image("digit\(tileNumber)")
            .resizable()
            .renderingMode(.template)
            .foregroundStyle(.red)
            .aspectRatio(contentMode: .fit)
            .frame(width: tileDimensions * digitResizeFactor, height: tileDimensions * digitResizeFactor)
            .scaleEffect(tileNumber < 10 || tileNumber == 11 ? 0.8 : 1)
            .padding()
            .background(
                Image("MarbleTileBackground")
                    .resizable()
                    .frame(width: tileDimensions - somePadding, height: tileDimensions - somePadding)
                    .clipShape(.rect(cornerRadius: 10))
            )
            .offset(x: deltaX, y: deltaY)
            .shadow(color: .black, radius: 1, x: 1, y: 1)
    }
}

#Preview {
    MysticPuzzleView()
}
