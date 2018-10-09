//
//  EditActivityTableViewController.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/7/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import UIKit

class EditActivityTableViewController: UITableViewController {
    
    // PROPERTIES
    
    // Activity
    var activity: Activity?
    
    // Name
    var activityName = String()
    
    // Recurrence Setting
    let recurrenceStrings: [RecurrenceType: String] = [.daily: "Resets Daily", .immediately: "Resets Immediately"]
    let recurrenceSwitch: [RecurrenceType: Bool] = [.daily: true, .immediately: false]
    let recurrenceValue: [Bool: RecurrenceType] = [true: .daily, false: .immediately]
    
    
    // MARK: - VIEW CONTROLLER METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup navigation bar items
        if activity == nil {
            title = "Add Activity"
        } else {
            title = "Edit Activity"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        
        
        
        loadActivity()
        
        
//        self.tableView.
//        self.tableView.rowHeight = 60
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - DATA METHODS
    
    func loadActivity() {
        if activity == nil {
            activity = Activity()
            activity?.name = "Go to Gym"
            activity?.recurrenceTypeEnum = .immediately
        }
    }
    
    func saveChanges() {
        guard let nameCell = tableView(self.tableView, cellForRowAt: IndexPath(row: 0, section: 1)) as? TextEntryCell else {fatalError()}
        print("name of activity is... \(nameCell.entry)")
        activity?.name = nameCell.entry     }

    // MARK: - EVENT METHODS
    
    // user switched a setting
    @IBAction func settingSwitched(sender: UISwitch) {
        print("changing settings for button \(sender.tag) to \(sender.isOn)")
        switch sender.tag {
        case 1:
            activity?.recurrenceTypeEnum = recurrenceValue[sender.isOn]!
            saveChanges()
            self.tableView.reloadData()
        default:
            print("unrecognized switch")
        }
    }
    
    // MARK: - TABLEVIEW METHODS

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // return custom cell dependent on indexPath
        switch indexPath.row {
        case 0:
            let cell = TextEntryCell()
            cell.title = "Name"
            if let name = activity?.name {
                cell.entryField.text = name
            }
            cell.layoutSubviews()
            return cell
            
        case 1:
            let cell = SwitchCell()
            cell.name = recurrenceStrings[activity?.recurrenceTypeEnum ?? .daily]
            cell.settingSwitch.tag = indexPath.row
            cell.isSwitchOn = recurrenceSwitch[activity?.recurrenceTypeEnum ?? .daily]!
            cell.layoutSubviews()
            return cell
            
        default:
            let cell = SwitchCell()
            cell.name = "Resets Daily"
            cell.settingSwitch.tag = indexPath.row
            cell.isSwitchOn = true
            cell.layoutSubviews()
            return cell
        }
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

    
    // MARK: - Navigation

    @objc func donePressed() {
        // save activity
        // dismiss 
    }
 

}
