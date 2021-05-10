//
//  MovieCell.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/10.
//

import UIKit

class MovieCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let identifier = "MovieCell"
    
    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
