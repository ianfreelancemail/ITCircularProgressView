//
//  CircularProgressView.swift
//  ITCircularProgressView
//
//  Created by Ian Talisic on 07/11/2020.
//

import Foundation
import UIKit

class CircularProgressView: UIView {
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var textLayer = CATextLayer()
    private var previousPercentage: CGFloat = 0
    
    var percentage: CGFloat = 0 {
        willSet {
            previousPercentage = percentage
        }
        didSet {
            let duration = previousPercentage < percentage ? CFTimeInterval((percentage - previousPercentage) / 100.0) : CFTimeInterval(previousPercentage - percentage) / 100.0
            progressAnimation(duration: CFTimeInterval(duration))
        }
    }
    
    
    var font: UIFont = UIFont.boldSystemFont(ofSize: 30) {
        didSet {
            textLayer.font = font
        }
    }
    
    var textColor: UIColor = .black {
        didSet {
            textLayer.foregroundColor = textColor.cgColor
        }
    }
    
    var isProgressHidden: Bool = false {
        didSet{
            textLayer.isHidden = isProgressHidden
        }
    }
    
    var lineWidth: CGFloat = 20
    var progressColor: UIColor = UIColor.systemBlue
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
    }
    
    
    private func createCircularPath(){
        textLayer.font = font
        textLayer.foregroundColor = textColor.cgColor
        textLayer.alignmentMode = .center
        textLayer.frame = CGRect(x: 0, y: (font.pointSize + 10) / 2 * -1 - 5, width: self.bounds.width, height: font.pointSize + 10)
        textLayer.string = "0%"
        layer.addSublayer(textLayer)
        
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.bounds.midX, y: self.bounds.minY), radius: self.bounds.midX, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = lineWidth
        circleLayer.strokeColor = progressColor.withAlphaComponent(0.3).cgColor
        layer.addSublayer(circleLayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeColor = progressColor.cgColor
        layer.addSublayer(progressLayer)
    }
    
    func progressAnimation(duration: CFTimeInterval){
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.fromValue = previousPercentage / 100.0
        circularProgressAnimation.toValue = percentage / 100.0
        circularProgressAnimation.fillMode = .both
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        textLayer.string = "\(Int(percentage))%"
        
        if let value = circularProgressAnimation.toValue as? Int, value == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + circularProgressAnimation.duration) {
                self.progressLayer.removeAnimation(forKey: "progressAnim")
            }
        }
    }
}
