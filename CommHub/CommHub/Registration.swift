//
//  RegistrationViewController.swift
//  CommHub
//
//  Created by Andrew Dzhur on 03/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Cocoa

class Registration: NSViewController {

    @IBOutlet var titleLabel: NSTextField!
    @IBOutlet var phoneNumberTextField: NSTextField!
    @IBOutlet var continueButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.init(hexString: "245082").CGColor
        //self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.backgroundColor = NSColor.init(hexString: "245082")
        
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    /*
    func textField(textField: NSTextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (textField == phoneNumberTextField) {
            let newString = (textField.stringValue as NSString).stringByReplacingCharactersInRange(range, withString: string)
            let components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            let decimalString = components.joinWithSeparator("") as NSString
            let length = decimalString.length
            let hasLeadingOne = length > 0 && decimalString.characterAtIndex(0) == (1 as unichar)
            
            if countryCodeTextField.stringValue != "" {
                continueButton.enabled = length > 9
            }
            
            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11 {
                let newLength = (textField.stringValue as NSString).length + (string as NSString).length - range.length as Int
                
                return (newLength > 10) ? false : true
            }
            var index = 0 as Int
            let formattedString = NSMutableString()
            
            if hasLeadingOne {
                formattedString.appendString("1 ")
                index += 1
            }
            
            if (length - index) > 3 {
                let areaCode = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("(%@) ", areaCode)
                index += 3
            }
            
            if length - index > 3 {
                let prefix = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }
            
            if length == 10 {
                let prefix = decimalString.substringWithRange(NSMakeRange(index, 2))
                formattedString.appendFormat("%@-", prefix)
                index += 2
            }
            
            let remainder = decimalString.substringFromIndex(index)
            formattedString.appendString(remainder)
            textField.stringValue = formattedString as String
            return false
        } else {
            return true
        }
    }
 */
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        (segue as! RegistrationSegue).transitionEffect = .SlideLeft

        let destinationViewController = segue.destinationController as! ConfirmCode
        let phone = phoneNumberTextField.stringValue.removePunctMarks()
        SessionData().wsSessionReqSave(phone) { (reqres, successful) in
            if successful {
                destinationViewController.requestCode = reqres
                destinationViewController.phoneNumberTextField.stringValue = self.phoneNumberTextField.stringValue
            }
        }
    }
}
