//
//  File.swift
//  HealthApp
//
//  Created by Elena Tsegelnik on 25.06.2020.
//  Copyright © 2020 Elena Tsegelnik. All rights reserved.
//
import Foundation

import UIKit

@IBDesignable
class CircleGraphView: UIView {
    
    var endArcPrevious : CGFloat = 0.0001
    
    var circularPath = UIBezierPath()
    var shapeLayer = CAShapeLayer()
    var animationShape = CABasicAnimation()
    
    var gradientLayer = CAGradientLayer()
    var nextCircleLayer = CAShapeLayer()
    var gradientAnimation = CABasicAnimation()
    var backCircleLayer = CAShapeLayer()
    var objectLayer = CAShapeLayer()
    
    var arcWidth:CGFloat = 30.0
    var arcColor = #colorLiteral(red: 0, green: 0.4943938851, blue: 0.9980103374, alpha: 1)
    var arcBackgroundColor = #colorLiteral(red: 0.9520987868, green: 0.9522580504, blue: 0.952077806, alpha: 1)
    let colors : [CGColor] = [ #colorLiteral(red: 0.5839291811, green: 0.8167605996, blue: 0.980388701, alpha: 1).cgColor,
                               #colorLiteral(red: 0, green: 0.4943938851, blue: 0.9980103374, alpha: 1).cgColor
    ]
    
    //Important constants for circle
    let fullCircle = 2 * CGFloat.pi
    let start : CGFloat = -0.5 * CGFloat.pi
    var end : CGFloat = 1.5 * CGFloat.pi
    var radius:CGFloat = 100.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        
        //define the radius by the smallest side of the view
        
        
        if rect.width > rect.height {
            radius = (rect.height - arcWidth) / 2.0
        } else {
            radius = (rect.width - arcWidth) / 2.0
        }
        
        //светло-серый фон
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        
        let trackLayer = CAShapeLayer()
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = arcBackgroundColor.cgColor
        trackLayer.lineWidth = arcWidth
        trackLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(trackLayer)
        
        shapeLayer.frame = self.bounds
        
        shapeLayer.strokeColor = colors[0]
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = endArcPrevious
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = arcWidth * 0.8
 
        self.layer.addSublayer(shapeLayer)
        
        gradientLayer.type = .conic
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x:0.5,y:0)
        gradientLayer.frame = self.bounds
        gradientLayer.mask = shapeLayer
        self.layer.addSublayer(gradientLayer)
        
        backCircleLayer.frame = self.bounds
        backCircleLayer.strokeColor = colors[0]
        backCircleLayer.fillColor = UIColor.clear.cgColor
        backCircleLayer.strokeStart = 0
        backCircleLayer.strokeEnd = 0.001
        backCircleLayer.path = circularPath.cgPath
        backCircleLayer.lineWidth = arcWidth * 0.8
        backCircleLayer.lineCap = .round
        self.layer.addSublayer(backCircleLayer)
        
        objectLayer.frame = self.bounds
        objectLayer.strokeColor = colors[1]
        objectLayer.fillColor = UIColor.clear.cgColor
        objectLayer.strokeEnd = endArcPrevious
        objectLayer.strokeStart = endArcPrevious - 0.001
        objectLayer.path = circularPath.cgPath
        objectLayer.lineWidth = arcWidth * 0.8
        objectLayer.lineCap = .round
        self.layer.addSublayer(objectLayer)
        
        nextCircleLayer.strokeColor =  colors[1]
        nextCircleLayer.fillColor = UIColor.clear.cgColor
        nextCircleLayer.strokeStart = 0
        nextCircleLayer.strokeEnd = 0
        nextCircleLayer.path = circularPath.cgPath
        nextCircleLayer.lineWidth = arcWidth * 0.8
        nextCircleLayer.lineCap = .round
        self.layer.addSublayer(nextCircleLayer)
        
    }
    
    func animate(for endArcNew : CGFloat) {
        
        animationShape = CABasicAnimation(keyPath: "strokeEnd")
        animationShape.duration = 0.5
        animationShape.fromValue = endArcPrevious
        animationShape.toValue = endArcNew
        animationShape.fillMode = .both
        animationShape.isRemovedOnCompletion = false
        shapeLayer.add(animationShape, forKey: "animateprogress")
        
        //анимация положения летающего шарика
        let startAnimation = CABasicAnimation(keyPath: "strokeStart")
        startAnimation.fromValue = endArcPrevious - 0.001
        startAnimation.toValue = endArcNew - 0.001
        
        let endAnimation = CABasicAnimation(keyPath: "strokeEnd")
        endAnimation.fromValue = endArcPrevious
        endAnimation.toValue = endArcNew
        
        let animations = CAAnimationGroup()
        animations.animations = [startAnimation, endAnimation]
        animations.duration = 0.5
        animations.fillMode = .both
        animations.isRemovedOnCompletion = false
        
        objectLayer.add(animations, forKey: nil)
        
        if endArcNew >= 0.99 {
            backCircleLayer.isOpaque = false
            nextCircleLayer.isHidden = false
        } else {
            backCircleLayer.isOpaque = true
            nextCircleLayer.isHidden = true
        }
        let animationNext = CABasicAnimation(keyPath: "strokeEnd")
        animationNext.duration = 0.5
        animationNext.fromValue = endArcPrevious - 1
        animationNext.toValue = endArcNew - 1
        animationNext.fillMode = .both
        animationNext.isRemovedOnCompletion = false
        nextCircleLayer.add(animationNext, forKey: nil)
        
        self.endArcPrevious = endArcNew

    }
}
