//
//  ViewController.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 9/30/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import RealmSwift
import UIKit

class HomeViewController: UIViewController {
    
    // PROPERTIES
    
    // Database
    let realm = try! Realm()
    var tags: Results<Tag>?
    var activeActivities: Results<Activity>?
    var archivedActivities: Results<Activity>?
    
    var tagPickerData = [String]()
    var reportTypePickerData = [String]()

    // Views
    @IBOutlet weak var tagPicker: UIPickerView!
    @IBOutlet weak var activityTableView: UITableView!
    @IBOutlet weak var reportTypePicker: UIPickerView!
    
    var isShowingArchived: Bool = false
    
    // MARK: - VIEW CONTROLLER METHODS
    
    override func loadView() {
        super.loadView()
        
        // Load data
        loadTags()
        loadReportTypeArray()
        //createSampleActivities()
        loadActivities()
        
        // Setup navigation bar
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
        
        // Setup UIPickerViews
        tagPicker.delegate = self
        tagPicker.dataSource = self
        tagPicker.translatesAutoresizingMaskIntoConstraints = false
        
        reportTypePicker.delegate = self
        reportTypePicker.dataSource = self
        reportTypePicker.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup TableView
        activityTableView.delegate = self
        activityTableView.dataSource = self
        activityTableView.register(ActivityCell.self, forCellReuseIdentifier: "ActivityCell")
        activityTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        activityTableView.separatorStyle = .singleLine
        activityTableView.rowHeight = 75
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // continue tableview setup
        if let indexPath = activityTableView.indexPathForSelectedRow {
            activityTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // continue pickerview setup
        tagPicker.selectRow(tagPickerData.count - 1, inComponent: 0, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        print("Creating new activity tracker")
    }
    
    // MARK: - MODEL METHODS
    
    // MARK: TAG METHODS
    
    func loadTags() {
        tagPickerData = ["Morning","Exercise","Nutrition","All Activities"]
    }
    
    // MARK: REPORT TYPE METHODS
    
    func loadReportTypeArray() {
        reportTypePickerData = ["Default","Count","Change","Streak","Days Passed"]
    }
    
    // MARK: ENTRY METHODS
    
    // insert func to load all Entries / get data for report labels

    // Create New Entry
    @objc func createEntry(sender: UIButton) {
        if let activity = activeActivities?[sender.tag].name {
            print("creating entry for \(activity)!")
            
            if let currentActivity = self.activeActivities?[sender.tag] {
                do {
                    try self.realm.write {
                        let newEntry = Entry()
                        newEntry.value = 1
                        newEntry.timestamp = Date()
                        currentActivity.entries.append(newEntry)
                    }
                } catch {
                    print("Error saving new entry, \(error)")
                }
            }
        }
    }
    
    // insert func to delete an Entry
    
    // MARK: ACTIVITY METHODS
    
    func loadActivities() {
        activeActivities = realm.objects(Activity.self).filter("isArchived == false")
        archivedActivities = realm.objects(Activity.self).filter("isArchived == true")
    }
    
    // Create Sample Activities
    func createSampleActivities() {
        let tag1 = Tag()
        tag1.name = "Daily"
        let tag2 = Tag()
        tag2.name = "Exercise"
        let tag3 = Tag()
        tag3.name = "Nutrition"
        
        // save activity method
        func save(activity: Activity) {
            do {
                try realm.write {
                    realm.add(activity)
                }
            } catch {
                print("Error saving context: \(error)")
            }
        }

        // create sample activities
        var activity = Activity()
        activity.name = "Go to gym"
        activity.tags.append(objectsIn: [tag1,tag2])
        activity.entryTypeEnum = .checkbox
        save(activity: activity)

        activity = Activity()
        activity.name = "Floss teeth"
        activity.entryTypeEnum = .checkbox
        save(activity: activity)

        activity = Activity()
        activity.name = "Eat veggies"
        activity.tags.append(objectsIn: [tag2, tag3])
        activity.entryTypeEnum = .plusOneCounter
        save(activity: activity)
        
        activity = Activity()
        activity.name = "Beer counter"
        activity.entryTypeEnum = .plusOneCounter
        save(activity: activity)
        
        activity = Activity()
        activity.name = "Read"
        activity.tags.append(tag3)
        activity.entryTypeEnum = .yesNo
        save(activity: activity)
        
        activity = Activity()
        activity.name = "Do 20,000 Pushups"
        activity.tags.append(tag2)
        activity.entryTypeEnum = .keypad
        activity.isArchived = false
        save(activity: activity)
        
        activity = Activity()
        activity.name = "Avoid Cigarettes"
        activity.tags.append(tag1)
        activity.entryTypeEnum = .yesNo
        activity.isArchived = false
        save(activity: activity)
    }
    
    // insert func to sort activityArray
    
    // insert func to get report labels for a given activity
    
    // insert func to get tags for a give activity
    
    // MARK: - Navigation Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // change back button to say cancel when navigating to EditActivityTableviewController
        if segue.identifier == "addActivity" {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        }
    }
    
    // Go to Activity Screen
    @objc func goToDetails(of activity: Activity) {
        let vc = ActivityTableViewController()
        vc.selectedActivity = activity
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - TABLEVIEW

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    // Populate TableView Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        
        if indexPath.section == 0 {
            cell.activityName = activeActivities?[indexPath.row].name ?? "No name"
            cell.tags = activeActivities?[indexPath.row].tags
            cell.entryType = activeActivities?[indexPath.row].entryTypeEnum
            cell.actionButton.tag = indexPath.row
            cell.report0 = "Today: 0"
            cell.report1 = "7 days: 4"
            cell.report2 = "30 days: 19"
        } else {
            if isShowingArchived {
                cell.activityName = archivedActivities?[indexPath.row].name ?? "No name"
                cell.tags = archivedActivities?[indexPath.row].tags
                cell.actionButton.isEnabled = false
            } else {
                let placeholderCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                placeholderCell.textLabel?.attributedText = NSAttributedString(string: "show archived activities", attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)])
                return placeholderCell
            }
        }
        
