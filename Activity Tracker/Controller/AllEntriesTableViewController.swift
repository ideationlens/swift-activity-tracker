//
//  AllEntriesTableViewController.swift
//  Activity Tracker
//
//  Created by CHRISTOPHER KIM on 10/31/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//
import RealmSwift
import UIKit

class AllEntriesTableViewController: UITableViewController {

    
    // PROPERTIES
    
    // Database
    let realm = try! Realm()
    var tags: Results<Tag>!
    var activeActivities: Results<Activity>!
    var archivedActivities: Results<Activity>!
    
    var reportTypePickerData = [String]()


    // Views

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
     
    */

    
    
    // MARK: - NAVIGATION
    
    // Configure Nav Bar
    
    func configureNavBar() {
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
    
    }

    
}

// MARK: - TABLEVIEW

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Configure Table View
    func configureTableView() {
        activityTableView.delegate = self
        activityTableView.dataSource = self
        activityTableView.register(ActivityCell.self, forCellReuseIdentifier: "ActivityCell")
        activityTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        activityTableView.separatorStyle = .singleLine
        activityTableView.rowHeight = 75
    }
    
    // Cell Selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && !isShowingArchived {
            isShowingArchived = !isShowingArchived
            activityTableView.reloadData()
        } else {
            if indexPath.section == 0 {
                if let activity = activeActivities?[indexPath.row] {
                    goToDetails(of: activity)
                }
            } else {
                if let activity = archivedActivities?[indexPath.row] {
                    goToDetails(of: activity)
                }
            }
        }
}
}
