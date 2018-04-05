//
//  ListDetailViewController.swift
//  CheckList
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 Rayan Mehdi. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController, UITextFieldDelegate {

    var delegate: ListDetailViewControllerDelegate?
    
    var itemToEdit: CheckList?
    
    var iconAsset: IconAsset = .Folder
    
    
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit{
            self.navigationItem.title = "Edit CheckList"
            self.titleTextField.text = item.name
        }
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleTextField.becomeFirstResponder()
        if let item = itemToEdit {
            iconLabel.text = item.icon.rawValue
            iconImageView.image = item.icon.image
        }else{
            iconLabel.text = iconAsset.rawValue
            iconImageView.image = iconAsset.image
        }
        
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    
    //MARK: - Actions
    
    @IBAction func cancelAction() {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @IBAction func textfieldEditing(_ textField: UITextField) {
        self.navigationItem.rightBarButtonItem?.isEnabled = !(textField.text!.isEmpty)
    }
    
    @IBAction func doneAction() {
        if let item = itemToEdit{
            item.name = titleTextField.text!
            delegate?.listDetailViewController(self, didFinishEditingItem: item)
        }else{
            delegate?.listDetailViewController(self, didFinishAddingItem: CheckList(name: titleTextField.text!, items: [CheckListItem](), iconAsset: iconAsset))
        }
        
        
    }
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //    let oldString = textField.text!
        //   let newString = oldString.replacingCharacters(in: Range(range, in:oldString)!, with: string)
        //   self.doneBarButtonItem.isEnabled = !newString.isEmpty
        return true
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showImagePicker" {
                let destination = segue.destination as! IconPickerTableViewController
                
                destination.delegate = self
            }
    }
    
}


protocol ListDetailViewControllerDelegate : class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: CheckList)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: CheckList)
}

extension ListDetailViewController: IconPickerTableViewControllerDelegate
{
    
    func iconPickerTableViewControllerDidCancel(_ controller: IconPickerTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func iconPickerTableViewController(_ controller: IconPickerTableViewController, didChooseIcon icon: IconAsset) {
        if let item = itemToEdit {
            item.icon = icon
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }else{
        self.iconAsset = icon
        }
        navigationController?.popViewController(animated: true)
    }
    
    
}

