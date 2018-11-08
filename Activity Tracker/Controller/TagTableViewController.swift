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
    
    // Load Tags
    func setupLocalProperties() {
        tags = realm.objects(Tag.self)
        for tag in tags {
            allTagNames.append(tag.name)
        }
        print("getting activity tags")
        for tag in activity.tags {
            activityTagNames.append(tag.name)
            print(tag.name)
        }
    }
    
    // Create New Tag
    func addActivityTag(name: String) {
        do {
            try self.realm.write {
                let newTag = Tag()
                newTag.name = name
                self.activity.tags.append(newTag)
                self.allTagNames.append(newTag.name)
            }
        } catch {
            print("Error saving new tag, \(error)")
        }
        
        tableView.reloadData()
    }
    
    // Delete Tag from Realm and all Activity Trackers
    
    // Add Existing Tag to Activity
    func updateActivity(withTag tag: Tag) {
        activityTagNames.append(tag.name)
        
        do {
            try self.realm.write {
                activity.tags.append(tag)
            }
        } catch {
            print("Error removing tag, \(error)")
        }
        
        tableView.reloadData()
    }
    
    // Remove Tag from Activity
    func removeActivityTag(index: Int) {
        activityTagNames.remove(at: index)
        
        do {
            try self.realm.write {
                activity.tags.remove(at: index)
            }
        } catch {
            print("Error removing tag, \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    // MARK: - UI METHODS
    // Add Button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Tag", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add Tag", style: .default) { (action) in
            self.addActivityTag(name: textField.text!)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Tag name"
            textField = alertTextField
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    // MARK: - TABLE VIEW
    // func configureTableView() {}
    
    // MARK: TABLE VIEW DELEGATE METHODS
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if activityTagNames.contains(allTagNames[indexPath.row]) {
            for n in 0...activityTagNames.count - 1 {
                if activityTagNames[n] == allTagNames[indexPath.row] {
                    removeActivityTag(index: n)
                }
            }
        } else {
            updateActivity(withTag: tags[indexPath.row])
        }
    }
    
    // MARK: TABLE VIEW DATA SOURCE

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

        return cell
    }
 
    // MARK: - Navigation

}
