//
//  SelectLocationTVC.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/21.
//

import UIKit

class SelectLocationTVC: UITableViewCell {
    
    private var locationList = [LocationDataModel]()
    
    @IBOutlet weak var locationCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setList()
        self.locationCollectionView.delegate = self
        self.locationCollectionView.dataSource = self
        let locationCell = UINib(nibName: "LocationCell", bundle: nil)
        self.locationCollectionView.register(locationCell, forCellWithReuseIdentifier: "LocationCell")
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setList() {
        locationList.append(contentsOf: [
            LocationDataModel(keyLocation: "추천 CGV",
                              theater: ["중계", "하계", "상봉"]),
            LocationDataModel(keyLocation: "서울",
                              theater: ["강남","강변","건대입구","구로","대학로","동대문","등촌","명동","명동역 씨네라이브러리" ]),
            LocationDataModel(keyLocation: "경기",
                              theater: ["경기광주","고양행신","광교","광교상현","구리","김포","김포운양"]),
            LocationDataModel(keyLocation: "인천",
                              theater: ["강남","강변","건대입구","구로","대학로","동대문","등촌","명동","명동역 씨네라이브러리" ]),
            LocationDataModel(keyLocation: "강원",
                              theater: ["강남","강변","건대입구","구로","대학로","동대문","등촌","명동","명동역 씨네라이브러리" ]),
            LocationDataModel(keyLocation: "대전/충청",
                              theater: ["강남","강변","건대입구","구로","대학로","동대문","등촌","명동","명동역 씨네라이브러리" ]),
            LocationDataModel(keyLocation: "대구",
                              theater: ["강남","강변","건대입구","구로","대학로","동대문","등촌","명동","명동역 씨네라이브러리" ]),
            LocationDataModel(keyLocation: "부산/울산",
                              theater: ["강남","강변","건대입구","구로","대학로","동대문","등촌","명동","명동역 씨네라이브러리" ]),
            LocationDataModel(keyLocation: "경산",
                              theater: ["강남","강변","건대입구","구로","대학로","동대문","등촌","명동","명동역 씨네라이브러리" ]),
            LocationDataModel(keyLocation: "광주/전라/제주",
                              theater: ["강남","강변","건대입구","구로","대학로","동대문","등촌","명동","명동역 씨네라이브러리" ])
        ])
    }
}

extension SelectLocationTVC: UICollectionViewDelegate {
    
}

extension SelectLocationTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationList[1].theater.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let locationCell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: "LocationCell", for: indexPath) as? LocationCell else {
            return UICollectionViewCell()
        }
        locationCell.setData(theater: locationList[1].theater[indexPath.row])
        if indexPath.item == 0 {
            locationCell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        } else {
            locationCell.isSelected = false
        }
        
        return locationCell
    }
}

extension SelectLocationTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let locationCell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: "LocationCell", for: indexPath) as? LocationCell else {
            return CGSize(width: 0, height: 0)
        }
        locationCell.theaterLabel.text = locationList[1].theater[indexPath.row]
        locationCell.theaterLabel.sizeToFit()
        let cellWidth = locationCell.theaterLabel.frame.width + 30
        let cellHeight = locationCell.theaterLabel.frame.height + 30
        
        
       return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
