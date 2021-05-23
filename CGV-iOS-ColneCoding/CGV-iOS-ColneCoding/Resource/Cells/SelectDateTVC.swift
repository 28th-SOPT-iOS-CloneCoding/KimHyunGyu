//
//  SelectDateTVC.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/21.
//

import UIKit

class SelectDateTVC: UITableViewCell {

    private var dateList = [DateDataModel]()
    
    @IBOutlet weak var dateCollectionView: UICollectionView!
    @IBOutlet weak var datetimeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    
    @IBOutlet weak var totalBtn: UIButton!
    @IBOutlet weak var morningBtn: UIButton!
    @IBOutlet weak var afternoonBtn: UIButton!
    @IBOutlet weak var eveningBtn: UIButton!
    @IBOutlet weak var nightBtn: UIButton!
    
    @IBOutlet weak var lookupBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setList()
        setStackBtn()
        
        self.dateCollectionView.delegate = self
        self.dateCollectionView.dataSource = self
        let dateCell = UINib(nibName: "DateCell", bundle: nil)
        self.dateCollectionView.register(dateCell, forCellWithReuseIdentifier: "DateCell")
        
        datetimeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        datetimeLabel.text = "날짜/시간"
        
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.text = "2021.5.21 (금)"
        
        todayLabel.font = UIFont.systemFont(ofSize: 14)
        todayLabel.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        todayLabel.text = "오늘"
        
