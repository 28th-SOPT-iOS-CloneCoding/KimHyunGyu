//
//  StoryTVC.swift
//  PenCake-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/05/30.
//

import UIKit

class StoryTVC: UITableViewCell {

    // MARK: - Properties
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if isHighlighted == true {
            titleLabel.textColor = #colorLiteral(red: 0.9562026515, green: 0.9562026515, blue: 0.9562026515, alpha: 1)
            titleLabel.textColor = #colorLiteral(red: 0.9562026515, green: 0.9562026515, blue: 0.9562026515, alpha: 1)
        } else {
            titleLabel.textColor = .black
            titleLabel.textColor = .black
        }
    }
    
    private func setUI() {
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    func setData(title: String, date: String) {
        titleLabel.text = title
        dateLabel.text = date
    }
}
