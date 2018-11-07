//
//  AllEntriesTableViewController.swift
//  Activity Tracker
//
//  Created by CHRISTOPHER KIM on 10/31/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//
import RealmSwift
import UIKit

class AllEntriesTableViewController: UITableViewController {

    // add comment - CK
    // MARK: PROPERTIES
    
    let realm = try! Realm()
    var entries: Results<Entry>!

    
    
    
    // MARK: - VIEW CONTROLLER METHODS
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar()
        configureTableView()
        loadEntries()
        
        tableView.reloadData()
        
        
        if entries == nil { fatalError("Could not load entries") }
    
        
        
    }

    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        return entries.count
    }


    // TableView Rows (Cells) Defined
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
            let entryCell = EntryCell()
            if let entry = entries?[indexPath.row] {
                entryCell.entry = entry
                entryCell.layoutSubviews()
            }
            return entryCell
        
    
    }
    
    
    // MARK: - NAVIGATION
    
    // Configure Nav Bar
    
    func configureNavBar() {
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
    
    }

    
    // MARK: - REALM
    
    func loadEntries() {
        entries = realm.objects(Entry.self).sorted(byKeyPath: "timestamp", ascending: false)
    print("I found \(entries.count)")
    }
    
    // MARK: - TABLEVIEW
    
    
    func configureTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.clearsSelectionOnViewWillAppear = false
        
    }

    
    
}



