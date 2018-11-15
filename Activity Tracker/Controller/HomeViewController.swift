//
//  ViewController.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 9/30/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import RealmSwift
import UIKit

class HomeViewController: UIViewController {
    
    // PROPERTIES
    
    // Database
    let realm = try! Realm()
    var tags: Results<Tag>!
    var activeActivities: Results<Activity>!
    var archivedActivities: Results<Activity>!

    var reportTypePickerData = [String]()

    // Views
    @IBOutlet weak var tagPicker: UIPickerView!
    @IBOutlet weak var activityTableView: UITableView!
    @IBOutlet weak var reportTypePicker: UIPickerView!
    
    var isShowingArchived: Bool = false
    
    // MARK: - VIEW CONTROLLER METHODS
    
    override func loadView() {
        super.loadView()

        configureNavBar()
        configurePickerView()
        configureTableView()
    }
    
    // View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
        activityTableView.reloadData()
    }
    
    // View Did Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // when first opening the app, reset the picker view selections
        if let count = tags?.count {
            tagPicker.selectRow(count, inComponent: 0, animated: false)
        }
    
        // when returning from a previous
        if let indexPath = activityTableView.indexPathForSelectedRow {
            activityTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - MODEL METHODS

    func loadData() {
        // tags
        tags = realm.objects(Tag.self)
        
        // report type
        reportTypePickerData = ["Default","Count","Change","Streak","Days Passed"]
        
        // activities
        activeActivities = realm.objects(Activity.self).filter("isArchived == false")
        archivedActivities = realm.objects(Activity.self).filter("isArchived == true")
            // insert func to get report labels for a given activity
    }
    
    func updateTagFilter(selection: Tag?) {
        if let tag = selection {
            activeActivities = realm.objects(Activity.self).filter("isArchived == false && ANY tags.name = %@",tag.name)
            archivedActivities = realm.objects(Activity.self).filter("isArchived == true && ANY tags.name = %@",tag.name)
            isShowingArchived = true
        } else {
            activeActivities = realm.objects(Activity.self).filter("isArchived == false")
            archivedActivities = realm.objects(Activity.self).filter("isArchived == true")
            isShowingArchived = false
        }
        activityTableView.reloadData()
    }

    // Create New Entry
    @objc func createEntry(sender: UIButton) {
        if let activity = activeActivities?[sender.tag].name {
            print("creating entry for \(activity)!")
            
            if let currentActivity = self.activeActivities?[sender.tag] {
                do {
                    try self.realm.write {
                        let newEntry = Entry()
                        newEntry.value = 1
                        newEntry.timestamp = Date()
                        currentActivity.entries.append(newEntry)
                    }
                } catch {
                    print("Error saving new entry, \(error)")
                }
            }
            
            self.activityTableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        }
    }

    // Create Sample Activities
    func createSampleActivities() {
        let tag1 = Tag()
        tag1.name = "Daily"
        let tag2 = Tag()
        tag2.name = "Exercise"
        let tag3 = Tag()
        tag3.name = "Nutrition"
        
        // save activity method
        func save(activity: Activity) {
            do {
                try realm.write {
                    realm.add(activity)
                }
            } catch {
                print("Error saving context: \(error)")
            }
        }

        // create sample activities
        var activity = Activity()
        activity.name = "Go to gym"
        activity.tags.append(objectsIn: [tag1,tag2])
        activity.entryTypeEnum = .checkbox
        save(activity: activity)

        activity = Activity()
        activity.name = "Floss teeth"
        activity.entryTypeEnum = .checkbox
        save(activity: activity)

        activity = Activity()
        activity.name = "Eat veggies"
        activity.tags.append(objectsIn: [tag2, tag3])
        activity.entryTypeEnum = .plusOneCounter
        save(activity: activity)
        
        activity = Activity()
        activity.name = "Beer counter"
        activity.entryTypeEnum = .plusOneCounter
        save(activity: activity)
        
        activity = Activity()
        activity.name = "Read"
        activity.tags.append(tag3)
        activity.entryTypeEnum = .plusOneCounter
        save(activity: activity)
        
        activity = Activity()
        activity.name = "Do 20,000 Pushups"
        activity.tags.append(tag2)
        activity.entryTypeEnum = .checkbox
        activity.isArchived = false
        save(activity: activity)
        
        activity = Activity()
        activity.name = "Avoid Cigarettes"
        activity.tags.append(tag1)
        activity.entryTypeEnum = .checkbox
        activity.isArchived = false
        save(activity: activity)
    }
    
    // MARK: - NAVIGATION
    
    // Configure Nav Bar
    func configureNavBar() {
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
    }
    
    // Go to Activity Screen
    @objc func goToDetails(of activity: Activity) {
        let vc = ActivityTableViewController()
        vc.selectedActivity = activity
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // change back button to say cancel when navigating to EditActivityTableviewController
        if segue.identifier == "addActivity" {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        }
    }
    
    // Add Button Pressed
    @IBAction func addButtonPressed(_ sender: Any) {
        print("Creating new activity tracker")
        
        //actual segue is in storyboard
    }
}

