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
    
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(title: String,
                 vote: Double,
                 popularity: Double,
                 releaseDate: String) {
        titleLabel.text = title
        voteLabel.text = String(vote)
        popularityLabel.text = String(popularity)
        releaseDateLabel.text = releaseDate
    }
    
    func setPosterImage(image : UIImage) {
        posterImage.image = image
    }
    
}
