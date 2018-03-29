//
//  ViewController.swift
//  CheckList
//
//  Created by iem on 01/03/2018.
//  Copyright © 2018 Rayan Mehdi. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {

    //MARK: - properies
    
    var items: Array<CheckListItem> = []
    var list : CheckList!
    
    
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
            url.appendPathComponent("CheckList")
            url.appendPathExtension("json")
            return url       }
        set{
            self.dataFileUrl = newValue
        }
    }
    
    //MARK: - life cycle
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        //loadCheckListItems()
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
        //loadCheckListItems()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = list.name
        for item in list.items{
            items.append(item)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Methods
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: CheckListItem)
    {
        let myCell = cell as! ChecklistItemTableViewCell
        myCell.checkmarkLabel.isHidden = !item.checked
      //  saveChecklistItems()
        
        
    }
    func configureText(for cell: UITableViewCell, withItem item: CheckListItem)
    {
        let myCell = cell as! ChecklistItemTableViewCell
         myCell.titleLabel?.text = item.title
    }
    
  
    
   
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! ItemDetailViewController
            targetController.delegate = self
            
        }
        
        if segue.identifier == "editItem"{
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! ItemDetailViewController
            targetController.delegate = self
            let tv = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: tv)
            targetController.itemToEdit = items[(indexPath?.row)!]
            
        }
    }
    
    
    //MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        configureText(for: cell, withItem: items[indexPath.row])
        configureCheckmark(for: cell, withItem: items[indexPath.row])
        
        return cell
    }
    
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        items[indexPath.row].toggleChecked()
        configureCheckmark(for: cell, withItem: items[indexPath.row])
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        //saveChecklistItems()
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }


}

extension CheckListViewController: ItemDetailViewControllerDelegate
{
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: CheckListItem) {
        items.append(item)
        
        let indexPath:IndexPath = IndexPath(row:(self.items.count - 1), section:0)
        
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        
        //saveChecklistItems()

        
        dismiss(animated: true, completion: nil)
        
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: CheckListItem) {
        let index = items.index(where:{ $0 == item })
        items[index!].title = item.title
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: IndexPath(row: index!, section: 0))
        configureText(for: cell, withItem: items[index!])
       // saveChecklistItems()
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

    
    
}





