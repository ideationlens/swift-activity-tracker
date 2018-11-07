//
//  TagTableViewController.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 11/1/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import RealmSwift
import UIKit

protocol ReceiveTags {
    func setTags(to tags: List<Tag>)
}

class TagTableViewController: UITableViewController {

    // PROPERTIES
    let realm = try! Realm()
    var activity: Activity!
    var tags: Results<Tag>!
    var allTagNames = [String]()
    var activityTagNames = [String]()
    var delegate: ReceiveTags?
    
    // MARK: - VIEW CONTROLLER METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Tags"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    
        // Initialize Properties
        setupLocalProperties()
        
    }
    
    // MARK: - Realm Methods
    func setupLocalProperties() {
        tags = realm.objects(Tag.self)
        for tag in tags {
            allTagNames.append(tag.name)
        }
        for tag in activity.tags {
            activityTagNames.append(tag.name)
        }
    }
    
    // MARK: - UI METHODS
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Tag", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Tag", style: .default) { (action) in
            do {
                try self.realm.write {
                    let newTag = Tag()
                    newTag.name = textField.text!
                    self.activity.tags.append(newTag)
                    self.allTagNames.append(newTag.name)
                }
            } catch {
                print("Error saving new tag, \(error)")
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new tag"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DisclosureCell()
        cell.title = allTagNames[indexPath.row]
        if activityTagNames.contains(allTagNames[indexPath.row]) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
