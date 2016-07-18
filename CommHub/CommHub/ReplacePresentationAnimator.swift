//
//  ReplacePresentationAnimator.swift
//  Example
//
//  Created by Andrew Dzhur on 08/07/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation
import Cocoa

class ReplacePresentationAnimator: NSObject, NSViewControllerPresentationAnimator {
    func animatePresentationOfViewController(viewController: NSViewController, fromViewController: NSViewController) {
        if let window = fromViewController.view.window {
            NSAnimationContext.runAnimationGroup({ (context) -> Void in
                fromViewController.view.animator().alphaValue = 0
                }, completionHandler: { () -> Void in
                    viewController.view.alphaValue = 0

                    viewController.view.frame = fromViewController.view.frame
                    
                    window.contentViewController = viewController
                    viewController.view.animator().alphaValue = 1.0
            })
        }
    }
    
    func animateDismissalOfViewController(viewController: NSViewController, fromViewController: NSViewController) {
        if let window = viewController.view.window {
            NSAnimationContext.runAnimationGroup({ (context) -> Void in
                viewController.view.animator().alphaValue = 0
                }, completionHandler: { () -> Void in
                    fromViewController.view.alphaValue = 0
                    
                    fromViewController.view.frame = viewController.view.frame
                    
                    window.contentViewController = fromViewController
                    fromViewController.view.animator().alphaValue = 1.0
            })
        }
    }
}