//
//  Preferences.swift
//  CheckList
//
//  Created by iem on 27/04/2018.
//  Copyright © 2018 Rayan Mehdi. All rights reserved.
//

import Foundation
class Preferences {
    
    let defaults = UserDefaults.standard
    
    //MARK : - Singleton
    static let sharedInstance = Preferences()
    private init() {}
    
    func nextCheckListId()->Int{
            defaults.set(defaults.integer(forKey: "checkListItemID")+1 , forKey: "checkListItemID")
            return defaults.integer(forKey: "checkListItemID")
    }
}
