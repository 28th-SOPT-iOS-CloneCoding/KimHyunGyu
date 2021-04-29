//
//  EditListCell.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/29.
//

import UIKit

class EditListCell: UITableViewCell {

    static let identifier = "EditListCell"
    
    @IBOutlet weak var listColorBtn: UIButton!
    @IBOutlet weak var listLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        listColorBtn.isUserInteractionEnabled = false
        listLabel.textColor = UIColor.lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
