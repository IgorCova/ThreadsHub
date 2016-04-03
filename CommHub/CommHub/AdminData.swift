//
//  Admin\Data.swift
//  CommHub
//
//  Created by Andrew Dzhur on 03/04/16.
//  Copyright © 2016 Andrew Dzhur. All rights reserved.
//

import Foundation

class AdminData {
    func getAdmins() -> [Admin] {
        var adminArr = [Admin]()
        adminArr.append(Admin(id: 1, firstName: "Andrew", secondName: "Dzhur", profileImage: nil, phoneNumber: "79264308272", link: "https://vk.com/im?peers=124279072_290972794_c116_c117_c146"))

        
        return adminArr
    }
}