// MARK: - TABLEVIEW

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Configure Table View
    func configureTableView() {
        activityTableView.delegate = self
        activityTableView.dataSource = self
        activityTableView.register(ActivityCell.self, forCellReuseIdentifier: "ActivityCell")
        activityTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        activityTableView.separatorStyle = .singleLine
        activityTableView.rowHeight = 75
    }
    
    // Cell Selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && !isShowingArchived {
            isShowingArchived = !isShowingArchived
            activityTableView.reloadData()
        } else {
            if indexPath.section == 0 {
                if let activity = activeActivities?[indexPath.row] {
                    goToDetails(of: activity)
                }
            } else {
                if let activity = archivedActivities?[indexPath.row] {
                    goToDetails(of: activity)
                }
            }
        }
    }
    
    // Populate TableView Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        
        if indexPath.section == 0 {
            guard let activity = activeActivities?[indexPath.row] else { fatalError("Could not access activity from Active Activities")}
            
            cell.activityName = activity.name
            cell.tags = activity.tags
            cell.entryType = activity.entryTypeEnum
            cell.actionButton.tag = indexPath.row
            if reportTypePicker.selectedRow(inComponent: 0) > 0 {
                let reportType = ReportType(rawValue: reportTypePicker.selectedRow(inComponent: 0) - 1)
                (cell.report0, cell.report1, cell.report2) = (activity.getReportLabels(for: reportType))
            } else {
                (cell.report0, cell.report1, cell.report2) = (activity.getReportLabels())
            }
            
        } else {
            if isShowingArchived {
                cell.activityName = archivedActivities?[indexPath.row].name ?? "No name"
                cell.tags = archivedActivities?[indexPath.row].tags
                cell.actionButton.isEnabled = false
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
    
    // Section Count
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Row Count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return activeActivities?.count ?? 0
        } else {
            return isShowingArchived ? archivedActivities?.count ?? 0 : 1
        }
    }
    
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            if isShowingArchived {
                return 60
            } else {
                return 30
            }
        }
        
        return 0
    }
}

// MARK: - PICKERVIEW METHODS

extension HomeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Configure Picker View
    func configurePickerView() {
        tagPicker.delegate = self
        tagPicker.dataSource = self
        tagPicker.translatesAutoresizingMaskIntoConstraints = false
        
        reportTypePicker.delegate = self
        reportTypePicker.dataSource = self
        reportTypePicker.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: PICKERVIEW DELEGATE
    
    func pickerView(_ picker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if picker.tag == tagPicker.tag {
            if row > (tags?.count ?? 1) - 1 {
                updateTagFilter(selection: nil)
            } else if let tag = tags?[row] {
                updateTagFilter(selection: tag)
            } else {
                updateTagFilter(selection: nil)
            }
        } else {
            print(reportTypePickerData[row])
            activityTableView.reloadData()
        }
    }
    
    // MARK: PICKERVIEW DATA SOURCE

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = UILabel()
        
        if let currentLabel = view as? UILabel {
            pickerLabel = currentLabel
        } else {
            // Format font
//            let hue = CGFloat(row)/CGFloat(tagPickerData.count)
            let fontColor = UIColor.black
//            if (pickerView.tag == tagPicker.tag && row != tagPickerData.count - 1) {
//                fontColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
//            }
            let fontAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline), NSAttributedString.Key.foregroundColor: fontColor]
            pickerLabel.textAlignment = .left
            
            if pickerView.tag == tagPicker.tag {
                // tag picker
                if row > (tags?.count ?? 0) - 1 {
                    pickerLabel.attributedText = NSAttributedString(string: "  All Activities", attributes: fontAttributes)
                } else {
                    pickerLabel.attributedText = NSAttributedString(string: "  " + (tags?[row].name ?? "tag name not found"), attributes: fontAttributes)
                }
                
            } else {
                
                // report type picker
                pickerLabel.attributedText = NSAttributedString(string: "  " + reportTypePickerData[row], attributes: fontAttributes)
            }
        
            // remove the selection indication lines from the picker view
            pickerView.subviews[1].isHidden = true
            pickerView.subviews[2].isHidden = true
        }
        
        return pickerLabel
    }
    
    // Number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Numer of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == tagPicker.tag {
            if let count = tags?.count {
                return count + 1
            } else {
                return 1
            }
        } else {
            return reportTypePickerData.count
        }
    }
    
    // Set Row Height of Pickers
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 27
    }
}

