//
//  ActivityTableViewController.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/9/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import RealmSwift
import UIKit

class ActivityTableViewController: UITableViewController {
    
    // MARK: PROPERTIES
    
    let realm = try! Realm()
    var selectedActivity: Activity!
    var entries: Results<Entry>!
    
    // MARK: - VIEW CONTROLLER METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar()
        configureTableView()
        loadEntries()
        
        if selectedActivity == nil { fatalError("Could not load selected Activity")}
        if entries == nil { fatalError("Could not load entries") }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateNavBarTitle()
    }

    // MARK: - NAVBAR
    
    func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editActivity))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
    }
    
    func updateNavBarTitle() {
        // set title of page
        if let name = selectedActivity?.name {
            self.title = name
        } else {
            self.title = "Unknown Activity"
        }
    }
    
    // MARK: - REALM
    
    func loadEntries() {
        entries = selectedActivity.entries.sorted(byKeyPath: "timestamp", ascending: false)
    }
    
    // MARK: - TABLEVIEW

    func configureTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.clearsSelectionOnViewWillAppear = false
    }
    
    // MARK: TABLEVIEW DATA SOURCE
    
    // TableView Sections Defined
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return entries?.count ?? 0
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Chart"
        case 1: return "Reports"
        case 2: return "Entries"
        default: return ""
        }
    }

    // TableView Rows (Cells) Defined
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0: // chart
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "Insert Chart Here"
            return cell
            
        case 1: // reports
            let reportCell = ReportCell()
            reportCell.titleLabel.text = "Count Stats"
            
            var result = selectedActivity.entries.filter("timestamp > %@", Date().addingTimeInterval(-2419200)).count
            reportCell.report0 = "Last 4 weeks: \n" + String(result)
            
            result = selectedActivity.entries.filter("timestamp > %@", Date().addingTimeInterval(-604800)).count
            reportCell.report1 = "Last 7 days: \n" + String(result)
            
            result = selectedActivity.entries.filter("timestamp > %@", Date().addingTimeInterval(-86400)).count
            reportCell.report2 = "Last 24 hours: \n" + String(result)

            
            reportCell.layoutSubviews()
            return reportCell
            
        case 2: // entries
            let entryCell = EntryCell()
            if let entry = entries?[indexPath.row] {
                entryCell.entry = entry
                entryCell.layoutSubviews()
            }
            return entryCell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            return cell
        }
    }

    // MARK: - NAVIGATION

    @objc func editActivity() {
        let vc = EditActivityTableViewController()
        vc.activity = selectedActivity
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}
