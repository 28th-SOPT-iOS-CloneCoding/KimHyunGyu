//
//  ListCell.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/26.
//

import Foundation
import UIKit

class ListCell: UITableViewCell {

    //MARK: - Properties
    
    static let identifier = "ListCell"
    
    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var testLabel: UILabel!
    
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
