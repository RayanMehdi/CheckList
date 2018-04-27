//
//  CheckListItem.swift
//  CheckList
//
//  Created by iem on 07/03/2018.
//  Copyright © 2018 Rayan Mehdi. All rights reserved.
//

import Foundation

class CheckListItem: Codable {
    
    var title: String
    var checked: Bool = false
    var dueDate = Date()
    var itemId: Int?
    var shouldRemind: Bool = false
    
    init(text: String) {
        self.title=text
        
    }
    
    init(text: String, checked: Bool) {
        self.title = text
        self.checked = checked
    }
    
    init(text: String, checked: Bool, shouldRemind:Bool, dueDate:Date) {
        self.title = text
        self.checked = checked
        self.shouldRemind = shouldRemind
        self.dueDate = dueDate
        self.itemId = Preferences.sharedInstance.nextCheckListId()
    }
    
    
    func toggleChecked()
    {
        self.checked = !self.checked
    }
    
}


extension CheckListItem: Equatable
{
    static func ==(lhs: CheckListItem, rhs: CheckListItem) -> Bool {
        return (lhs.title == rhs.title)
    }
    
}
