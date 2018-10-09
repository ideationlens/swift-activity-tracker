//
//  NameCell.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/7/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import UIKit

class TextEntryCell: UITableViewCell {

    //MARK: PROPERTIES
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue ?? "No name assigned"
        }
    }
    
    var entry: String = ""
    
    // Title Label
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 0
        
        return titleLabel
    }()
    
    let entryField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .bezel
        textField.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        textField.placeholder = "Enter name here"
        
        return textField
    }()
    
    // MARK: - METHODS
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // cell
        self.selectionStyle = .none
        
        // title
        self.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        
        // entryField
        self.addSubview(entryField)
        entryField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        entryField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        entryField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        entryField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        entryField.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
    }
    
    // Cell Switched
    @IBAction func settingSwitched(sender: UIButton) {
        print("creating entry in Activity Cell!")
    }
    
    // Layout Subviews
    override func layoutSubviews() {
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

extension TextEntryCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        entry = string
        return true
    }
}
