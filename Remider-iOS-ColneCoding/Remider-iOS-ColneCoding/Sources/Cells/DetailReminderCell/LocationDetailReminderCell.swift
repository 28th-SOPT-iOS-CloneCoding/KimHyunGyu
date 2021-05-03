//
//  LocationDetailReminderCell.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/03.
//

import UIKit

class LocationDetailReminderCell: UITableViewCell {

    //MARK: - Properties
    
    static let identifier = "LocationDetailReminderCell"
    
    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var locationBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUI()
    }
    
    //MARK: - Methods
    
    private func setUI() {
        locationBtn.isUserInteractionEnabled = false
        locationBtn.backgroundColor = .systemBlue
        locationBtn.layer.cornerRadius = locationBtn.frame.height / 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
