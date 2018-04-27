//
//  DataModel.swift
//  CheckList
//
//  Created by iem on 05/04/2018.
//  Copyright © 2018 Rayan Mehdi. All rights reserved.
//

import Foundation
class DataModel {
    
    //MARK : - Singleton
    static let sharedInstance = DataModel()
    private init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(saveChecklists),
            name: .UIApplicationDidEnterBackground,
            object: nil)
        Preferences.sharedInstance.defaults.register(defaults: ["firstLaunch" : true])
        Preferences.sharedInstance.defaults.register(defaults: ["checkListItemID" : 0])
    }
    
    //MARK: - Properties
    
    var lists = [CheckList]()
    
    
    
    var documentsDirectory: URL
    {
        get{
            return FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
        }
    }
    
    var dataFileUrl: URL
    {
        get{
            var url: URL = documentsDirectory.absoluteURL
            url.appendPathComponent("CheckLists")
            url.appendPathExtension("json")
            return url       }
        set{
            self.dataFileUrl = newValue
        }
    }
    
    //MARK: - Methods
    @objc func saveChecklists(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(lists)
        
        try? data?.write(to: dataFileUrl)
    }
    
    func loadCheckLists()
    {
        if Preferences.sharedInstance.defaults.bool(forKey: "firstLaunch"){
            var items = [CheckListItem]()
            items.append(CheckListItem(text: "Edit your first item, Swipe me to delete", checked: false))
            lists.append(CheckList(name: "List", items: items))
            Preferences.sharedInstance.defaults.set(false, forKey: "firstLaunch")
        }else{
        let decoder = JSONDecoder()
        let data = try? Data.init(contentsOf: self.dataFileUrl, options: .alwaysMapped)
        if data != nil{
            lists = try! decoder.decode([CheckList].self, from: data!)
            }
        }
    }
    
    func sortCheckLists()
    {
        lists.sort { (checklist1, checklist2) -> Bool in
            checklist1.name?.lowercased().localizedStandardCompare(checklist2.name!.lowercased()) == .orderedAscending
        }
    }

}
