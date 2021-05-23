//
//  SelectTheaterTVC.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/21.
//

import UIKit

class SelectTheaterTVC: UITableViewCell {

    private var theatersList = [String]()
    

    @IBOutlet weak var theatersCollectionView: UICollectionView!
    @IBOutlet weak var selectLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectLabel.text = "극장선택"
        selectLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        self.theatersCollectionView.delegate = self
        self.theatersCollectionView.dataSource = self
        let theatersCell = UINib(nibName: "TheatersCell", bundle: nil)
        self.theatersCollectionView.register(theatersCell, forCellWithReuseIdentifier: "TheatersCell")
        
        theatersList = ["추천 CGV","서울","경기","인천","강원","대전/충청","대구","부산/울산","경산","광주/전라/제주"]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SelectTheaterTVC: UICollectionViewDelegate {
    
}

extension SelectTheaterTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theatersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let theatersCell = theatersCollectionView.dequeueReusableCell(withReuseIdentifier: "TheatersCell", for: indexPath) as? TheatersCell else {
            return UICollectionViewCell()
        }
        theatersCell.setData(location: theatersList[indexPath.row])
        if indexPath.item == 0 {
            theatersCell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        } else {
            theatersCell.isSelected = false
        }
        
        return theatersCell
    }
}

extension SelectTheaterTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let theatersCell = theatersCollectionView.dequeueReusableCell(withReuseIdentifier: "TheatersCell", for: indexPath) as? TheatersCell else {
            return CGSize(width: 0, height: 0)
        }
        theatersCell.locationLabel.text = theatersList[indexPath.row]
        theatersCell.locationLabel.sizeToFit()
        let cellWidth = theatersCell.locationLabel.frame.width + 5
        
        
       return CGSize(width: cellWidth, height: 20)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
