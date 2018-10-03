//
//  ViewController.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 9/30/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // Tag Picker
    @IBOutlet weak var tagPicker: UIPickerView!
    var tagPickerData: [String]!
    
    // Report Type Picker
    @IBOutlet weak var reportTypePicker: UIPickerView!
    var reportTypePickerData: [String]!
    
    // Table View
    @IBOutlet weak var activityTableView: UITableView!
    var activityArray: [ActivityCell]!
    var archiveArray: [ActivityCell]!
    var isShowingArchived: Bool = false
    
    override func loadView() {
        super.loadView()
        
        // refresh all model arrays
        loadTagArray()
        loadReportTypeArray()
        //loadActivityEntryArray()
        //loadArchiveEntryArray()
        loadActivityArray()
        loadArchiveArray()
        
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
//        activityTableView.autoresizingMask = .flexibleHeight
//        activityTableView.estimatedRowHeight = 120

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
    
    func loadTagArray() {
        tagPickerData = ["Morning","Exercise","Nutrition","All Activities"]
    }
    
    // MARK: REPORT TYPE METHODS
    
    func loadReportTypeArray() {
        reportTypePickerData = ["Default","Count","Change","Streak","Days Passed"]
    }
    
    // MARK: ENTRY METHODS
    
    // Activity Entry
    // insert func to create a new Entry
    
    // Archive Entry
    // insert func to refresh entryArray
    
    // MARK: ACTIVITY METHODS
    
    // Activity
    func loadActivityArray() {
        let tag1 = Tag(name: "Daily")
        let tag2 = Tag(name: "Exercise")
        let tag3 = Tag(name: "Nutrition")
        var cell = ActivityCell()
        activityArray = [ActivityCell]()
        
        cell.activityName = "Go to gym"
        cell.tags = [tag1,tag2]
        cell.report0 = "Today: 0"
        cell.report1 = "This Week: 2"
        cell.report2 = "This month: 10"
        cell.entryType = .checkbox
        cell.actionButton.tag = 0
        activityArray.append(cell)
        
        cell = ActivityCell()
        cell.activityName = "Eat Veggies"
        cell.tags = [tag1,tag3]
        cell.report0 = "Today: 0"
        cell.report1 = "This Week: 2"
        cell.report2 = "This month: 10"
        cell.entryType = .keypad
        cell.actionButton.tag = 1
        activityArray.append(cell)

        cell = ActivityCell()
        cell.activityName = "Work and eat at the farm"
        cell.tags = [tag2, tag3]
        cell.report0 = "Today: 0"
        cell.report1 = "This Week: 2"
        cell.report2 = "This month: 10"
        cell.entryType = .plusOneCounter
        cell.actionButton.tag = 2
        activityArray.append(cell)
        
        cell = ActivityCell()
        cell.activityName = "Learn something new"
        cell.tags = [tag1]
        cell.report0 = "Today: 1"
        cell.report1 = "This Week: 6"
        cell.report2 = "This month: 25"
        cell.entryType = .yesNo
        cell.actionButton.tag = 3
        activityArray.append(cell)
        
        cell = ActivityCell()
        cell.activityName = "Beers consumed"
        cell.tags = []
        cell.report0 = "Current streak: 10 days"
        cell.report1 = "Average: 20 days"
        cell.report2 = "Best Streak: 35 days"
        cell.entryType = .plusOneCounter
        cell.actionButton.tag = 4
        activityArray.append(cell)
    }
    
    // insert func to sort activityArray
    
    // Archive
    func loadArchiveArray() {
        let tag1 = Tag(name: "Daily")
        let tag2 = Tag(name: "Exercise")
        let tag3 = Tag(name: "Nutrition")
        var cell = ActivityCell()
        archiveArray = [ActivityCell]()
        
        cell.activityName = "Project 20,000 Pushups"
        cell.tags = [tag2]
        cell.report0 = "Today: 0"
        cell.report1 = "This Week: 2"
        cell.report2 = "This month: 10"
        cell.entryType = .keypad
        archiveArray.append(cell)
        
        cell = ActivityCell()
        cell.activityName = "Avoid Cigarettes"
        cell.tags = [tag1]
        cell.report0 = "Today: 0"
        cell.report1 = "This Week: 2"
        cell.report2 = "This month: 10"
        cell.entryType = .yesNo
        archiveArray.append(cell)
        
        cell = ActivityCell()
        cell.activityName = "Avoid Candy"
        cell.tags = [tag1, tag3]
        cell.report0 = "Today: 0"
        cell.report1 = "This Week: 2"
        cell.report2 = "This month: 10"
        cell.entryType = .yesNo
        archiveArray.append(cell)
    }
    
    // insert func to get report labels for a given activity
    
    // insert func to get tags for a give activity
    
    // MARK: - NAVIGATION METHODS
    
    // insert func to navigate to New Activity Screen
    
    // insert func to navigate to Activity Screen
    

}

// MARK: - TABLEVIEW

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Cell Selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            isShowingArchived = !isShowingArchived
            activityTableView.reloadData()
        }
    }
    
    // Initiate the creation of a new Entry
    @objc func createEntry(sender: UIButton) {
        if let activity = activityArray[sender.tag].activityName {
            print("creating entry for \(activity)!")
        }
    }
    
    // Populate TableView Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        
        if indexPath.section == 0 {
            cell = activityArray[indexPath.row]
        } else {
            if isShowingArchived {
                cell = archiveArray[indexPath.row]
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
            return activityArray.count
        } else {
            return isShowingArchived ? archiveArray.count : 1
        }
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
            let fontAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline), NSAttributedString.Key.foregroundColor: fontColor]
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
        return 26
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

