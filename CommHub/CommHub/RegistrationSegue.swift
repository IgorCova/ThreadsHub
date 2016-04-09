//
//  RegistrationSegue.swift
//  CommHub
//
//  Created by Andrew Dzhur on 09/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

import Cocoa

class RegistrationSegue: NSStoryboardSegue {
    
    // make references to the source controller and destination controller
    override init(identifier: String?, source sourceController: AnyObject, destination destinationController: AnyObject) {
        var myIdentifier : String
        myIdentifier = identifier ?? ""

        super.init(identifier: myIdentifier, source: sourceController, destination: destinationController)
    }
    
    
    override func perform() {
        if self.identifier == "SendPhoneNumber" {
            // build from-to and parent-child view controller relationships
            let sourceViewController  = self.sourceController as! Registration
            let destinationViewController = self.destinationController as! ConfirmCode
            let containerViewController = sourceViewController.parentViewController! as NSViewController
            
            // add destinationViewController as child
            containerViewController.insertChildViewController(destinationViewController, atIndex: 1)
            
            // get the size of destinationViewController
            let targetSize = destinationViewController.view.frame.size
            let targetWidth = destinationViewController.view.frame.size.width
            let targetHeight = destinationViewController.view.frame.size.height
            
            // prepare for animation
            sourceViewController.view.wantsLayer = true
            destinationViewController.view.wantsLayer = true
            
            let phone = sourceViewController.phoneNumberTextField.stringValue.removePunctMarks()
            SessionData().wsSessionReqSave(phone) { (reqres, successful) in
                if successful {
                    destinationViewController.requestCode = reqres
                    destinationViewController.phoneNumberTextField.stringValue = sourceViewController.phoneNumberTextField.stringValue
                }
            }
            
            //perform transition
            containerViewController.transitionFromViewController(sourceViewController, toViewController: destinationViewController, options: NSViewControllerTransitionOptions.Crossfade, completionHandler: nil)
            
            //resize view controllers
            sourceViewController.view.animator().setFrameSize(targetSize)
            destinationViewController.view.animator().setFrameSize(targetSize)
            
            //resize and shift window
            let currentFrame = containerViewController.view.window?.frame
            let currentRect = NSRectToCGRect(currentFrame!)
            let horizontalChange = (targetWidth - containerViewController.view.frame.size.width)/2
            let verticalChange = (targetHeight - containerViewController.view.frame.size.height)/2
            let newWindowRect = NSMakeRect(currentRect.origin.x - horizontalChange, currentRect.origin.y - verticalChange, targetWidth, targetHeight)
            containerViewController.view.window?.setFrame(newWindowRect, display: true, animate: true)
            
            // lose the sourceViewController, it's no longer visible
            containerViewController.removeChildViewControllerAtIndex(0)
            
        } else {
            
            // build from-to and parent-child view controller relationships
            let sourceViewController  = self.sourceController as! NSViewController
            let destinationViewController = self.destinationController as! NSViewController
            let containerViewController = sourceViewController.parentViewController! as NSViewController
            
            // add destinationViewController as child
            containerViewController.insertChildViewController(destinationViewController, atIndex: 1)
            
            // get the size of destinationViewController
            let targetSize = destinationViewController.view.frame.size
            let targetWidth = destinationViewController.view.frame.size.width
            let targetHeight = destinationViewController.view.frame.size.height
            
            // prepare for animation
            sourceViewController.view.wantsLayer = true
            destinationViewController.view.wantsLayer = true
            
            //perform transition
            containerViewController.transitionFromViewController(sourceViewController, toViewController: destinationViewController, options: NSViewControllerTransitionOptions.Crossfade, completionHandler: nil)
            
            //resize view controllers
            sourceViewController.view.animator().setFrameSize(targetSize)
            destinationViewController.view.animator().setFrameSize(targetSize)
            
            //resize and shift window
            let currentFrame = containerViewController.view.window?.frame
            let currentRect = NSRectToCGRect(currentFrame!)
            let horizontalChange = (targetWidth - containerViewController.view.frame.size.width)/2
            let verticalChange = (targetHeight - containerViewController.view.frame.size.height)/2
            let newWindowRect = NSMakeRect(currentRect.origin.x - horizontalChange, currentRect.origin.y - verticalChange, targetWidth, targetHeight)
            containerViewController.view.window?.setFrame(newWindowRect, display: true, animate: true)
            
            // lose the sourceViewController, it's no longer visible
            containerViewController.removeChildViewControllerAtIndex(0)
        }
    
    }
}
