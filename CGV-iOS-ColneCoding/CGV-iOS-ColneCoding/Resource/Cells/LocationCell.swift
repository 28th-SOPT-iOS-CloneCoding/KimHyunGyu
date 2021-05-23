//
//  LocationCell.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/21.
//

import UIKit

class LocationCell: UICollectionViewCell {

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var theaterLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        theaterLabel.font = UIFont.systemFont(ofSize: 15)

        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 10
        backView.layer.borderWidth = 1

    }
    
    override var isSelected: Bool {
        didSet {
          if isSelected {
            theaterLabel.textColor = .systemRed
        
            backView.backgroundColor = .white
            backView.layer.shadowColor = UIColor.red.cgColor
            backView.layer.borderColor = UIColor.red.cgColor
            
            backView.layer.masksToBounds = false
            backView.layer.shadowOpacity = 0.4
            backView.layer.shadowOffset = CGSize(width: 0, height: 0)
            backView.layer.shadowRadius = 2
          } else {
            theaterLabel.textColor = #colorLiteral(red: 0.5137254902, green: 0.5137254902, blue: 0.5215686275, alpha: 1)
            backView.backgroundColor = .systemGray6
            backView.layer.shadowColor = UIColor.white.cgColor
            backView.layer.borderColor = UIColor.systemGray5.cgColor
            
            backView.layer.masksToBounds = false

          }
        }
      }
    
    func setData(theater: String) {
        theaterLabel.text = theater
    }

}
