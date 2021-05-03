//
//  repeatDetailReminderCell.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/03.
//

import UIKit

class RepeatDetailReminderCell: UITableViewCell {

    //MARK: - Properteis
    
    static let identifier = "RepeatDetailReminderCell"
    
    //MARK: - @IBOultet Properies
    @IBOutlet weak var repeatBtn: UIButton!
    @IBOutlet weak var repeatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setUI() {
        repeatBtn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        repeatBtn.layer.cornerRadius = repeatBtn.frame.height / 4
        repeatBtn.isUserInteractionEnabled = false
        repeatLabel.text = "안 함"
        repeatLabel.textColor = .systemGray
    }
    
}
