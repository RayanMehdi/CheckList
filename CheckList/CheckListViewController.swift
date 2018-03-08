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
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        items.append(CheckListItem.init(text: "Task 1"))
        items.append(CheckListItem.init(text: "Task 2", checked:true))
        items.append(CheckListItem.init(text: "Task 3"))
        items.append(CheckListItem.init(text: "Task 5", checked:true))
        items.append(CheckListItem.init(text: "Task 6"))
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
        
        
    }
    func configureText(for cell: UITableViewCell, withItem item: CheckListItem)
    {
        let myCell = cell as! ChecklistItemTableViewCell
         myCell.titleLabel?.text = item.title
    }
    
    
  /*  @IBAction func addDummyToDo(_ sender: Any) {
        items.append(CheckListItem.init(text: "New Task"))
        self.tableView.beginUpdates()
        
        let indexPath:IndexPath = IndexPath(row:(self.items.count - 1), section:0)
        
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        
        self.tableView.endUpdates()
    }*/
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! AddItemTableViewController
            targetController.delegate = self
            
        }
        
        if segue.identifier == "editItem"{
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! AddItemTableViewController
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
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }


}

extension CheckListViewController: AddItemViewControllerDelegate
{
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAddingItem item: CheckListItem) {
        items.append(item)
        self.tableView.beginUpdates()
        
        let indexPath:IndexPath = IndexPath(row:(self.items.count - 1), section:0)
        
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        
        self.tableView.endUpdates()
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func addItemViewController(_ controller: AddItemTableViewController, didFinishEditingItem item: CheckListItem) {
       let index = items.index(where:{ $0 == item })
        items[index!].title = item.title
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: IndexPath(row: index!, section: 0))
        configureText(for: cell, withItem: items[index!])
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

    
    
}





