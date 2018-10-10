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

    var selectedActivity: Activity?
    var entries: Results<Entry>?
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup nav bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editActivity))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
        
        // setup tableview
        self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }

    // MARK: - UI Methods
    
    func updateUI() {
        // set title of page
        if let name = selectedActivity?.name {
            self.title = name
            loadEntries()
        } else {
            self.title = "Unknown Activity"
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0 //3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
//        switch section {
//        case 0: return 1
//        case 1: return 1
//        case 2: return entries?.count ?? 0
//        default: return 0
//        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Entry Methods
    
    func loadEntries() {
        entries = selectedActivity?.entries.sorted(byKeyPath: "timestamp", ascending: false)
    }
    
    @objc func editActivity() {
        let vc = EditActivityTableViewController()
        vc.activity = selectedActivity
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
