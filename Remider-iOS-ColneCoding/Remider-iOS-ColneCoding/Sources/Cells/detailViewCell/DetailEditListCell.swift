//
//  DetailEditListCell.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/29.
//

import UIKit

class DetailEditListCell: UITableViewCell {

    @IBOutlet weak var listLabel: UILabel!
    @IBOutlet weak var listBulletBtn: UIButton!
    
    static let identifier = "DetailEditListCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCell()
    }

    func setCell() {
        self.accessoryType = .checkmark
        listBulletBtn.backgroundColor = .systemBlue
        listBulletBtn.layer.cornerRadius = listBulletBtn.frame.height / 2
        listBulletBtn.setPreferredSymbolConfiguration(.init(pointSize: 12, weight: .bold, scale: .large), forImageIn: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
