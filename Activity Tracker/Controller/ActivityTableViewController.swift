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
    
    var selectedActivity: Activity?
    var entries: Results<Entry>?
    let realm = try! Realm()
    
    // MARK: - VIEW CONTROLLER METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar()
        configureTableView()
        loadEntries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }

    // MARK: - UI Methods
    
    func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editActivity))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
    }
    
    func configureTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.clearsSelectionOnViewWillAppear = false
    }
    
    func updateUI() {
        // set title of page
        if let name = selectedActivity?.name {
            self.title = name
        } else {
            self.title = "Unknown Activity"
        }
    }
    
    // MARK: - REALM METHODS
    
    func loadEntries() {
        entries = selectedActivity?.entries.sorted(byKeyPath: "timestamp", ascending: false)
    }
    
    // MARK: - TABLEVIEW DATA SOURCE

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

    // TableView Rows Defined
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0: // chart
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "Insert Chart Here"
            return cell
            
        case 1: // reports
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "Insert reports here"
            return cell
            
        case 2: // entries
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            if let timestamp = entries?[indexPath.row].timestamp {
                cell.textLabel?.text = "\(timestamp)"
            }
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            return cell
        }
    }


    // MARK: - Navigation

    @objc func editActivity() {
        let vc = EditActivityTableViewController()
        vc.activity = selectedActivity
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}
