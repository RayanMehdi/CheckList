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
    
    var list : CheckList!
    
    
    
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
            targetController.itemToEdit = list.items[(indexPath?.row)!]
            
        }
    }
    
    
    //MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.items.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        configureText(for: cell, withItem: list.items[indexPath.row])
        configureCheckmark(for: cell, withItem: list.items[indexPath.row])
        
        return cell
    }
    
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        list.items[indexPath.row].toggleChecked()
        configureCheckmark(for: cell, withItem: list.items[indexPath.row])
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        list.items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }


}

extension CheckListViewController: ItemDetailViewControllerDelegate
{
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: CheckListItem) {
        list.items.append(item)
        
        let indexPath:IndexPath = IndexPath(row:(self.list.items.count - 1), section:0)
        
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        


        
        dismiss(animated: true, completion: nil)
        
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: CheckListItem) {
        let index = list.items.index(where:{ $0 == item })
        list.items[index!].title = item.title
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: IndexPath(row: index!, section: 0))
        configureText(for: cell, withItem: list.items[index!])

        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

    
    
}





