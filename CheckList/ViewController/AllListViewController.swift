//
//  AllListViewController.swift
//  CheckList
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 Rayan Mehdi. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DataModel.sharedInstance.loadCheckLists()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DataModel.sharedInstance.sortCheckLists()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return DataModel.sharedInstance.lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckList", for: indexPath)
        cell.textLabel?.text = DataModel.sharedInstance.lists[indexPath.row].name
        switch (DataModel.sharedInstance.lists[indexPath.row].uncheckedItemCount, DataModel.sharedInstance.lists[indexPath.row].items.count) {
        case(_,0):
            cell.detailTextLabel?.text = "No Items"
        case(0,_):
            cell.detailTextLabel?.text = "All Done !"
        default:
            cell.detailTextLabel?.text = "Items Left :\(DataModel.sharedInstance.lists[indexPath.row].uncheckedItemCount)"
        }
        cell.imageView?.image = DataModel.sharedInstance.lists[indexPath.row].icon.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        DataModel.sharedInstance.lists.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailList" {
            let destination = segue.destination as! CheckListViewController
            let text = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: text)
            destination.list = DataModel.sharedInstance.lists[(indexPath?.row)!]
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
            targetController.itemToEdit = DataModel.sharedInstance.lists[(indexPath?.row)!]
            
        }
    }
}

extension AllListViewController: ListDetailViewControllerDelegate
{
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: CheckList) {
        DataModel.sharedInstance.lists.append(item)
   
        let indexPath:IndexPath = IndexPath(row:(DataModel.sharedInstance.lists.count - 1), section:0)
        
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        
        dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: CheckList) {
        let index = DataModel.sharedInstance.lists.index(where:{ $0 == item })
        DataModel.sharedInstance.lists[index!].name = item.name
        DataModel.sharedInstance.lists[index!].icon = item.icon
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckList", for: IndexPath(row: index!, section: 0))
        cell.textLabel?.text = item.name
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

}


