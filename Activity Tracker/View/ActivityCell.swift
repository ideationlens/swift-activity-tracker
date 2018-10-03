//
//  ActivityCell.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/1/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
    
    // Declare data properties
    var activityName: String?
    var tags: [Tag]?
    var report0: String?
    var report1: String?
    var report2: String?
    var entryType: EntryType?
    var isDone = false
    
    // Declare view properties
    // Name and Tag View
    let nameAndTagView: UIStackView = {
        let nameAndTagView = UIStackView()
        nameAndTagView.spacing = 2
        nameAndTagView.translatesAutoresizingMaskIntoConstraints = false
        nameAndTagView.distribution = .fillProportionally
        //nameAndTagView.alignment = .center
        nameAndTagView.axis = .vertical

        return nameAndTagView
    }()
    
    // Name Label
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.tag = 4
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        nameLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 0
        
        return nameLabel
    }()
    
    // Tag Label
    let tagLabel: UILabel = {
        let tagLabel = UILabel()
        tagLabel.tag = 3
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.heightAnchor.constraint(equalToConstant: 53).isActive = true
        tagLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
        tagLabel.adjustsFontForContentSizeCategory = true
        tagLabel.numberOfLines = 2
        tagLabel.adjustsFontForContentSizeCategory = true
        
        return tagLabel
    }()
    
    // Report View
    let reportView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical

        return stackView
    }()
    
    // Report 0 Label
    var report0Label: UILabel = {
        let report0Label = UILabel()
        report0Label.tag = 0
        report0Label.translatesAutoresizingMaskIntoConstraints = false
        report0Label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
        report0Label.adjustsFontForContentSizeCategory = true
        report0Label.adjustsFontSizeToFitWidth = true
        report0Label.numberOfLines = 0
        report0Label.textAlignment = .right

        return report0Label
    }()
    
    // Report 1 Label
    var report1Label: UILabel = {
        let report1Label = UILabel()
        report1Label.tag = 1
        report1Label.translatesAutoresizingMaskIntoConstraints = false
        report1Label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
        report1Label.adjustsFontForContentSizeCategory = true
        report1Label.adjustsFontSizeToFitWidth = true
        report1Label.numberOfLines = 1
        report1Label.textAlignment = .right

        return report1Label
    }()
    
    // Report 2 Label
    var report2Label: UILabel = {
        let report2Label = UILabel()
        report2Label.tag = 2
        report2Label.translatesAutoresizingMaskIntoConstraints = false
        report2Label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
        report2Label.adjustsFontForContentSizeCategory = true
        report2Label.adjustsFontSizeToFitWidth = true
        report2Label.numberOfLines = 1
        report2Label.textAlignment = .right

        return report2Label
    }()
    
     // Button on right side
    let actionButton: UIButton = {
        let actionButton = UIButton()
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.isEnabled = true
        actionButton.contentMode = .scaleAspectFit
        actionButton.clipsToBounds = true
        actionButton.addTarget(self, action: #selector(createEntry(sender:)), for: .touchUpInside)
        
        return actionButton
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Cell
        //self.backgroundColor = UIColor.lightGray
        
        // Button View
        self.addSubview(actionButton)
        actionButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        actionButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: self.frame.width / 6).isActive = true

        // Report View
        self.addSubview(reportView)
        reportView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        reportView.rightAnchor.constraint(equalTo: actionButton.leftAnchor, constant: -2).isActive = true
        reportView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        reportView.widthAnchor.constraint(equalToConstant: self.frame.width / 2.5).isActive = true
        reportView.addArrangedSubview(report0Label)
        reportView.addArrangedSubview(report1Label)
        reportView.addArrangedSubview(report2Label)
        
        // Name and Tag
        self.addSubview(nameAndTagView)
        nameAndTagView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        nameAndTagView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        nameAndTagView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        nameAndTagView.rightAnchor.constraint(equalTo: reportView.leftAnchor, constant: -0).isActive = true
        nameAndTagView.addArrangedSubview(nameLabel)
        nameAndTagView.addArrangedSubview(tagLabel)
    }
    
    // Populate cell with data
    override func layoutSubviews() {
        super.layoutSubviews()

        // activityName
        if let name = activityName {
            nameLabel.text = name
        }
        
        // tags
        if let tags = tags {
            if !tags.isEmpty {
                var tagString = ""
                for tag in tags {
                    tagString += "[" + tag.name + "], "
                }
                tagString.removeLast()
                tagString.removeLast()
                if tagString.count < 30 {
                    tagString += "\n"
                }
                tagLabel.text = tagString
            } else {
                tagLabel.text = " "
            }
        }
        
        //nameAndTagView.layoutIfNeeded()
        
        // report0
        if let report = report0 {
            report0Label.text = report
        }
    
        // report1
        if let report = report1 {
            report1Label.text = report
        }
        
        // report2
        if let report = report2 {
            report2Label.text = report
        }
        
        // entryType
        if let entryType = entryType {
            //actionButton.backgroundColor = nil
            switch entryType {
            case .checkbox:
                actionButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
                actionButton.setImage(UIImage(named: "checkbox1"), for: .normal)
                actionButton.setImage(UIImage(named: "checkbox_complete"), for: .highlighted)
            case .plusOneCounter:
                actionButton.setAttributedTitle(NSAttributedString(string: "+1 ", attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title3), NSAttributedString.Key.foregroundColor: UIColor.black]), for: .normal)
            case .keypad:
                actionButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 8, bottom: 20, right: 7)
                actionButton.setImage(UIImage(named: "keypad1"), for: .normal)
            case .yesNo:
                actionButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 4)
                actionButton.setImage(UIImage(named: "yesNo1"), for: .normal)
            }
        }
        
//        nameLabel.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal
//            , toItem: tagLabel, attribute: .height, multiplier: 1 / 2, constant: 0))
    }
    
    @IBAction func createEntry(sender: UIButton) {
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
