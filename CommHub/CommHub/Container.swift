//
//  ContainerViewController.swift
//  CommHub
//
//  Created by Andrew Dzhur on 09/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa
import AppKit

class ContainerViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.needsLayout = true
        let mainStoryboard: NSStoryboard = NSStoryboard(name: "Main", bundle: nil)
        let sourceViewController = mainStoryboard.instantiateControllerWithIdentifier("RegistrationViewController") as! Registration
        self.insertChildViewController(sourceViewController, atIndex: 0)
        self.view.addSubview(sourceViewController.view)
        self.view.frame = sourceViewController.view.frame

    }
    
    

}
