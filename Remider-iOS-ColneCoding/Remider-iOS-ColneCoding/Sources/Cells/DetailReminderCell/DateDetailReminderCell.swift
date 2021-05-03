//
//  DateDetailReminderCell.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/03.
//

import UIKit

class DateDetailReminderCell: UITableViewCell {

    //MARK: - Properties
    
    static let identifier = "DateDetailReminderCell"
    
    //MARK: - @IBOutlet Properties
    
    
    @IBOutlet weak var calendarBtn: UIButton!
    @IBOutlet weak var clockBtn: UIButton!
    @IBOutlet weak var calendarSwitch: UISwitch!
    @IBOutlet weak var clockSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUI()
    }
    
    private func setUI() {
        
        calendarBtn.backgroundColor = .systemRed
        calendarBtn.layer.cornerRadius = calendarBtn.frame.height / 4
        clockBtn.backgroundColor = .systemBlue
        clockBtn.layer.cornerRadius = clockBtn.frame.height / 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
