//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Rachit Chauhan on 18/08/18.
//  Copyright © 2018 Rachit Chauhan. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        loadCategories()

    }
    
    
    //MARK : - TableView Datasource Method
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let categoryy = categoryArray[indexPath.row]
        
        cell.textLabel?.text = categoryy.name
        
        return cell
        
    }
    //MARK : TAbleview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }

    
    //MARK : - Add new categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)  // creating alert
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)             // Implementing Core Data
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)                       // adding newly added item in array
            
          self.saveCategory()
        
        
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
    
    func saveCategory() {                                            // Saving data to database
        
        do {
            try context.save()
        } catch {
            print("Error saving Category \(error)")
        }
        self.tableView.reloadData()
        
    }
    
    func loadCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()) {                                     // Reading data from DB
        
        
        do {
            categoryArray = try context.fetch(request)
            
        } catch  {
            
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
        
    }

}
