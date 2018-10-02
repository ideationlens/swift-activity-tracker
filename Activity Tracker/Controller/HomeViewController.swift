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
    var tagArray: [String]!
    
    // Report Type Picker
    @IBOutlet weak var reportTypePicker: UIPickerView!
    var reportTypeArray: [String]!
    
    // Table View
    @IBOutlet weak var activityTableView: UITableView!
    var activityArray: [String]!
    var archiveArray: [String]!
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
        activityTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

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
        tagPicker.selectRow(tagArray.count - 1, inComponent: 0, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        print("Creating new activity tracker")
    }
    
    // MARK: - MODEL METHODS
    
    // MARK: TAG METHODS
    
    func loadTagArray() {
        tagArray = ["Morning","Exercise","Groceries","All Activities"]
    }
    
    // MARK: REPORT TYPE METHODS
    
    func loadReportTypeArray() {
        reportTypeArray = ["Default","Count","Change","Streak","Days Passed"]
    }
    
    // MARK: ENTRY METHODS
    
    // Activity Entry
    // insert func to create a new Entry
    
    // Archive Entry
    // insert func to refresh entryArray
    
    // MARK: ACTIVITY METHODS
    
    // Activity
    func loadActivityArray() {
        activityArray = ["Exercise","Eat veggies","Learn something new","Go to bed"]
    }
    
    // insert func to sort activityArray
    
    // Archive
    func loadArchiveArray() {
        archiveArray  = ["Project 20,000 Pushups", "Smoke a Cigarettes Today?"]
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
    
    // Populate TableView Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.attributedText =  makeAttributedString(title: activityArray[indexPath.row], subtitle: "insert Report labels here")
            //cell.translatesAutoresizingMaskIntoConstraints = false
            cell.heightAnchor.constraint(equalToConstant: 100)
            cell.accessoryType = .none
        } else {
            cell.alpha = 0.5
            if isShowingArchived {
                cell.textLabel?.attributedText =  makeAttributedString(title: archiveArray[indexPath.row], subtitle: "insert Report labels here")
                cell.accessoryType = .checkmark
                cell.heightAnchor.constraint(equalToConstant: 60)
            } else {
                cell.textLabel?.attributedText =  makeAttributedString(title: "Archived Activities", subtitle: "")
                cell.accessoryType = .detailDisclosureButton
                cell.heightAnchor.constraint(equalToConstant: 25)
                
            }
        }
        
        cell.textLabel?.numberOfLines = 0
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
    
    
    
    // Text formatting method used to populate TableView Cells
    func makeAttributedString(title: String, subtitle: String) -> NSAttributedString {
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.black]
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]
        
        let titleString = NSMutableAttributedString(string: "\(title)", attributes: titleAttributes)
        
        if subtitle.count > 0 {
            let subtitleString = NSAttributedString(string: "\n\(subtitle)", attributes: subtitleAttributes)
            titleString.append(subtitleString)
        }
        
        return titleString
    }
}

// MARK: - PICKERVIEW METHODS

extension HomeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Method to get user selection
    func pickerView(_ picker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if picker.tag == tagPicker.tag {
            print(tagArray[row])
        } else {
            print(reportTypeArray[row])
        }
    }
    
    // MARK: Format Picker Views

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = UILabel()
        
        if let currentLabel = view as? UILabel {
            pickerLabel = currentLabel
        } else {
            // Color code the non-default picker view options
            let hue = CGFloat(row)/CGFloat(tagArray.count)
            var fontColor = UIColor.black
            if (pickerView.tag == tagPicker.tag && row != tagArray.count - 1) {
                fontColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            }
            let fontAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline), NSAttributedString.Key.foregroundColor: fontColor]
            
            if pickerView.tag == tagPicker.tag {
                pickerLabel.attributedText = NSAttributedString(string: tagArray[row], attributes: fontAttributes)
                pickerLabel.textAlignment = .center
            } else {
                pickerLabel.attributedText = NSAttributedString(string: "  " + reportTypeArray[row], attributes: fontAttributes)
                pickerLabel.textAlignment = .left
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
            return tagArray.count
        } else {
            return reportTypeArray.count
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

