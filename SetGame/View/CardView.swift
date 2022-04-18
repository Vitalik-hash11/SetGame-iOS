//
//  PlayingCard.swift
//  SetGame
//
//  Created by newbie on 15.04.2022.
//

import UIKit

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var lineWidth: CGFloat = 5.0
    @IBInspectable var scope: Double = 0.9
    
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
//        let path = drawOval(in: rect)
//        let path = drawDiamond(in: rect)
        let path = drawSquiggle(in: rect)
        UIColor.red.setFill()
        UIColor.purple.setStroke()
        path.fill()
        path.lineWidth = lineWidth
        path.stroke()
    }

    private func setup() {
        // TODO: setup staff
        backgroundColor = UIColor.white
    }
    
    private func drawOval(in rect: CGRect) -> UIBezierPath {
        return UIBezierPath(roundedRect: CGRect(x: rect.width*0.25/2, y: rect.height*0.25/2, width: rect.width*0.75, height: rect.height*0.75), cornerRadius: rect.width/4)
    }
    
    private func drawDiamond(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.width/6, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.height/6))
        path.addLine(to: CGPoint(x: rect.width/6*5, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.height/6*5))
        path.close()
        return path
    }
    
    private func drawSquiggle(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let startPoint = CGPoint(x: rect.width/6, y: rect.height/6*5)
        path.move(to: startPoint)
        let cp1 = CGPoint(x: rect.width/6, y: rect.minY-rect.midY)
        let cp2 = CGPoint(x: rect.width/6*4, y: rect.height/6*4)
        let cp3 = CGPoint(x: rect.width/6*5, y: rect.height+rect.midY)
        let cp4 = CGPoint(x: rect.width/5, y: rect.midY)
        path.addCurve(to: CGPoint(x: rect.width/6*5, y: rect.height/6), controlPoint1: cp1, controlPoint2: cp2)
        path.addCurve(to: startPoint, controlPoint1: cp3, controlPoint2: cp4)
        return path
    }
    
    private func setColor(for path: UIBezierPath) {
        switch color {
        case 0:
            setShading(for: path, with: UIColor.red)
        case 1:
            setShading(for: path, with: UIColor.purple)
        case 2:
            setShading(for: path, with: UIColor.green)
        default:
            fatalError("Cannot draw \(String(describing: color)) color identifier")
        }
    }
    
    private func setShading(for path: UIBezierPath, with color: UIColor) {
        switch shading {
        case 0:
            color.setFill()
        case 1:
            color.setStroke()
            UIColor.white.setFill()
            path.lineWidth = 7.0
        case 2:
            print("Striping")
        default:
            fatalError("Cannot draw \(String(describing: shading)) shading identifier")
        }
    }
}
