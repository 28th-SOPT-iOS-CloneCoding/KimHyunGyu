//
//  TheatersCell.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/21.
//

import UIKit

class TheatersCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        locationLabel.font = UIFont.systemFont(ofSize: 15)
    }
    override var isSelected: Bool {
        didSet {
          if isSelected {
            locationLabel.textColor = .systemRed
          } else {
            locationLabel.textColor = #colorLiteral(red: 0.5137254902, green: 0.5137254902, blue: 0.5215686275, alpha: 1)
          }
        }
      }

    func setData(location: String) {
        locationLabel.text = location
    }
}

