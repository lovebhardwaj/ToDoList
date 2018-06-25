//
//  ViewController.swift
//  ToDoList
//
//  Created by Love Bhardwaj on 2018-06-16.
//  Copyright © 2018 Love Bhardwaj. All rights reserved.
//

import UIKit

class ToDoListViewController : UITableViewController {
    var itemArray = [Item]() //Array of type item
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //User domain mask is user default folder and we will save our data here
    //Creates a new path to the plist
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Load the data from the stored array
        //The stored array may not always exists

        
        loadItemsFromPlist()

    }
    
    //MARK: Tableview data source methods.

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let newItem = itemArray[indexPath.row]
        
        cell.textLabel?.text = newItem.title //This will return an Item object and we get the title
        
        cell.accessoryType = newItem.done ? .checkmark : .none
    
        
        return cell
    }
    
    //MARK: Tableview delegate methods.
    //This method get fired whenever we click a cell in the tableveiw.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        let newItem = itemArray[indexPath.row]
        
        newItem.done = !newItem.done
        
        saveDataToPlist()
        
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
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveDataToPlist()
        }
        addAlert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add item"
            textField = alertTextField
        }
        
        
        addAlert.addAction(alertAction)
        present(addAlert, animated: true, completion: nil)
    }
    
    func saveDataToPlist(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }catch{
            print("An exception occured.")
        }
        self.tableView.reloadData()
    }
    
    func loadItemsFromPlist(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
            self.itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Exception occurred.")
            }
        }
    }
    
}

