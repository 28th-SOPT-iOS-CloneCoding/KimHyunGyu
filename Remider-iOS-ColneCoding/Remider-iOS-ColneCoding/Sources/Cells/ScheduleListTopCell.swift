//
//  ScheduleListTopCell.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/28.
//

import UIKit

class ScheduleListTopCell: UITableViewCell {

    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    
    //MARK: - Properties
    
    static let identifier = "ScheduleListTopCell"
    
    //MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
