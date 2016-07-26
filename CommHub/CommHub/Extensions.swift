//
//  ColoursLayers.swift
//  CommHub
//
//  Created by Andrew Dzhur on 13/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation
import AppKit

extension NSColor {
    
    convenience init(hexString: String) {
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

enum ReportType {
    case OK
    case VK
    case Project
}

internal let HubService = "http://commhub.org/CommHubService.svc"
internal var MyDID = NSUUID().UUIDString
internal var reportType = ReportType.VK
internal var MySessionID : String {
    
    get {
        return OwnerHubData().getLogInfo().1
    }
}

internal var MyOwnerHubID : Int {
    get {
        return OwnerHubData().getLogInfo().0
    }
}

extension NSImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                if error == nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.image = NSImage(data: data!)
                        
                    }
                }
            }
            task.resume()
        }
    }
}

extension NSButton {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                if error == nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.image = NSImage(data: data!)
                        
                    }
                }
            }
            task.resume()
        }
    }
}

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.stringByReplacingOccurrencesOfString(string, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    func removePunctMarks() -> String {
        var text = self
        text = text.replace("+", replacement: "")
        text = text.replace("-", replacement: "")
        text = text.replace(" ", replacement: "")
        text = text.replace(")", replacement: "")
        text = text.replace("(", replacement: "")
        
        return text
    }
}

extension Int {
    public func divByBits() -> String {
        let rev = "\(abs(self))".reverse()
        var diving = ""
        var cnt = rev.characters.count
        
        var b = 0
        var e = 2
        
        while cnt > 3 {
            diving = "\(diving)\(rev[b...e]) "
            b += 3
            e += 3
            cnt = cnt - 3
        }
        
        if (cnt <= 3) {
            diving = "\(diving) \(rev[rev.characters.count-cnt...rev.characters.count-1]) "
        }
        
        return "\(self < 0 ? "-" : "")\(diving.reverse())"
    }
}

extension String {
    public func reverse() -> String {
        var rev = ""
        for w in self.characters {
            rev = "\(w)\(rev)"
        }
        
        return rev
    }
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript(integerRange: Range<Int>) -> String {
        let start = startIndex.advancedBy(integerRange.startIndex)
        let end = startIndex.advancedBy(integerRange.endIndex)
        let range = start..<end
        return self[range]
    }
}

enum dateType: String {
    case day = "Day"
    case yesterday = "Yesterday"
    case week = "Week"
}

enum activityType: String {
    case likes = "Likes"
    case comments = "Comments"
    case share = "Reshare"
    case removed = "Removed"
    case members = "Members join"
    case membersLost = "Members lost"
}