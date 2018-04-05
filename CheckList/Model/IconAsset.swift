//
//  IconAsset.swift
//  CheckList
//
//  Created by iem on 05/04/2018.
//  Copyright © 2018 Rayan Mehdi. All rights reserved.
//

import Foundation
import UIKit

enum IconAsset : String, Codable {
    case Appointments
    case Birthdays
    case Chores
    case Drinks
    case Folder
    case Groceries
    case Inbox
    case NoIcon = "No Icon"
    case Photos
    case Trips
    
    static let allValues = [Appointments,Birthdays, Chores, Drinks, Folder, Groceries, Inbox, NoIcon, Photos, Trips]
    
    
    static var count: Int { return allValues.count}
    
    var image : UIImage {
        return UIImage(named: self.rawValue)!
    }
} 
