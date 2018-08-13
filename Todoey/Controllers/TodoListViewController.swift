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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")



    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
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
    
    self.saveItems()
    
    tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)  // creating alert
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
        let newItem = Item()
        newItem.title = textField.text!
            
        self.itemArray.append(newItem)                       // adding newly added item in array
            
        
        self.saveItems()

        }
        
        alert.addTextField { (alertTextField) in                   //creating an alert box
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {                                            //Saving data using NSCoder
        let encoder = PropertyListEncoder()

        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding Item Array,\(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
       if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {  itemArray = try decoder.decode([Item].self, from: data)
               } catch {
                print("Error decoding Item Array,\(error)")
               }

        }
        
    }
    


}