        lookupBtn.setTitle("조회하기", for: .normal)
        lookupBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        lookupBtn.layer.cornerRadius = 10
        lookupBtn.setTitleColor(.white, for: .normal)
        lookupBtn.backgroundColor = .systemGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setList() {
        dateList.append(contentsOf: [
            DateDataModel(date: "21",
                          day: "오늘"),
            DateDataModel(date: "22",
                          day: "내일"),
            DateDataModel(date: "23",
                          day: "일"),
            DateDataModel(date: "24",
                          day: "월"),
            DateDataModel(date: "25",
                          day: "화"),
            DateDataModel(date: "26",
                          day: "수"),
            DateDataModel(date: "27",
                          day: "목"),
            DateDataModel(date: "28",
                          day: "금"),
            DateDataModel(date: "29",
                          day: "토"),
            DateDataModel(date: "30",
                          day: "일"),
            DateDataModel(date: "31",
                          day: "월"),
            DateDataModel(date: "1",
                          day: "화"),
            DateDataModel(date: "2",
                          day: "수"),
            DateDataModel(date: "3",
                          day: "목")
        ])
    }
    private func setStackBtn() {
        totalBtn.setTitle("전체", for: .normal)
        totalBtn.setTitleColor(.systemGray, for: .normal)
        totalBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        totalBtn.backgroundColor = #colorLiteral(red: 0.9668200967, green: 0.9668200967, blue: 0.9668200967, alpha: 1)
        totalBtn.layer.cornerRadius = 10
        totalBtn.addTarget(self, action: #selector(isSelectedFirst(_:)), for: .touchUpInside)
        totalBtn.layer.borderWidth = 1
        totalBtn.layer.borderColor = UIColor.systemGray5.cgColor

        
        morningBtn.setTitle("오전", for: .normal)
        morningBtn.setTitleColor(.systemGray, for: .normal)
        morningBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        morningBtn.backgroundColor = #colorLiteral(red: 0.9668200967, green: 0.9668200967, blue: 0.9668200967, alpha: 1)
        morningBtn.layer.cornerRadius = 10
        morningBtn.layer.borderWidth = 1
        morningBtn.layer.borderColor = UIColor.systemGray5.cgColor
        morningBtn.addTarget(self, action: #selector(isSelectedSecond(_:)), for: .touchUpInside)
        
        afternoonBtn.setTitle("오후", for: .normal)
        afternoonBtn.setTitleColor(.systemGray, for: .normal)
        afternoonBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        afternoonBtn.backgroundColor = #colorLiteral(red: 0.9668200967, green: 0.9668200967, blue: 0.9668200967, alpha: 1)
        afternoonBtn.layer.cornerRadius = 10
        afternoonBtn.layer.borderWidth = 1
        afternoonBtn.layer.borderColor = UIColor.systemGray5.cgColor
        afternoonBtn.layer.masksToBounds = true
        afternoonBtn.addTarget(self, action: #selector(isSelectedThird(_:)), for: .touchUpInside)
        
        eveningBtn.setTitle("18시이후", for: .normal)
        eveningBtn.setTitleColor(.systemGray, for: .normal)
        eveningBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        eveningBtn.backgroundColor = #colorLiteral(red: 0.9668200967, green: 0.9668200967, blue: 0.9668200967, alpha: 1)
        eveningBtn.layer.cornerRadius = 10
        eveningBtn.layer.borderWidth = 1
        eveningBtn.layer.borderColor = UIColor.systemGray5.cgColor
        eveningBtn.addTarget(self, action: #selector(isSelectedFourth(_:)), for: .touchUpInside)
        
        nightBtn.setTitle("심야", for: .normal)
        nightBtn.setTitleColor(.systemGray, for: .normal)
        nightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        nightBtn.backgroundColor = #colorLiteral(red: 0.9668200967, green: 0.9668200967, blue: 0.9668200967, alpha: 1)
        nightBtn.layer.cornerRadius = 10
        nightBtn.layer.borderWidth = 1
        nightBtn.layer.borderColor = UIColor.systemGray5.cgColor
        nightBtn.layer.masksToBounds = true
        nightBtn.addTarget(self, action: #selector(isSelectedFifth(_:)), for: .touchUpInside)
    }
    
    @objc
    func isSelectedFirst(_ sender: UIButton){
        sender.setTitleColor(.red, for: .normal)
        sender.layer.borderColor = UIColor.red.cgColor
        sender.layer.masksToBounds = false
        sender.layer.shadowColor = UIColor.red.cgColor
        sender.layer.shadowOpacity = 0.3
        sender.layer.shadowOffset = CGSize(width: 0, height: 0)
        sender.layer.shadowRadius = 2
        
        let btns = [morningBtn,afternoonBtn, eveningBtn, nightBtn]
        btns.map({ btn in
                    btn?.setTitleColor(.systemGray, for: .normal)
                    btn?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                    btn?.backgroundColor = #colorLiteral(red: 0.9668200967, green: 0.9668200967, blue: 0.9668200967, alpha: 1)
                    btn?.layer.cornerRadius = 10
                    btn?.layer.borderWidth = 1
                    btn?.layer.borderColor = UIColor.systemGray5.cgColor
                    btn?.layer.masksToBounds = true
                    btn?.layer.shadowRadius = 0
        })
        lookupBtn.backgroundColor = .red
        
    }
    @objc
    func isSelectedSecond(_ sender: UIButton){
        sender.setTitleColor(.red, for: .normal)
        sender.layer.borderColor = UIColor.red.cgColor
        sender.layer.masksToBounds = false
        sender.layer.shadowColor = UIColor.red.cgColor
        sender.layer.shadowOpacity = 0.3
        sender.layer.shadowOffset = CGSize(width: 0, height: 0)
        sender.layer.shadowRadius = 2
        
        let btns = [totalBtn, afternoonBtn, eveningBtn, nightBtn]
        btns.map({ btn in
                    btn?.setTitleColor(.systemGray, for: .normal)
                    btn?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                    btn?.backgroundColor = #colorLiteral(red: 0.9668200967, green: 0.9668200967, blue: 0.9668200967, alpha: 1)
                    btn?.layer.cornerRadius = 10
                    btn?.layer.borderWidth = 1
                    btn?.layer.borderColor = UIColor.systemGray5.cgColor
                    btn?.layer.masksToBounds = true
                    btn?.layer.shadowRadius = 0
        })
        lookupBtn.backgroundColor = .red
    }
    @objc
    func isSelectedThird(_ sender: UIButton){
        sender.setTitleColor(.red, for: .normal)
        sender.layer.borderColor = UIColor.red.cgColor
        sender.layer.masksToBounds = false
        sender.layer.shadowColor = UIColor.red.cgColor
        sender.layer.shadowOpacity = 0.3
        sender.layer.shadowOffset = CGSize(width: 0, height: 0)
        sender.layer.shadowRadius = 2
        
        let btns = [totalBtn,morningBtn, eveningBtn, nightBtn]
        btns.map({ btn in
                    btn?.setTitleColor(.systemGray, for: .normal)
                    btn?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                    btn?.backgroundColor = #colorLiteral(red: 0.9668200967, green: 0.9668200967, blue: 0.9668200967, alpha: 1)
                    btn?.layer.cornerRadius = 10
                    btn?.layer.borderWidth = 1
                    btn?.layer.borderColor = UIColor.systemGray5.cgColor
                    btn?.layer.masksToBounds = true
                    btn?.layer.shadowRadius = 0
        })
        lookupBtn.backgroundColor = .red
    }
    @objc
    func isSelectedFourth(_ sender: UIButton){
        sender.setTitleColor(.red, for: .normal)
        sender.layer.borderColor = UIColor.red.cgColor
        sender.layer.masksToBounds = false
        sender.layer.shadowColor = UIColor.red.cgColor
        sender.layer.shadowOpacity = 0.3
        sender.layer.shadowOffset = CGSize(width: 0, height: 0)
        sender.layer.shadowRadius = 2
        
        let btns = [totalBtn,morningBtn,afternoonBtn,nightBtn]
        btns.map({ btn in
                    btn?.setTitleColor(.systemGray, for: .normal)
                    btn?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                    btn?.backgroundColor = #colorLiteral(red: 0.9668200967, green: 0.9668200967, blue: 0.9668200967, alpha: 1)
                    btn?.layer.cornerRadius = 10
                    btn?.layer.borderWidth = 1
                    btn?.layer.borderColor = UIColor.systemGray5.cgColor
                    btn?.layer.masksToBounds = true
                    btn?.layer.shadowRadius = 0
        })
        lookupBtn.backgroundColor = .red
    }
    @objc
    func isSelectedFifth(_ sender: UIButton){
        sender.setTitleColor(.red, for: .normal)
        sender.layer.borderColor = UIColor.red.cgColor
        sender.layer.masksToBounds = false
        sender.layer.shadowColor = UIColor.red.cgColor
        sender.layer.shadowOpacity = 0.3
        sender.layer.shadowOffset = CGSize(width: 0, height: 0)
        sender.layer.shadowRadius = 2
        
        let btns = [totalBtn, morningBtn,afternoonBtn, eveningBtn]
        btns.map({ btn in
                    btn?.setTitleColor(.systemGray, for: .normal)
                    btn?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                    btn?.backgroundColor = #colorLiteral(red: 0.9668200967, green: 0.9668200967, blue: 0.9668200967, alpha: 1)
                    btn?.layer.cornerRadius = 10
                    btn?.layer.borderWidth = 1
                    btn?.layer.borderColor = UIColor.systemGray5.cgColor
                    btn?.layer.masksToBounds = true
                    btn?.layer.shadowRadius = 0
        })
        lookupBtn.backgroundColor = .red
    }
}

extension SelectDateTVC: UICollectionViewDelegate {
    
}

extension SelectDateTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dateCell = dateCollectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as? DateCell else {
            return UICollectionViewCell()
        }
        dateCell.setData(date: dateList[indexPath.row].date, day: dateList[indexPath.row].day)
        if indexPath.item == 0 {
            dateCell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        } else {
            dateCell.isSelected = false
        }
        
        return dateCell
    }
}

extension SelectDateTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 40, height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
