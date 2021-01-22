//
//  SetGameShapes.swift
//  SetGame
//
//  Created by Richard on 1/22/21.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let halfWidth = (rect.width / 2 <= rect.height ? rect.width : rect.height * 2) / 2
        let halfHeight = halfWidth / 2
        
        var p = Path()
        p.move(to: CGPoint(x: center.x, y: center.y - halfHeight))
        p.addLine(to: CGPoint(x: center.x + halfWidth, y: center.y))
        p.addLine(to: CGPoint(x: center.x, y: center.y + halfHeight))
        p.addLine(to: CGPoint(x: center.x - halfWidth, y: center.y))
        p.addLine(to: CGPoint(x: center.x, y: center.y - halfHeight))
        return p
    }
}

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        /*
         path.lineWidth = 2;

         [path moveToPoint:CGPointMake(bounds.origin.x + bounds.size.width*0.05, bounds.origin.y + bounds.size.height*0.40)];

         [path addCurveToPoint:CGPointMake(bounds.origin.x + bounds.size.width*0.35, bounds.origin.y + bounds.size.height*0.25)
                 controlPoint1:CGPointMake(bounds.origin.x + bounds.size.width*0.09, bounds.origin.y + bounds.size.height*0.15)
                 controlPoint2:CGPointMake(bounds.origin.x + bounds.size.width*0.18, bounds.origin.y + bounds.size.height*0.10)];

         [path addCurveToPoint:CGPointMake(bounds.origin.x + bounds.size.width*0.75, bounds.origin.y + bounds.size.height*0.30)
                 controlPoint1:CGPointMake(bounds.origin.x + bounds.size.width*0.40, bounds.origin.y + bounds.size.height*0.30)
                 controlPoint2:CGPointMake(bounds.origin.x + bounds.size.width*0.60, bounds.origin.y + bounds.size.height*0.45)];

         [path addCurveToPoint:CGPointMake(bounds.origin.x + bounds.size.width*0.97, bounds.origin.y + bounds.size.height*0.35)
                 controlPoint1:CGPointMake(bounds.origin.x + bounds.size.width*0.87, bounds.origin.y + bounds.size.height*0.15)
                 controlPoint2:CGPointMake(bounds.origin.x + bounds.size.width*0.98, bounds.origin.y + bounds.size.height*0.00)];

         [path addCurveToPoint:CGPointMake(bounds.origin.x + bounds.size.width*0.45, bounds.origin.y + bounds.size.height*0.85)
                 controlPoint1:CGPointMake(bounds.origin.x + bounds.size.width*0.95, bounds.origin.y + bounds.size.height*1.10)
                 controlPoint2:CGPointMake(bounds.origin.x + bounds.size.width*0.50, bounds.origin.y + bounds.size.height*0.95)];

         [path addCurveToPoint:CGPointMake(bounds.origin.x + bounds.size.width*0.25, bounds.origin.y + bounds.size.height*0.85)
                 controlPoint1:CGPointMake(bounds.origin.x + bounds.size.width*0.40, bounds.origin.y + bounds.size.height*0.80)
                 controlPoint2:CGPointMake(bounds.origin.x + bounds.size.width*0.35, bounds.origin.y + bounds.size.height*0.75)];

         [path addCurveToPoint:CGPointMake(bounds.origin.x + bounds.size.width*0.05, bounds.origin.y + bounds.size.height*0.40)
                 controlPoint1:CGPointMake(bounds.origin.x + bounds.size.width*0.00, bounds.origin.y + bounds.size.height*1.10)
                 controlPoint2:CGPointMake(bounds.origin.x + bounds.size.width*0.005, bounds.origin.y + bounds.size.height*0.60)];

         */
        var p = Path()
        
        p.move(to: CGPoint(x: rect.width * 0.05, y: rect.height * 0.40))
        p.addCurve(to: CGPoint(x: rect.width*0.35, y: rect.height*0.25),
                   control1: CGPoint(x: rect.width*0.09, y: rect.height*0.15),
                   control2: CGPoint(x: rect.width*0.18, y: rect.height*0.10))

        p.addCurve(to: CGPoint(x: rect.width*0.75, y: rect.height*0.30),
                   control1: CGPoint(x: rect.width*0.40, y: rect.height*0.30),
                   control2: CGPoint(x: rect.width*0.60, y: rect.height*0.45))

        p.addCurve(to: CGPoint(x: rect.width*0.97, y: rect.height*0.35),
                   control1: CGPoint(x: rect.width*0.87, y: rect.height*0.15),
                   control2: CGPoint(x: rect.width*0.98, y: rect.height*0.00))

        p.addCurve(to: CGPoint(x: rect.width*0.45, y: rect.height*0.85),
                   control1: CGPoint(x: rect.width*0.95, y: rect.height*1.10),
                   control2: CGPoint(x: rect.width*0.50, y: rect.height*0.95))

        p.addCurve(to: CGPoint(x: rect.width*0.25, y: rect.height*0.85),
                   control1: CGPoint(x: rect.width*0.40, y: rect.height*0.80),
                   control2: CGPoint(x: rect.width*0.35, y: rect.height*0.75))

        p.addCurve(to: CGPoint(x: rect.width*0.05, y: rect.height*0.40),
                   control1: CGPoint(x: rect.width*0.00, y: rect.height*1.10),
                   control2: CGPoint(x: rect.width*0.005, y: rect.height*0.60))
        return p
    }
    
    
}
