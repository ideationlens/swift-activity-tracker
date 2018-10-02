//
//  ViewController.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 9/30/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tagPicker: UIPickerView!
    let tagArray = ["Morning","Exercise","Groceries","All Activities"]
    
    @IBOutlet weak var reportTypePicker: UIPickerView!
    let reportTypeArray = ["Default","Count","Change","Streak","Days Passed"]
    
    @IBOutlet weak var activityTableView: UITableView!
    let activityArray = ["Exercise","Eat veggies","Learn something new","Go to bed"]
    
    override func loadView() {
        super.loadView()
        
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
        super.viewWillAppear(true)
        
        if let indexPath = activityTableView.indexPathForSelectedRow {
            activityTableView.deselectRow(at: indexPath, animated: true)
        }
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        print("Creating new activity tracker")
    }
    
    // MARK: - MODEL METHODS
    
    // MARK: LABEL METHODS
    
    // insert func to refresh labelArray
    
    // MARK: ENTRY METHODS
    
    // insert func to create a new Entry
    
    // insert func to refresh entryArray
    
    // MARK: ACTIVITY METHODS
    
    // insert func to refresh activityArray
    
    // insert func to refresh archivedArray
    
    // insert func to get report labels for a given activity
    
    // insert func to
    
    // MARK: - NAVIGATION METHODS
    
    // insert func to navigate to New Activity Screen
    
    // insert func to navigate to Activity Screen
    

}

// MARK: - TABLEVIEW

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return activityArray.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
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
            // Color code the picker view options
            let hue = CGFloat(row)/CGFloat(tagArray.count)
            var fontColor = UIColor.black
            // Main
            if (pickerView.tag == tagPicker.tag && row != tagArray.count - 1)
                || (pickerView.tag == reportTypePicker.tag && row == 0) {
                fontColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            }
            let fontAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline), NSAttributedString.Key.foregroundColor: fontColor]
            
            if pickerView.tag == tagPicker.tag {
                pickerLabel.attributedText = NSAttributedString(string: tagArray[row], attributes: fontAttributes)
                pickerLabel.textAlignment = .center
            } else {
                if component == 0 {
                    pickerLabel.attributedText = NSAttributedString(string: "Report Type:  ", attributes: fontAttributes)
                    pickerLabel.textAlignment = .right
                } else {
                    pickerLabel.attributedText = NSAttributedString(string: "  " + reportTypeArray[row], attributes: fontAttributes)
                    pickerLabel.textAlignment = .left
                }
            }
        
            // remove the selection indication lines from the picker view
            pickerView.subviews[1].isHidden = true
            pickerView.subviews[2].isHidden = true
        }
        
        return pickerLabel
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == tagPicker.tag {
            return 1
        } else {
            return 2
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == tagPicker.tag {
            return tagArray.count
        } else {
            if component == 0 {
                return 1
            } else {
                return reportTypeArray.count
            }
        }
    }
    
    // Set Row Height of Pickers
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 26
    }
    
    // Set Column Width by PickerView and Component
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if pickerView.tag == reportTypePicker.tag {
            if component == 0 {
                return self.view.frame.width / 3
            } else {
                return self.view.frame.width / 3 * 2
            }
        } else {
            return self.view.frame.width
        }
    }
}