        cell.layoutSubviews()
        return cell
    }
    
    // Title of Section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return isShowingArchived ? "Archived" : " "
        } else {
            return nil
        }
    }
    
    // Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Number of rows in a given section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return activeActivities?.count ?? 0
        } else {
            return isShowingArchived ? archivedActivities?.count ?? 0 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            if isShowingArchived {
                return 60
            } else {
                return 30
            }
        }
        
        return 0
    }
}

// MARK: - PICKERVIEW METHODS

extension HomeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Method to get user selection
    func pickerView(_ picker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if picker.tag == tagPicker.tag {
            print(tagPickerData[row])
        } else {
            print(reportTypePickerData[row])
        }
    }
    
    // MARK: Format Picker Views

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = UILabel()
        
        if let currentLabel = view as? UILabel {
            pickerLabel = currentLabel
        } else {
            // Color code the non-default picker view options
            let hue = CGFloat(row)/CGFloat(tagPickerData.count)
            var fontColor = UIColor.black
            if (pickerView.tag == tagPicker.tag && row != tagPickerData.count - 1) {
                fontColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            }
            let fontAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline), NSAttributedString.Key.foregroundColor: fontColor]
            pickerLabel.textAlignment = .left
            if pickerView.tag == tagPicker.tag {
                pickerLabel.attributedText = NSAttributedString(string: "  " + tagPickerData[row], attributes: fontAttributes)
            } else {
                pickerLabel.attributedText = NSAttributedString(string: "  " + reportTypePickerData[row], attributes: fontAttributes)
            }
        
            // remove the selection indication lines from the picker view
            pickerView.subviews[1].isHidden = true
            pickerView.subviews[2].isHidden = true
        }
        
        return pickerLabel
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == tagPicker.tag {
            return tagPickerData.count
        } else {
            return reportTypePickerData.count
        }
    }
    
    // Set Row Height of Pickers
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 27
    }
    
    // Set Column Width by PickerView and Component
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        if pickerView.tag == reportTypePicker.tag {
//            if component == 0 {
//                return self.view.frame.width / 3
//            } else {
//                return self.view.frame.width / 3 * 2
//            }
//        } else {
//            return self.view.frame.width
//        }
//    }
}

