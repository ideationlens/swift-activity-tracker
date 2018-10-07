//
//  SwitchCell.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/7/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {

    //MARK: PROPERTIES
    
    var name: String? {
        get {
            return nameLabel.text
        }
        set {
            nameLabel.text = newValue ?? "No name assigned"
        }
    }
    
    var isSwitchOn: Bool {
        get {
            return settingSwitch.isOn
        }
        set {
            settingSwitch.isOn = newValue
        }
    }
    
    // Name Label
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        nameLabel.numberOfLines = 0
        
        return nameLabel
    }()
    
    let settingSwitch: UISwitch = {
        let settingSwitch = UISwitch()
        settingSwitch.translatesAutoresizingMaskIntoConstraints = false
        settingSwitch.addTarget(self, action: #selector(settingSwitched(sender:)), for: .touchUpInside)
        
        return settingSwitch
    }()
    
    // MARK: - METHODS
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Cell
        // self.accessoryType = .detailButton
        self.selectionStyle = .none
        
        // Switch
        self.addSubview(settingSwitch)
        settingSwitch.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        settingSwitch.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        settingSwitch.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        // Name
        self.addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        nameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    
    // Cell Switched
    @IBAction func settingSwitched(sender: UIButton) {
        print("creating entry in Activity Cell!")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
