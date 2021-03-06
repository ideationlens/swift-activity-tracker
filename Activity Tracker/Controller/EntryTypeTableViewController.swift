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
        (cell.report0, cell.report1, cell.report2) = selectedActivity.getReportLabels(for: selectedActivity.reportTypeEnum)
        
        switch indexPath.section {
        case 0: cell.entryType = EntryType.checkbox
        case 1: cell.entryType = EntryType.plusOneCounter
//        case 2: cell.entryType = EntryType.keypad
//        case 3: cell.entryType = EntryType.yesNo
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
