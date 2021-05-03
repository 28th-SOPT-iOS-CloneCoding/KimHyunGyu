//
//  ListDetailReminderCell.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/03.
//

import UIKit

class ListDetailReminderCell: UITableViewCell {

    //MARK: - Properties
    
    static let identifier = "ListDetailReminderCell"
    
    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var listLabel: UILabel!
    @IBOutlet weak var listColorBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }

    //MARK: - Methods
    
    private func setUI() {
        listLabel.textColor = .systemGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
