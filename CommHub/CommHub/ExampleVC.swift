//
//  ExampleVC.swift
//  CommHub
//
//  Created by Andrew Dzhur on 16/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class ExampleVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let subview = AdminCardViewController(nibName: "AdminCard", bundle: nil)!
        subview.view.frame = NSRect(x: 0, y: 0, width: 297, height: 500)
        subview.setCard(nil, title: "Add the administrator", deleteButtonHide: true)
        
        self.view.addSubview(subview.view)
    }
    
}
