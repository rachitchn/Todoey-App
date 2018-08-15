//
//  ViewController.swift
//  Todoey
//
//  Created by Rachit Chauhan on 06/08/18.
//  Copyright © 2018 Rachit Chauhan. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    




    override func viewDidLoad() {
        super.viewDidLoad()
        
            print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
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
    
    
//    context.delete(itemArray[indexPath.row])                  // Delete from Database, make sure of the order of calling the function
//    itemArray.remove(at: indexPath.row)
    
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
    self.saveItems()
    
    tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)  // creating alert
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
        let newItem = Item(context: self.context)             // Implementing Core Data
        newItem.title = textField.text!
        newItem.done = false
            
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
    
    func saveItems() {                                            // Saving data to database

        do {
            try context.save()
        } catch {
            print("Error saving Context \(error)")
        }
        self.tableView.reloadData()
    }
    
    
     func loadItems() {                                             // Reading data from DB
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
             itemArray = try context.fetch(request)
            
        } catch  {
            
            print("Error fetching data from context \(error)")
        }
        
    
    }



}

