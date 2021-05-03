//
//  TitleDetailReminderCell.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/03.
//

import UIKit

class TitleDetailReminderCell: UITableViewCell {

    //MARK: - Properties
    
    static let identifier = "TitleDetailReminderCell"
    
    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleTextField.font = UIFont.systemFont(ofSize: 19)
        memoTextField.font = UIFont.systemFont(ofSize: 19)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
