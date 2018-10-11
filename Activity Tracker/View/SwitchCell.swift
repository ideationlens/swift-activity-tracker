//
//  SwitchCell.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/7/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {

    // MARK: PROPERTIES
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var isSwitchOn: Bool {
        get { return settingSwitch.isOn }
        set { settingSwitch.isOn = newValue }
    }
    
    // Name Label
    let titleLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        nameLabel.numberOfLines = 0
        
        return nameLabel
    }()
    
    let settingSwitch: UISwitch = {
        let settingSwitch = UISwitch()
        settingSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        return settingSwitch
    }()
    
    // MARK: - METHODS
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Cell
        self.selectionStyle = .none
        
        // Switch
        self.addSubview(settingSwitch)
        settingSwitch.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        settingSwitch.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        settingSwitch.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        // Name
        self.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
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
