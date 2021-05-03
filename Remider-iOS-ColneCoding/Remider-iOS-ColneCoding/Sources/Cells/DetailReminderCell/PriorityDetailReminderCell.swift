//
//  PriorityDetailReminderCell.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/03.
//

import UIKit

class PriorityDetailReminderCell: UITableViewCell {

    //MARK: - Properties
    
    static let identifier = "PriorityDetailReminderCell"
    
    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var priorityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }

    //MARK: - Methods
    
    private func setUI() {
        priorityLabel.textColor = .systemGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
