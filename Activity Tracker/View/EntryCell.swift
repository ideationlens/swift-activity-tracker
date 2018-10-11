//
//  EntryCell.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/10/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import UIKit

class EntryCell: UITableViewCell {

    // MARK: PROPERTIES
    var entry: Entry?
        
    // Date Label
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        dateLabel.textAlignment = .left
        dateLabel.adjustsFontForContentSizeCategory = true
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.numberOfLines = 1
        
        return dateLabel
    }()
    
    // Value Label
    let valueLabel: UILabel = {
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
        valueLabel.textAlignment = .right
        valueLabel.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.numberOfLines = 1
        
        return valueLabel
    }()
    
    // MARK: - METHODS
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // cell
        self.selectionStyle = .default
        self.accessoryType = .none
        
        // title
        self.addSubview(dateLabel)
        dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: self.frame.width * 0.75).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        // entryField
        self.addSubview(valueLabel)
        valueLabel.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 8).isActive = true
        valueLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        valueLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    
    // Populate and layout labels
    override func layoutSubviews() {
        // format date label
        if let date = entry?.timestamp {
            dateLabel.text = date.toString(dateFormat: "yyyy-MM-dd hh:mm:ss a")
        }
        
        // format value label
        if let value = entry?.value {
            valueLabel.text = "\(value)"
        }
        
        super.layoutSubviews()
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
