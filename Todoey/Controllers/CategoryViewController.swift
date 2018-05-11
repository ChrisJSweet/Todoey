//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Chris Sweet on 9/5/18.
//  Copyright © 2018 Rita Sweet. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    // the context lets us communicate with the persistent container
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

                loadCategories()
    }

    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a reusable cell and add it to the table at the index path
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
//        let category = categoryArray[indexPath.row]
//
//        cell.textLabel?.text = category.name
        // -or- put another way
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods when we click on a cell
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "goToItems", sender: self)
    }
            
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                
                let destinationVC = segue.destination as! TodoListViewController
              
                // find out which category the user selected before running the segue
                // var selectedCategory was defined in the TodoListViewController
                
                if let indexPath = tableView.indexPathForSelectedRow {
                    destinationVC.selectedCategory = categoryArray[indexPath.row]
                    
                }
            
    }
    //
    //        //      print(itemArray[indexPath.row])
    //
    //        //        context.delete(itemArray[indexPath.row])
    //        //        itemArray.remove(at: indexPath.row)
    //
    //        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    //
    //        saveItems()
    //
    //        tableView.deselectRow(at: indexPath, animated: true)
    
    
    //Mark: - Data Manipulation Methods  Save and Load
    
    func saveCategory() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
   
    // 'with' is the internal parameter. 'request:' is the external parameter
    // '= Item.fetchRequest' is the value used if not parameter is supplied
    
    // this is a global fetch which gets all the categories
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error loading Categories from context \(error)")
        }
        
        tableView.reloadData()
    }
    
    // End of Main Class
    //MARK: - Add New Categories - Add button pressed
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField ()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            
            self.saveCategory()
            
        }

        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
//        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
}
