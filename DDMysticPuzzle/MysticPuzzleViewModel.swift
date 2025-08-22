//
//  MysticPuzzleViewModel.swift
//  DDMysticPuzzle
//
//  Created by joe on 8/9/25.
//

import SwiftUI
import AVFoundation

var audioPlayer: AVAudioPlayer? = .init()

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            
            audioPlayer?.play()
        } catch {
            print("Something has gone wrong.")
        }
    }
}

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
        
        tiles.append(TileModel(value: 15, currentPoint: DOWN * 3, winningPoint: DOWN * 3))
        
        // add empty tile
        tiles.append(TileModel(value: 16, currentPoint: DOWN * 3 + RIGHT, winningPoint: DOWN * 3 + RIGHT))
        
        let n = 4
        self.mysticPuzzleModel = MysticPuzzleModel(tiles: tiles, n: n)
    }
    
    /// returns true when all of the current points equal to the winning points
    func done() -> Bool {
        for tile in mysticPuzzleModel.tiles {
            if tile.currentPoint != tile.winningPoint {
                return false
            }
        }
        return true
    }
    
    /// Shuffle the tiles
    func shuffle() {
        /*
         If n is even then we will do an even number of inversions. If n is odd then we will do an odd number of inversions.
         
         We will do n*n inversions which is even when n is even and odd when n is odd.
         */
        let n = mysticPuzzleModel.n
        
        for _ in 0 ..< n * n {
            let (i, j) = getRandomIJ(max: n * n - 1)
            /*
              invert the i-th tile with the j-th tile
             */
            let lastPosition = mysticPuzzleModel.tiles[i].currentPoint
            
            mysticPuzzleModel.tiles[i].currentPoint = mysticPuzzleModel.tiles[j].currentPoint
            
            mysticPuzzleModel.tiles[j].currentPoint = lastPosition
        }
    }
    
    func getRandomIJ(max: Int) -> (Int, Int) {
        if max == 1 {
            return (1, 1)
        }
        let i = Int.random(in: 0 ..< max)
        var j: Int
        
        // loop until get to different i and j values
        repeat {
            j = Int.random(in: 0 ..< max)
        } while (i == j)
        return (i, j)
    }
    
    /// The tile at 'index' is moved if and only if
    /// an empty tile is adjacent to it.
    /// Note that we update the model and
    /// then, in turn, the view is updated.
    /// - Parameter index: index of tile
    /// - Returns: True if there is an empty
    /// adjacent tile and false otherwise.
    func move(index: Int) -> Bool {
        var result = false
        
        let n = mysticPuzzleModel.n
        let emptyPosition = mysticPuzzleModel.tiles[n * n - 1].currentPoint
        
        let tilePosition = mysticPuzzleModel.tiles[index].currentPoint
        let distance = tilePosition.distanceTo(point: emptyPosition)
        
        // Are we exactly one tile away from the empty tile?
        if distance == 1 {
            // move tile at 'index' to empty position
            // retain the 'value' and 'winningPoint'
            mysticPuzzleModel.tiles[index] = TileModel(
                value: mysticPuzzleModel.tiles[index].value,
                currentPoint: emptyPosition,
                winningPoint: mysticPuzzleModel.tiles[index].winningPoint
            )
            
            // update empty tile position
            mysticPuzzleModel.tiles[n * n - 1].currentPoint = tilePosition
            
            // return true since tile has been moved
            result = true
        }
        
        return result
    }
}
