//
//  PlayingCard.swift
//  SetGame
//
//  Created by newbie on 15.04.2022.
//

import UIKit

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var lineWidth: CGFloat = 2.0
    
    @IBInspectable var count = 0 {
        didSet {
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    @IBInspectable var shading = 0 {
        didSet {
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    @IBInspectable var color = 0 {
        didSet {
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    @IBInspectable var shape = 0 {
        didSet {
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    init(frame: CGRect, count: Int, shading: Int, color: Int, shape: Int) {
        super.init(frame: frame)
        self.count = count
        self.shading = shading
        self.color = color
        self.shape = shape
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        let path: UIBezierPath = drawByCount()
        setColor()
        path.fill()
        path.lineWidth = lineWidth
        path.stroke()
    }

    private func setup() {
        // TODO: setup staff
        backgroundColor = UIColor.white
    }
    
    private func drawByCount() -> UIBezierPath {
        let middleRect = CGRect(x: bounds.minX, y: bounds.maxY/3, width: bounds.width, height: bounds.height/3)
        if count == 0 {
           return  drawByShape(in: middleRect)
        } else if count == 1 {
            let topRect = CGRect(x: bounds.minX, y: bounds.minY + bounds.height/3/4, width: bounds.width, height: bounds.height/3)
            let bottomRect = CGRect(x: bounds.minX, y: bounds.midY + bounds.height/3/4, width: bounds.width, height: bounds.height/3)
            let path = drawByShape(in: topRect)
            path.append(drawByShape(in: bottomRect))
            return path
        } else if count == 2 {
            let topRect = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height/3)
            let bottomRect = CGRect(x: bounds.minX, y: bounds.maxY/3*2, width: bounds.width, height: bounds.height/3)
            let path = drawByShape(in: middleRect)
            path.append(drawByShape(in: topRect))
            path.append(drawByShape(in: bottomRect))
            return path
        } else {
            fatalError("Invalid count of figures in the card")
        }
    }
    
    private func drawByShape(in rect: CGRect) -> UIBezierPath {
        switch shape {
        case 0:
            return drawOval(in: rect)
        case 1:
            return drawDiamond(in: rect)
        case 2:
            return drawSquiggle(in: rect)
        default:
            fatalError("Unknown shape")
        }
    }
    
    private func drawOval(in rect: CGRect) -> UIBezierPath {
        return UIBezierPath(roundedRect: CGRect(x: rect.width*0.25/2, y: rect.minY + rect.height*0.25/2, width: rect.width*0.75, height: rect.height*0.75), cornerRadius: rect.width/4)
    }
    
    private func drawDiamond(in rect: CGRect) -> UIBezierPath {
        let offset = rect.height * 0.25 / 2
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.width/6, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + offset))
        path.addLine(to: CGPoint(x: rect.width/6*5, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - offset))
        path.close()
        return path
    }
    
    private func drawSquiggle(in rect: CGRect) -> UIBezierPath {
        // TODO: Should be reworked in the future
        let heightOffset = rect.height * 0.25 / 2
        let widthOffset = rect.width * 0.25 / 2
        let path = UIBezierPath()
        let startPoint = CGPoint(x: rect.minX + widthOffset, y: rect.maxY - heightOffset)
        path.move(to: startPoint)
        let cp1 = CGPoint(x: rect.minX, y: rect.minY)
        let cp2 = CGPoint(x: rect.maxX, y: rect.maxY)
        let cp3 = CGPoint(x: rect.maxX, y: rect.maxY)
        let cp4 = CGPoint(x: rect.midX, y: rect.midY)
        path.addCurve(to: CGPoint(x: rect.width - widthOffset, y: rect.minY + heightOffset), controlPoint1: cp1, controlPoint2: cp2)
        path.addCurve(to: startPoint, controlPoint1: cp3, controlPoint2: cp4)
        return path
    }
    
    private func setColor() {
        switch color {
        case 0:
            setShading(with: UIColor.red)
        case 1:
            setShading(with: UIColor.purple)
        case 2:
            setShading(with: UIColor.green)
        default:
            fatalError("Cannot draw \(String(describing: color)) color identifier")
        }
    }
    
    private func setShading(with color: UIColor) {
        switch shading {
        case 0:
            color.setFill()
            color.setStroke()
        case 1:
            color.setStroke()
            UIColor.white.setFill()
        case 2:
            color.setStroke()
            color.withAlphaComponent(0.5).setFill()
        default:
            fatalError("Cannot draw \(String(describing: shading)) shading identifier")
        }
    }
}
