//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Chris Sweet on 9/5/18.
//  Copyright © 2018 Rita Sweet. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a reusable cell and add it to the table at the index path
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        //        let category = categories[indexPath.row]
        //
        //        cell.textLabel?.text = category.name
        // -or- put another way
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        
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
            destinationVC.selectedCategory = categories?[indexPath.row]
            
        }
    }
    
    //Mark: - Data Manipulation Methods  Save and Load
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    // 'with' is the internal parameter. 'request:' is the external parameter
    // '= Item.fetchRequest' is the value used if not parameter is supplied
    
    // this is a global fetch which gets all the categories
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    // End of Main Class
    //MARK: - Add New Categories - Add button pressed
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField ()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
        
    }
}
