//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Rachit Chauhan on 18/08/18.
//  Copyright © 2018 Rachit Chauhan. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        loadCategories()

    }
    
    
    //MARK : - TableView Datasource Method
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added Yet"
        
        return cell
        
    }
    //MARK : TAbleview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }

    
    //MARK : - Add new categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)  // creating alert
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()             // Adding Category
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
        
        
    }
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in                   //creating an alert box
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
        
    
    
    
    //MARK : - Data Manupudlation Methods
    
    

        }
    
    func save(category: Category) {                                            // Saving data to database
        
        do {
            try realm.write {
                realm .add(category)
            }
        } catch {
            print("Error saving Category \(error)")
        }
        self.tableView.reloadData()
        
    }
    
    func loadCategories() {                              // Reading data from DB
        
        categories = realm.objects(Category.self)       // Pull out items from Realm of Category Object
        
        
        tableView.reloadData()
        
    }
    

}


