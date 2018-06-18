//
//  ViewController.swift
//  ToDoList
//
//  Created by Love Bhardwaj on 2018-06-16.
//  Copyright © 2018 Love Bhardwaj. All rights reserved.
//

import UIKit

class ToDoListViewController : UITableViewController {
    var itemArray = ["Cook", "Bath", "Wash"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Load the data from the stored array
        //The stored array may not always exists
        if let items = defaults.array(forKey: "toDolistArray") as! [String] //Cast this as array of strings.
        {
            itemArray = items
        }
    }
    
    //MARK: Tableview data source methods.

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK: Tableview delegate methods.
    //This method get fired whenever we click a cell in the tableveiw.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add new items.
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //When the user pressed the add item.
        //Make a UI alert button popup that has an text input.
        //So the user can add and item to the list.
        
        var textField = UITextField() //Initilize a text field.
        let addAlert = UIAlertController(title: "Add new item.", message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add item", style: .default) { (action) in
            //What will happen once the user click add button.
            //This is called when the button is pressed.
            if let text = textField.text {
                self.itemArray.append(text)
            }
            
            self.tableView.reloadData()
            self.defaults.setValue(self.itemArray, forKey: "toDoListArray")
        }
        addAlert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add item"
            textField = alertTextField
        }
        
        
        addAlert.addAction(alertAction)
        present(addAlert, animated: true, completion: nil)
    }
    
}

