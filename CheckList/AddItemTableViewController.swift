//
//  AddItemTableViewController.swift
//  CheckList
//
//  Created by iem on 07/03/2018.
//  Copyright © 2018 Rayan Mehdi. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController, UITextFieldDelegate {
    
    
    var delegate: AddItemViewControllerDelegate?
    
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
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func textfieldEditing(_ textField: UITextField) {
        self.navigationItem.rightBarButtonItem?.isEnabled = !(textField.text!.isEmpty)
    }
    
    @IBAction func doneAction() {
        if let item = itemToEdit{
            item.title = titleTextField.text!
            delegate?.addItemViewController(self, didFinishEditingItem: item)
        }else{
            delegate?.addItemViewController(self, didFinishAddingItem: CheckListItem.init(text: titleTextField.text!))
        }

        
    }
    

    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            //    let oldString = textField.text!
            //   let newString = oldString.replacingCharacters(in: Range(range, in:oldString)!, with: string)
            //   self.doneBarButtonItem.isEnabled = !newString.isEmpty
        return true
    }
    
}


protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController)
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAddingItem item: CheckListItem)
    func addItemViewController(_ controller: AddItemTableViewController, didFinishEditingItem item: CheckListItem)
}


