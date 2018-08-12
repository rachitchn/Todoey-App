//
//  ViewController.swift
//  Todoey
//
//  Created by Rachit Chauhan on 06/08/18.
//  Copyright © 2018 Rachit Chauhan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggs"
        itemArray.append(newItem2)

        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {       // used to show the locally saved data

            itemArray = items
        }
        
    }



   // Table View Data sources methods(how the cell will be displayed)
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title

        
        cell.accessoryType = item.done ? .checkmark : .none            // ternary operator

        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else {
//            cell.accessoryType = .none
//        }
        
        
        return cell
        
    }

    //Tabelview delegate methods

override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
    
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
    tableView.reloadData()
    
    tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)  // creating alert
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
        let newItem = Item()
        newItem.title = textField.text!
            
        self.itemArray.append(newItem)                       // adding newly added item in array
            
        self.defaults.set(self.itemArray, forKey: "ToDoListArray")
                    
        self.tableView.reloadData()                     // reloading view to dislpay the added item

        }
        
        alert.addTextField { (alertTextField) in                   //creating an alert box
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

