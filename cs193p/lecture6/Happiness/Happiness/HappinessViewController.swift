//
//  HappinessViewController.swift
//  Happiness
//
//  Created by gjwang on 4/15/15.
//  Copyright (c) 2015 gjwang. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
    var happiness: Int = 25 { // 0 = very sad, 100 = ecstatic
        didSet{
            happiness = min(max(happiness, 0), 100)
            println("happiness = \(happiness)")
            updateUI()
        }
    }

    private struct Constants {
        static let HappinessGuestureScale: CGFloat  = 4
    }
   
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGuestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default:
            break
        }
        
        
    }
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            println("faceView didSet")
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
            //faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: "changedHappiness:"))
        }
    }

    func updateUI() {
        faceView.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50
    }
}
