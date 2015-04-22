//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by gjwang on 4/19/15.
//  Copyright (c) 2015 gjwang. All rights reserved.
//

import UIKit

class DiagnosedHappinessViewController: HappinessViewController, UIPopoverPresentationControllerDelegate {
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
        }
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var diagnosticHistory: [Int] {
        get{
            return defaults.objectForKey(History.DefaultsKey) as? [Int] ?? []
        }
        
        set {
            defaults.setObject(newValue, forKey: History.DefaultsKey)
            
        }
    }
    
    private struct History {
        static let SeguesIdentifier = "Show Disgnostic History"
        static let DefaultsKey = "DiagnosedHappinessViewController.History"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier =  segue.identifier {
            switch identifier {
            case History.SeguesIdentifier:
                if let tvc = segue.destinationViewController as? TextViewController {
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    tvc.text = "\(diagnosticHistory)"
                    
                }
            default: break
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
