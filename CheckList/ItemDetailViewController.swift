//
//  AddItemTableViewController.swift
//  CheckList
//
//  Created by iem on 07/03/2018.
//  Copyright © 2018 Rayan Mehdi. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    
    var delegate: ItemDetailViewControllerDelegate?
    
    var itemToEdit: CheckListItem?
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit{
            self.navigationItem.title = "Edit Item"
            self.titleTextField.text = item.title
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleTextField.becomeFirstResponder()
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    
    //MARK: - Actions

    @IBAction func cancelAction() {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func textfieldEditing(_ textField: UITextField) {
        self.navigationItem.rightBarButtonItem?.isEnabled = !(textField.text!.isEmpty)
    }
    
    @IBAction func doneAction() {
        if let item = itemToEdit{
            item.title = titleTextField.text!
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
        }else{
            delegate?.itemDetailViewController(self, didFinishAddingItem: CheckListItem.init(text: titleTextField.text!))
        }

        
    }
    

    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            //    let oldString = textField.text!
            //   let newString = oldString.replacingCharacters(in: Range(range, in:oldString)!, with: string)
            //   self.doneBarButtonItem.isEnabled = !newString.isEmpty
        return true
    }
    
}


protocol ItemDetailViewControllerDelegate : class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: CheckListItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: CheckListItem)
}


