//
//  ReportCell.swift
//  Activity Tracker
//
//  Created by Douglas Putnam on 10/10/18.
//  Copyright © 2018 Douglas Putnam. All rights reserved.
//

import UIKit

class ReportCell: UITableViewCell {
    
    // MARK: PROPERTIES
    
    // Computed properties
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }

    var report0: String {
        get { return report0Label.text ?? "" }
        set { report0Label.text = newValue }
    }
    
    var report1: String {
        get { return report1Label.text ?? "" }
        set { report1Label.text = newValue }
    }
    
    var report2: String {
        get { return report2Label.text ?? "" }
        set { report2Label.text = newValue }
    }
    
    // UIViews
    // Title Label
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 0
        
        return titleLabel
    }()
    
    // Report View
    let reportView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    // Report 0 Label
    var report0Label: UILabel = {
        let label = UILabel()
        label.tag = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    // Report 1 Label
    var report1Label: UILabel = {
        let label = UILabel()
        label.tag = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    // Report 2 Label
    var report2Label: UILabel = {
        let label = UILabel()
        label.tag = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
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
        //titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        // reportView
        self.addSubview(reportView)
        reportView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        reportView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        reportView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        reportView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        reportView.addArrangedSubview(report0Label)
        reportView.addArrangedSubview(report1Label)
        reportView.addArrangedSubview(report2Label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Cell Switched
    @IBAction func settingSwitched(sender: UIButton) {
        print("creating entry in Activity Cell!")
    }
    
    // Layout Subviews
    override func layoutSubviews() {
        // report labels
        report0Label.text = report0
        report0Label.isHidden = false
        
        report1Label.text = report1
        report1Label.isHidden = false

        report2Label.text = report2
        report2Label.isHidden = false
        
        super.layoutSubviews()
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
