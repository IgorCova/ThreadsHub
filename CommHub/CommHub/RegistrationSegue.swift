//
//  RegistrationSegue.swift
//  CommHub
//
//  Created by Andrew Dzhur on 09/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class RegistrationSegue: NSStoryboardSegue {
    var transitionEffect: NSViewControllerTransitionOptions = .None
    
    // make references to the source controller and destination controller
    override init(identifier: String?, source sourceController: AnyObject, destination destinationController: AnyObject) {
        var myIdentifier : String
        myIdentifier = identifier ?? ""

        super.init(identifier: myIdentifier, source: sourceController, destination: destinationController)
    }
    
    override func perform() {
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
        containerViewController.transitionFromViewController(sourceViewController, toViewController: destinationViewController, options: transitionEffect, completionHandler: nil)
            
        //resize view controllers
        sourceViewController.view.animator().setFrameSize(targetSize)
        destinationViewController.view.animator().setFrameSize(targetSize)
        
        //resize and shift window
        let currentFrame = containerViewController.view.window?.frame
        let currentRect = NSRectToCGRect(currentFrame!)
        let horizontalChange = (targetWidth - containerViewController.view.frame.size.width)/2
        let verticalChange = (targetHeight - containerViewController.view.frame.size.height)
        
        let newWindowRect = NSMakeRect(currentRect.origin.x - horizontalChange, currentRect.origin.y - verticalChange,targetWidth, targetHeight+22)
        
        containerViewController.view.window?.setFrame(newWindowRect, display: true, animate: true)
            
        // lose the sourceViewController, it's no longer visible
        containerViewController.removeChildViewControllerAtIndex(0)
            
    }
}
