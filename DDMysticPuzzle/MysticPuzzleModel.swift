//
//  MysticPuzzleModel.swift
//  DDMysticPuzzle
//
//  Created by joe on 8/7/25.
//

import SwiftUI

/// The TileModel models a tile. It has a value which is
/// between 1 and 15 for the 15 puzzle.
/// The currentPoint describes where is the tile currently
/// located. The winningPoint describes the position the
/// tile is striving to reach. The goal is to move all tiles to
/// the position:
/// 1 2 3 4
/// 5 6 7 8
/// 9 10 11 12
/// 13 14 15
///
/// In such a situation all of the tiles are at their
/// winning points and the game is over.
struct TileModel: Identifiable {
    let id: UUID
    let value: Int
    var currentPoint: CGPoint
    let winningPoint: CGPoint
    
    init(id: UUID = UUID(), value: Int, currentPoint: CGPoint, winningPoint: CGPoint) {
        self.id = id
        self.value = value
        self.currentPoint = currentPoint
        self.winningPoint = winningPoint
    }
}

/// This is the model of the game. The game consists
/// of an array of tiles and n is the number of rows and
/// columns in the game.
/// For instance if n = 4 then we will look at a 4 x 4
/// board and there will be 15 tiles, i.e. n * n - 1.
///
/// We will focuses on the 15 tile game (we called it
/// the mystic puzzle). However we will be able to
/// generalize the game for any n.
struct MysticPuzzleModel: Identifiable {
    let id: UUID
    var tiles: [TileModel]
    let n: Int
    
    init(id: UUID = UUID(), tiles: [TileModel], n: Int) {
        self.id = id
        self.tiles = tiles
        self.n = n
    }
}

// LEFT, RIGHT, UP, DOWN describe relative tile position.
let LEFT = CGPoint(x: -1, y: 0)
let RIGHT = CGPoint(x: 1, y: 0)
let UP = CGPoint(x: 0, y: -1)
let DOWN = CGPoint(x: 0, y: 1)
