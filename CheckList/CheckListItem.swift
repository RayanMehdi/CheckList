//
//  CheckListItem.swift
//  CheckList
//
//  Created by iem on 07/03/2018.
//  Copyright © 2018 Rayan Mehdi. All rights reserved.
//

import Foundation

class CheckListItem {
    
    var title: String
    var checked: Bool = false
    
    init(text: String) {
        self.title=text
        
    }
    
    init(text: String, checked: Bool) {
        self.title = text
        self.checked = checked
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
