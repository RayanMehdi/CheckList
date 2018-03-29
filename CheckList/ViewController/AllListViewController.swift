//
//  AllListViewController.swift
//  CheckList
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 Rayan Mehdi. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {
    
    var lists : Array<CheckList> = []

   
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
    
    func saveChecklists(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(lists)
        
        try? data?.write(to: dataFileUrl)
    }
    
    func loadCheckLists()
    {
        let decoder = JSONDecoder()
        let data = try? Data.init(contentsOf: self.dataFileUrl, options: .alwaysMapped)
        if data != nil{
        lists = try! decoder.decode(Array<CheckList>.self, from: data!)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
     /*   let test1 = CheckList(name: "test1",items: Array<CheckListItem>())
        let test2 = CheckList(name: "test2",items: Array<CheckListItem>())
        let test3 = CheckList(name: "test3",items: Array<CheckListItem>())
        let test4 = CheckList(name: "test4",items: Array<CheckListItem>())
        lists.append(test1)
        lists.append(test2)
        lists.append(test3)
        lists.append(test4)
        for list in lists{
            list.items.append(CheckListItem(text: "Items for " + list.name!))
        }*/
        loadCheckLists()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckList", for: indexPath)
        cell.textLabel?.text = lists[indexPath.row].name
        
        return cell
    }
  
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailList" {
            let destination = segue.destination as! CheckListViewController
            let text = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: text)
            destination.list = lists[(indexPath?.row)!]
        }
        if segue.identifier == "addCheckList" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! ListDetailViewController
            targetController.delegate = self
            
        }
        
        if segue.identifier == "editCheckList"{
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! ListDetailViewController
            targetController.delegate = self
            let tv = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: tv)
            targetController.itemToEdit = lists[(indexPath?.row)!]
            
        }
    }
}

extension AllListViewController: ListDetailViewControllerDelegate
{
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: CheckList) {
        lists.append(item)
        item.items.append(CheckListItem(text:"Items for " + item.name!))
        
        let indexPath:IndexPath = IndexPath(row:(self.lists.count - 1), section:0)
        
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        saveChecklists()
        
        dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: CheckList) {
        let index = lists.index(where:{ $0 == item })
        lists[index!].name = item.name
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckList", for: IndexPath(row: index!, section: 0))
        cell.textLabel?.text = item.name
        //configureText(for: cell, withItem: items[index!])
        saveChecklists()
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}

