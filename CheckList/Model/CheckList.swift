//
//  CheckList.swift
//  CheckList
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 Rayan Mehdi. All rights reserved.
//

import Foundation


class CheckList : Codable
{
    //MARK: - Properties
    
    var name : String?
    var items : Array<CheckListItem> = []
    
    //MARK: - Life cycle
    init(name: String, items: Array<CheckListItem>? = []) {
        self.name = name
        self.items = items!
    }
    
}

extension CheckList: Equatable
{
    static func ==(lhs: CheckList, rhs: CheckList) -> Bool {
        return (lhs.name == rhs.name)
    }
    
}
