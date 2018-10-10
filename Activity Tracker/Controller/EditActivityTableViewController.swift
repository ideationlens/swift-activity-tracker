//
//  EditActivityTableViewController.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/7/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import RealmSwift
import UIKit

class EditActivityTableViewController: UITableViewController {
    
    // PROPERTIES
    let realm = try! Realm()
    
    // Activity
    var activity: Activity?
    
    // Name
    var activityName = "" {
        didSet {
            print(activityName)
        }
    }
    
    // Recurrence Setting
    var recurrenceSetting = RecurrenceType.immediately
    let recurrenceStrings: [RecurrenceType: String] = [.daily: "Resets Daily", .immediately: "Resets Immediately"]
    let recurrenceSwitch: [RecurrenceType: Bool] = [.daily: true, .immediately: false]
    let recurrenceValues: [Bool: RecurrenceType] = [true: .daily, false: .immediately]
    
    
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
        
        // Initialize Properties
        setupLocalProperties()
        
        // Setup TextField
    }
    
    // MARK: - DATA METHODS
    
    func setupLocalProperties() {
        if let currentActivity = activity {
            activityName = currentActivity.name
            recurrenceSetting = currentActivity.recurrenceTypeEnum
        }
    }
    
    // Save Activity
    func saveActivity() {
        // save changes
        if let currentActivity = self.activity {
            do {
                try self.realm.write {
                    currentActivity.name = activityName
                    currentActivity.recurrenceTypeEnum = recurrenceSetting
                }
            } catch {
                print("Error saving activity, \(error)")
            }
        } else {
        // or create new
            do {
                try self.realm.write {
                    let newActivity = Activity()
                    newActivity.name = activityName
                    newActivity.recurrenceTypeEnum = recurrenceSetting
                    realm.add(newActivity)
                }
            } catch {
                print("Error creating new activity, \(error)")
            }
        }
    }

    // MARK: - EVENT METHODS
    
    // user switched a setting
    @IBAction func settingSwitched(sender: UISwitch) {
        print("changing settings for button \(sender.tag) to \(sender.isOn)")
        switch sender.tag {
        case 1:
            recurrenceSetting = recurrenceValues[sender.isOn]!
            self.tableView.reloadData()
        default:
            print("unrecognized switch")
        }
    }
    
    // MARK: - TABLEVIEW DATA SOURCE

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // return custom cell dependent on indexPath
        switch indexPath.row {
        case 0:
            let cell = TextEntryCell()
            cell.title = "Name"
            cell.entryField.text = activityName
            cell.entryField.delegate = self
            cell.tag = 0
            cell.layoutSubviews()
            return cell
            
        case 1:
            let cell = SwitchCell()
            cell.name = recurrenceStrings[recurrenceSetting]
            cell.settingSwitch.tag = indexPath.row
            cell.isSwitchOn = recurrenceSetting == .daily ? true : false  //recurrenceSwitch[recurrenceSetting]!
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

    // MARK: - Navigation

    @objc func donePressed() {
        // save activity
       saveActivity()

        // dismiss
       _ = navigationController?.popViewController(animated: true)
    }
}

extension EditActivityTableViewController: UITextFieldDelegate {
    
    // fetch text from UI text fields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nsString = textField.text as NSString?
        let newString = nsString?.replacingCharacters(in: range, with: string)
        
        if let text = newString {
            activityName = text
        }
        
        return true
    }   
}
