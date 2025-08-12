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
    let tileDimensions: CGFloat = 70
    
    var body: some View {
        ZStack {
            Color(.blue)
                .opacity(0.3).ignoresSafeArea()
            
            VStack {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                ZStack {
                    let tiles = mysticPuzzleViewModel.mysticPuzzleModel.tiles
                    
                    ForEach(tiles) { tile in
                        TileView(tileNumber: tile.value, tileDimensions: tileDimensions, offset: tile.currentPoint)
                    }
                }
            }
        }
    }
}

struct TileView: View {
    let tileNumber: Int
    let tileDimensions: CGFloat
    let offset: CGPoint
    
    let somePadding: CGFloat = 3
    let digitResizeFactor: CGFloat = 5 / 2
    
    var body: some View {
        let direction = offset * tileDimensions
        
        let deltaX = direction.x + tileDimensions / 2
        let deltaY = direction.y - 3 * tileDimensions / 2
        
        Image("digit\(tileNumber)")
            .resizable()
            .renderingMode(.template)
            .foregroundStyle(.red)
            .aspectRatio(contentMode: .fit)
            .frame(width: tileDimensions, height: tileDimensions)
            .padding()
            .background(
                Color.gray
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
