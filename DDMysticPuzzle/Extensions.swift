//
//  Extensions.swift
//  DDMysticPuzzle
//
//  Created by joe on 8/9/25.
//

import CoreGraphics

public extension CGPoint {
    /// Returns the distance from the
    /// origin (0,0) to (x,y) where (x,y)
    /// is from self.
    /// - Returns: The length
    func length() -> CGFloat {
        return sqrt(x * x + y * y)
    }
    
    /// Returns the distance from the self point to
    /// the parameter point
    /// - Parameter point: (x,y) vallue
    /// - Returns: The distance between two points.
    func distanceTo(point: CGPoint) -> CGFloat {
        let differenceOfPoints = self - point
        return differenceOfPoints.length()
    }
    
    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        let dx = left.x - right.x
        let dy = left.y - right.y
        return CGPoint(x: dx, y: dy)
    }
    
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        let dx = left.x + right.x
        let dy = left.y + right.y
        return CGPoint(x: dx, y: dy)
    }
    
    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        let scaledX = point.x * scalar
        let scaledY = point.y * scalar
        return CGPoint(x: scaledX, y: scaledY)
    }
}
