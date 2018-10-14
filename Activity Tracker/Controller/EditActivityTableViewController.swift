//
//  EditActivityTableViewController.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/7/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import RealmSwift
import UIKit

class EditActivityTableViewController: UITableViewController, ReceiveEntryType, ReceiveReportType {
    
    // PROPERTIES
    let realm = try! Realm()
    
    // Activity
    var activity: Activity!
    
    // Name
    var activityName = ""
    
    // Entry Type
    var entryType = EntryType.checkbox {
        didSet {
            print("entryType set to \(reportType)")
        }
    }
    
    // Report Type
    var reportType = ReportType.count {
        didSet {
            print("reportType set to \(reportType)")
        }
    }
    
    // Recurrence Setting
    var recurrenceSetting = RecurrenceType.immediately
    let recurrenceStrings: [RecurrenceType: String] = [.daily: "Resets Daily", .immediately: "Resets Immediately"]
    let recurrenceSwitch: [RecurrenceType: Bool] = [.daily: true, .immediately: false]
    let recurrenceValues: [Bool: RecurrenceType] = [true: .daily, false: .immediately]
    
    // Is Archived
    var isArchived = false
    
    // PROTOCOLS
    
    // Set Entry Type from EntryTypeTableViewController
    func setEntryType(to entryType: EntryType) {
        self.entryType = entryType
        self.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
    }
    
    // Set Report Type from ReportTypeTableViewController
    func setReportType(to reportType: ReportType) {
        self.reportType = reportType
        self.tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .automatic)
    }
    
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
            entryType = currentActivity.entryTypeEnum
            recurrenceSetting = currentActivity.recurrenceTypeEnum
            reportType = currentActivity.reportTypeEnum
            isArchived = currentActivity.isArchived
        } else {
            activity = Activity()
            activity.name = "New Activity"
            activity.entryTypeEnum = entryType
            activity.recurrenceTypeEnum = recurrenceSetting
            activity.reportTypeEnum = reportType
            activity.isArchived = false
        }
    }
    
    // Save Activity
    func saveActivity() {
        // save changes
        if activity?.name != "New Activity" {
            do {
                try self.realm.write {
                    activity.name = activityName
                    activity.entryTypeEnum = entryType
                    activity.recurrenceTypeEnum = recurrenceSetting
                    activity.reportTypeEnum = reportType
                    activity.isArchived = isArchived
                }
            } catch {
                print("Error saving activity, \(error)")
            }
        } else {
        // or create new
            do {
                try self.realm.write {
                    activity.name = activityName
                    activity.entryTypeEnum = entryType
                    activity.recurrenceTypeEnum = recurrenceSetting
                    activity.reportTypeEnum = reportType
                    activity.isArchived = isArchived
                    realm.add(activity!)
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
        case 2:
            recurrenceSetting = recurrenceValues[sender.isOn]!
            self.tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .fade)
        case 4:
            isArchived = !isArchived
            self.tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .fade)
        default:
            print("unrecognized switch")
        }
    }
    
    // MARK: - TABLE VIEW
    
    // MARK: TABLE VIEW DELEGATE
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            goToEntryTypeTableViewController()
        case 3:
            goToReportTypeTableViewController()
        default:
            print("user selected row \(indexPath.row)")
        }
    }
    
    // MARK: TABLE VIEW DATA SOURCE

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // return custom cell dependent on indexPath
        switch indexPath.row {
            
        case 0:
            // name
            let cell = TextEntryCell()
            cell.title = "Name"
            cell.entryField.text = activityName
            cell.entryField.delegate = self
            cell.tag = 0
            //cell.heightAnchor.constraint(equalToConstant: 100).isActive = true
            cell.layoutSubviews()
            return cell
            
        case 1:
            // entry type
            let cell = DisclosureCell()
            cell.title = "Entry Type"
            cell.detail = "\(entryType)"
            cell.layoutSubviews()
            return cell
            
        case 2:
            // recurrence
            let cell = SwitchCell()
            cell.title = recurrenceStrings[recurrenceSetting]
            cell.settingSwitch.tag = 2
            cell.settingSwitch.addTarget(self, action: #selector(settingSwitched(sender:)), for: .touchUpInside)
            cell.isSwitchOn = recurrenceSwitch[recurrenceSetting]!
            cell.layoutSubviews()
            return cell
            
        case 3:
            // report type
            let cell = DisclosureCell()
            cell.title = "Report"
            cell.tag = 2
            cell.detail = ReportType.string[reportType]
            cell.layoutSubviews()
            return cell
            
        case 4:
            // is archived
            let cell = SwitchCell()
            cell.title = isArchived ? "Activity is archived" : "Activity is not archived"
            cell.settingSwitch.tag = 4
            cell.settingSwitch.addTarget(self, action: #selector(settingSwitched(sender:)), for: .touchUpInside)
            cell.isSwitchOn = isArchived
            cell.layoutSubviews()
            return cell
            
        default:
            let cell = SwitchCell()
            cell.title = "Resets Daily"
            cell.settingSwitch.tag = indexPath.row
            cell.isSwitchOn = true
            cell.layoutSubviews()
            return cell
        }
    }

    // MARK: - Navigation

    // Done pressed
    @objc func donePressed() {
        // save activity
       saveActivity()

        // dismiss
       _ = navigationController?.popViewController(animated: true)
    }
    
    // Go to Entry Type
    func goToEntryTypeTableViewController() {
        let vc = EntryTypeTableViewController()
        vc.selectedActivity = activity
        vc.entryType = entryType
        vc.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Go to Report Type Table View Controller
    func goToReportTypeTableViewController() {
        let vc = ReportTypeTableViewController()
        vc.selectedActivity = activity
        vc.entryType = entryType
        vc.reportType = reportType
        vc.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
        navigationController?.pushViewController(vc, animated: true)
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
