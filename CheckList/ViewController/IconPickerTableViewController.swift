//
//  IconPickerTableViewController.swift
//  CheckList
//
//  Created by iem on 05/04/2018.
//  Copyright © 2018 Rayan Mehdi. All rights reserved.
//

import UIKit

class IconPickerTableViewController: UITableViewController {
    
    var delegate: IconPickerTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return IconAsset.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconAssetCell", for: indexPath)
        cell.imageView?.image = IconAsset.allValues[indexPath.row].image
        cell.textLabel?.text = IconAsset.allValues[indexPath.row].rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.iconPickerTableViewController(self, didChooseIcon: IconAsset.allValues[indexPath.row])
    }

 

}

protocol IconPickerTableViewControllerDelegate : class {
    func iconPickerTableViewControllerDidCancel(_ controller: IconPickerTableViewController)
    func iconPickerTableViewController(_ controller: IconPickerTableViewController, didChooseIcon icon: IconAsset)
}

