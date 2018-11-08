//
//  ReportTypeTableViewController.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/13/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//
import RealmSwift
import UIKit

protocol ReceiveReportType {
    func setReportType(to reportType: ReportType)
}

class ReportTypeTableViewController: UITableViewController {
    
    // PROPERTIES
    
    let realm = try! Realm()
    var entryType: EntryType!
    var reportType: ReportType!
    var selectedActivity: Activity!
    var delegate: ReceiveReportType?
    
    // MARK: - VIEW CONTROLLER METHODS
    
    // View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation bar
        title = "Report Type"
        
        // table view
        self.tableView.register(ActivityCell.self, forCellReuseIdentifier: "ActivityCell")
        
        if selectedActivity == nil {
            selectedActivity = Activity()
        }
        if reportType == nil {
            reportType = selectedActivity.reportTypeEnum
        }
        if entryType == nil {
            entryType = selectedActivity.entryTypeEnum
        }
    }
    
    // View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
        self.tableView.selectRow(at: IndexPath(row: 0, section: reportType.rawValue), animated: true, scrollPosition: .none)
    }
    
    // MARK: - TABLE VIEW DELEGATE
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("User selected row \(String(describing: ReportType(rawValue: indexPath.section)))")
        reportType = ReportType(rawValue: indexPath.section)
        saveAndGoBackToEditActivityTableViewController()
    }
    
    // MARK: - TABLE VIEW DATA SOURCE
    
    // Number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
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
        var result1: Float = 0.0
        var result2: Float = 0.0
        
        switch indexPath.section {
        case ReportType.count.rawValue:
            cell.entryType = entryType
            // report 0
            result = selectedActivity.entries.filter("timestamp > %@", Date().addingTimeInterval(-86400)).count
            cell.report0 = "Last 24 hours: " + String(result)
            
            // report 1
            result = selectedActivity.entries.filter("timestamp > %@", Date().addingTimeInterval(-604800)).count
            cell.report1 = "Last 7 days: " + String(result)
            
            // report 2
            result = selectedActivity.entries.filter("timestamp > %@", Date().addingTimeInterval(-2419200)).count
            cell.report2 = "Last 4 weeks: " + String(result)
            
        case ReportType.change.rawValue:
            cell.entryType = entryType
            // report 0
            result = selectedActivity.entries.filter("timestamp > %@", Date().addingTimeInterval(-86400)).count
            cell.report0 = "Last 24 hours: \(result)/day"
            
            // report 2
            result1 = Float(selectedActivity.entries.filter("timestamp > %@", Date().addingTimeInterval(-604800)).count)/7.0
            cell.report2 = "Last 7 days: \(result1.format(f: ".1"))/day"
            
            if Float(result) > result1 {
                result2 = Float(result) - result1
                cell.report1 = "Delta: +\(result2.format(f: ".1"))/day"
            } else {
                cell.report1 = "Delta: \(result2.format(f: ".1"))/day"
            }
            
            
        case ReportType.streak.rawValue:
            cell.entryType = entryType
            cell.report0 = "Current Streak: 8"
            cell.report1 = "Best Streak: 12"
            cell.report0 = "Average: 7"
            
        case ReportType.timePassed.rawValue:
            cell.entryType = entryType
            cell.report0 = "Current: 10 days"
            cell.report1 = "Average: 14 days"
            cell.report2 = " "
            
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
        label.text = ReportType(rawValue: section)?.definition
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignment.left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        return label
    }
    
    // MARK: - Navigation

    func saveAndGoBackToEditActivityTableViewController() {
        // update entry type via delegate
        delegate?.setReportType(to: reportType)
        
        // dismiss
        _ = navigationController?.popViewController(animated: true)
    }
}
