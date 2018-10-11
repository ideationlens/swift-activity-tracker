//
//  DisclosureCell.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/10/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import UIKit

class DisclosureCell: UITableViewCell {

    // MARK: PROPERTIES
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var detail: String? {
        get { return detailLabel.text }
        set { detailLabel.text = newValue }
    }
    
    // Title Label
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    // Detail Label
    let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        label.textAlignment = .right
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    // MARK: - METHODS
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Cell
        self.selectionStyle = .default
        self.accessoryType = .disclosureIndicator
        
        // Title Label
        self.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: self.frame.width * 0.3).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        // Detail Label
        self.addSubview(detailLabel)
        detailLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 10).isActive = true
        detailLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        detailLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
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
