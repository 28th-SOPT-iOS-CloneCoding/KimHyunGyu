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
    
    @IBOutlet weak var touchBookBtn: UIButton!
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var bookLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        touchBookBtn.layer.cornerRadius = touchBookBtn.frame.width / 12
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        voteLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        popularityLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        releaseDateLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        
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
        voteLabel.text = String("\(Int(round(vote*10)))%")
        bookLabel.text = "예매율"
        popularityLabel.text = String("\(Int(round(popularity/100)))%")
        popularityLabel.textColor = .systemRed
        releaseDateLabel.text = "\(releaseDate.replacingOccurrences(of: "-", with: ".")) 개봉"
    }
    
    func setPosterImage(image : UIImage) {
        posterImage.image = image
    }
    
}
