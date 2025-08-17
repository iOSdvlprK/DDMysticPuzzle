//
//  MysticPuzzleViewModel.swift
//  DDMysticPuzzle
//
//  Created by joe on 8/9/25.
//

import SwiftUI

class MysticPuzzleViewModel: ObservableObject {
    @Published var mysticPuzzleModel: MysticPuzzleModel = MysticPuzzleModel(tiles: [], n: 0)
    
    init() {
//        self.findFonts()
        self.createInitialItems()
        self.shuffle()
    }
    
    /// Finds all available fonts
    /// This is not used in the app but may be
    /// useful in case we wish to change fonts
    /// in the future.
    func findFonts() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
    
    func createInitialItems() {
        var tiles: [TileModel] = []
        tiles.append(TileModel(value: 1, currentPoint: LEFT * 2, winningPoint: LEFT * 2))
        
        tiles.append(TileModel(value: 2, currentPoint: LEFT * 1, winningPoint: LEFT * 1))
        
        tiles.append(TileModel(value: 3, currentPoint: .zero, winningPoint: .zero))
        
        tiles.append(TileModel(value: 4, currentPoint: RIGHT * 1, winningPoint: RIGHT * 1))
        
        tiles.append(TileModel(value: 5, currentPoint: LEFT * 2 + DOWN, winningPoint: LEFT * 2 + DOWN))
        
        tiles.append(TileModel(value: 6, currentPoint: LEFT * 1 + DOWN, winningPoint: LEFT * 1 + DOWN))
        
        tiles.append(TileModel(value: 7, currentPoint: .zero + DOWN, winningPoint: .zero + DOWN))
        
        tiles.append(TileModel(value: 8, currentPoint: RIGHT * 1 + DOWN, winningPoint: RIGHT * 1 + DOWN))
        
        tiles.append(TileModel(value: 9, currentPoint: LEFT * 2 + DOWN * 2, winningPoint: LEFT * 2 + DOWN * 2))
        
        tiles.append(TileModel(value: 10, currentPoint: LEFT * 1 + DOWN * 2, winningPoint: LEFT * 1 + DOWN * 2))
        
        tiles.append(TileModel(value: 11, currentPoint: .zero + DOWN * 2, winningPoint: .zero + DOWN * 2))
        
        tiles.append(TileModel(value: 12, currentPoint: RIGHT * 1 + DOWN * 2, winningPoint: RIGHT * 1 + DOWN * 2))
        
        tiles.append(TileModel(value: 13, currentPoint: LEFT * 2 + DOWN * 3, winningPoint: LEFT * 2 + DOWN * 3))
        
        tiles.append(TileModel(value: 14, currentPoint: LEFT * 1 + DOWN * 3, winningPoint: LEFT * 1 + DOWN * 3))
        
        tiles.append(TileModel(value: 15, currentPoint: .zero + DOWN * 3, winningPoint: .zero + DOWN * 3))
        
        let n = 4
        self.mysticPuzzleModel = MysticPuzzleModel(tiles: tiles, n: n)
    }
    
    // TODO:
    func shuffle() {}
}
