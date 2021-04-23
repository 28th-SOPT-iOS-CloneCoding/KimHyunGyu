//
//  CustomCell.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/16.
//

import UIKit

class CustomCell: UITableViewCell {

    //MARK: - Properties
    
    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listBulletBtn: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        listBulletBtn.backgroundColor = .systemBlue
        listBulletBtn.layer.cornerRadius = listBulletBtn.frame.height/2
        listBulletBtn.setPreferredSymbolConfiguration(.init(pointSize: 12, weight: .bold, scale: .large), forImageIn: .normal)
        listBulletBtn.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
