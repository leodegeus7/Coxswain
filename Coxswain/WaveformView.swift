//
//  WaveformView.swift
//  WaveformView
//
//  Created by Leonardo Geus on 25/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Darwin

let pi = Double.pi

@IBDesignable
public class WaveformView: UIView {
    fileprivate var _phase: CGFloat = 0.0
    fileprivate var _amplitude: CGFloat = 0.3
    
    @IBInspectable public var waveColor: UIColor = .black
    @IBInspectable public var numberOfWaves = 5
    @IBInspectable public var primaryWaveLineWidth: CGFloat = 3.0
    @IBInspectable public var secondaryWaveLineWidth: CGFloat = 1.0
    @IBInspectable public var idleAmplitude: CGFloat = 0.01
    @IBInspectable public var frequency: CGFloat = 1.25
    @IBInspectable public var density: CGFloat = 5
    @IBInspectable public var phaseShift: CGFloat = -0.15
    
    @IBInspectable public var amplitude: CGFloat {
        get {
            return _amplitude
        }
    }
    
    public func updateWithLevel(_ level: CGFloat) {
        _phase += phaseShift
        _amplitude = fmax(level, idleAmplitude)
        setNeedsDisplay()
    }
    
    override public func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        context.clear(bounds)
        backgroundColor?.set()
        context.fill(rect)
        
        for waveNumber in 0...numberOfWaves {
            context.setLineWidth((waveNumber == 0 ? primaryWaveLineWidth : secondaryWaveLineWidth))
            
            let halfHeight = bounds.height / 2.0
            let width = bounds.width
            let mid = width / 2.0
            let maxAmplitude = halfHeight - 4.0
            let progress: CGFloat = 1.0 - CGFloat(waveNumber) / CGFloat(numberOfWaves)
            let normedAmplitude = (1.5 * progress - 0.5) * amplitude
            let multiplier: CGFloat = 1.0
            waveColor.withAlphaComponent(multiplier * waveColor.cgColor.alpha).set()
            var x: CGFloat = 0.0
            while x < width + density {
                let scaling = -pow(1 / mid * (x - mid), 2) + 1
                let tempCasting: CGFloat = 2.0 * CGFloat(pi) * CGFloat(x / width) * frequency + _phase
                let y = scaling * maxAmplitude * normedAmplitude * CGFloat(sinf(Float(tempCasting))) + halfHeight
                if x == 0 {
                    context.move(to: CGPoint(x: x, y: y))
                } else {
                    context.addLine(to: CGPoint(x: x, y: y))
                }
                x += density
            }
            
            context.strokePath()
        }
    }
}
