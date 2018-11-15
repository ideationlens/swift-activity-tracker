//
//  EntryTypeTableViewController.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/12/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import RealmSwift
import UIKit

protocol ReceiveEntryType {
    func setEntryType(to entryType: EntryType)
}

class EntryTypeTableViewController: UITableViewController {

    // PROPERTIES
    
    let realm = try! Realm()
    var entryType: EntryType!
    var selectedActivity: Activity!
    var delegate: ReceiveEntryType?
    
    // MARK: - VIEW CONTROLLER METHODS
    
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation bar
        title = "Entry Type"
        
        // table view
        self.tableView.register(ActivityCell.self, forCellReuseIdentifier: "ActivityCell")

        if selectedActivity == nil {
            selectedActivity = Activity()
        }
        if entryType == nil {
            entryType = selectedActivity.entryTypeEnum
        }
    }
    
    // View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
        self.tableView.selectRow(at: IndexPath(row: 0, section: entryType.rawValue), animated: true, scrollPosition: .none)
    }

    // MARK: - TABLE VIEW DELEGATE
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("User selected row \(String(describing: EntryType(rawValue: indexPath.section)))")
        entryType = EntryType(rawValue: indexPath.section)
        saveAndGoBackToEditActivityTableViewController()
    }
    
    // MARK: - TABLE VIEW DATA SOURCE

    // Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    // Cell for row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "ActivityCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ActivityCell

        cell.activityName = selectedActivity?.name ?? "[Activity Name]"
        
        var result = 0
        switch indexPath.section {
        case 0:
            cell.entryType = EntryType.checkbox
            cell.report0 = "Current Streak: 8"
            cell.report1 = "Best Streak: 12"
            cell.report2 = " "

        case 1:
            cell.entryType = EntryType.plusOneCounter
            // report 0
            result = selectedActivity.entries.filter("timestamp > %@", Date().addingTimeInterval(-86400)).count
            cell.report0 = "Last 24 hours: " + String(result)
            
            // report 1
            result = selectedActivity.entries.filter("timestamp > %@", Date().addingTimeInterval(-604800)).count
            cell.report1 = "Last 7 days: " + String(result)
            
            // report 2
            result = selectedActivity.entries.filter("timestamp > %@", Date().addingTimeInterval(-2419200)).count
            cell.report2 = "Last 4 weeks: " + String(result)
            
//        case 2:
//           cell.entryType = EntryType.keypad
//           var sum = 0
//           for entry in selectedActivity.entries.filter("timestamp > %@", Date().addingTimeInterval(-86400)) { sum += entry.value }
//           cell.report0 = "Today: " + String(sum)
//
//           sum = 0
//           for entry in selectedActivity.entries { sum += entry.value }
//           cell.report2 = "Total: " + String(sum)
//           let entries = selectedActivity.entries
//           let days = Float(Date().days(from: entries.first!.timestamp) + 1)
//           print("days = \(days)")
//           cell.report1 = "Average: " + String(Float(sum)/days)
//
//        case 3:
//           cell.entryType = EntryType.yesNo
//           cell.report0 = "'Yes' Count: 25"
//           cell.report1 = "% 'Yes': 80%"
//           cell.report2 = "Days since 'No': 3"
            
        default:
           cell.entryType = nil
        }
        
        cell.actionButton.isEnabled = false
        cell.layoutSubviews()
        return cell
    }
    
    // MARK: TABLE VIEW HEADER
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //Need to create a label with the text we want in order to figure out height
        let label: UILabel = createHeaderLabel(section)
        let size = label.sizeThatFits(CGSize(width: view.frame.width, height: CGFloat.greatestFiniteMagnitude))
        let padding: CGFloat = 20.0
        return size.height + padding
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        let label = createHeaderLabel(section)
        label.autoresizingMask = [.flexibleHeight]
        headerView.addSubview(label)
        return headerView
    }
    
    func createHeaderLabel(_ section: Int)->UILabel {
        let widthPadding: CGFloat = 20.0
        let label: UILabel = UILabel(frame: CGRect(x: widthPadding, y: 0, width: self.view.frame.width - widthPadding, height: 0))
        label.text = EntryType(rawValue: section)?.definition
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignment.left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        return label
    }

    // MARK: - Navigation

    @objc func doneButtonPressed() {
        saveAndGoBackToEditActivityTableViewController()
    }
    
    func saveAndGoBackToEditActivityTableViewController() {
        // update entry type via delegate
        delegate?.setEntryType(to: entryType)
        
        // dismiss
        _ = navigationController?.popViewController(animated: true)
    }
}
