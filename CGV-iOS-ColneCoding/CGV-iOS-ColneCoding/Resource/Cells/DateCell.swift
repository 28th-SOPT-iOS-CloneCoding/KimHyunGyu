//
//  DateCell.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/21.
//

import UIKit

class DateCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        dayLabel.font = UIFont.systemFont(ofSize: 12)
        dayLabel.backgroundColor = .white
        dayLabel.layer.cornerRadius = 10
        
        backView.layer.cornerRadius = 10
        backView.layer.borderWidth = 1
    }

    func setData(date: String, day: String) {
        dateLabel.text = date
        dayLabel.text = day
    }
    
    override var isSelected: Bool {
        didSet {
          if isSelected {
            dateLabel.textColor = .systemRed
            dayLabel.textColor = .systemRed
        
            backView.backgroundColor = .white
            backView.layer.shadowColor = UIColor.red.cgColor
            backView.layer.borderColor = UIColor.red.cgColor
            
            backView.layer.masksToBounds = false
            backView.layer.shadowOpacity = 0.4
            backView.layer.shadowOffset = CGSize(width: 0, height: 0)
            backView.layer.shadowRadius = 2
          } else {
            dateLabel.textColor = #colorLiteral(red: 0.5137254902, green: 0.5137254902, blue: 0.5215686275, alpha: 1)
            dayLabel.textColor = #colorLiteral(red: 0.5137254902, green: 0.5137254902, blue: 0.5215686275, alpha: 1)
            
            backView.backgroundColor = .white
            backView.layer.shadowColor = UIColor.white.cgColor
            backView.layer.borderColor = UIColor.white.cgColor
            
            backView.layer.masksToBounds = false

          }
        }
      }
}
