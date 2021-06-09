//
//  StoryCellDetailVC.swift
//  PenCake-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/05/30.
//

import UIKit
import CoreData

class StoryCellDetailVC: UIViewController {
    // MARK: - Properties
    var titleText: String = ""
    var dateText: String = ""
    var detailText: String = ""
    var indexPath: Int = 0
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
        setNotification()
    }
    
    // MARK: - @objc Methods
    @objc func reloadData() {
        let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
        let fetchResult = PersistenceManager.shared.fetch(reqeust: request)
        titleButton.setTitle(fetchResult[self.indexPath].title, for: .normal)
        // 날짜 애교
        detailLabel.text = fetchResult[self.indexPath].detail
    }
    
    
    // MARK: - Methods
    private func deleteStory() {
        let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
        let fetchResult = PersistenceManager.shared.fetch(reqeust: request)
        PersistenceManager.shared.delete(object: fetchResult[self.indexPath])
        self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name("ReloadData"), object: nil)
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name("ReloadData"), object: nil)
    }
    
    private func setUI() {
        titleButton.setTitleColor(.black, for: .normal)
        titleButton.titleLabel?.font = UIFont.init(name: "NanumMyeongjoBold", size: 22)
        dateLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        dateLabel.font = UIFont.init(name: "NanumMyeongjo", size: 14)
        detailLabel.font = UIFont.init(name: "NanumMyeongjo", size: 15)
        
        let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
        let fetchResult = PersistenceManager.shared.fetch(reqeust: request)
        titleButton.setTitle(fetchResult[self.indexPath].title, for: .normal)
        
        if let date = fetchResult[self.indexPath].date {
            
            // 2021년 6월 9일 수 오전 12:40
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 M월 d일 E a h:mm"
            dateFormatter.locale = Locale(identifier: "ko_KR")
            let dateStr = dateFormatter.string(from: date)
            dateLabel.text = dateStr

        }
        detailLabel.text = fetchResult[self.indexPath].detail
    }
    
    // MARK: - @IBAction Properties
    @IBAction func eidtButtonClicked(_ sender: Any) {
        guard let nextVC = UIStoryboard.init(name: "SetStoryModal", bundle: nil).instantiateViewController(withIdentifier: "SetStoryModalVC") as? SetStoryModalVC else {
            return
        }
        
        nextVC.modalPresentationStyle = .overFullScreen
        nextVC.index = indexPath
        self.present(nextVC, animated: true, completion: nil)
    }
    @IBAction func popToMain(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func popupButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let edit = UIAlertAction(title: "글 수정", style: .default) {
             _ in
            guard let nextVC = UIStoryboard.init(name: "SetStoryModal", bundle: nil).instantiateViewController(withIdentifier: "SetStoryModalVC") as? SetStoryModalVC else {
                return
            }
            
            nextVC.modalPresentationStyle = .overFullScreen
            nextVC.index = self.indexPath
            self.present(nextVC, animated: true, completion: nil)
        }
        let dismiss = UIAlertAction(title: "글 삭제", style: .destructive) {
            _ in
            self.makeRequestAlert(title: "", message: "정말 삭제하시겠습니까?", okAction: {_ in
                self.deleteStory()
            }, completion: nil)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(edit)
        alert.addAction(dismiss)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
