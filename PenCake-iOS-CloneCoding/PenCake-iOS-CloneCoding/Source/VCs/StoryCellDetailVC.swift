//
//  StoryCellDetailVC.swift
//  PenCake-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/05/30.
//

import UIKit
import CoreData

class StoryCellDetailVC: UIViewController {
    //MARK: - Properties
    var titleText: String = ""
    var dateText: String = ""
    var detailText: String = ""
    var indexPath: Int = 0
    
    //MARK: - @IBOutlet Properties
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
        
    }
    
    //MARK: - Properties
    func setUI() {
        titleButton.setTitleColor(.black, for: .normal)
        titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        dateLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.font = UIFont.systemFont(ofSize: 15)
        
        let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
        let fetchResult = PersistenceManager.shared.fetch(reqeust: request)
       titleButton.setTitle(fetchResult[self.indexPath].title, for: .normal)
       dateLabel.text = fetchResult[self.indexPath].date
       detailLabel.text = fetchResult[self.indexPath].detail
    }
    
    //MARK: - @IBAction Properties
    @IBAction func eidtButtonClicked(_ sender: Any) {
        guard let nextVC = UIStoryboard.init(name: "SetStoryModal", bundle: nil).instantiateViewController(withIdentifier: "SetStoryModalVC") as? SetStoryModalVC else {
            return
        }
        
        nextVC.modalPresentationStyle = .overFullScreen
        nextVC.indexPath = indexPath
        self.present(nextVC, animated: true, completion: nil)
    }
    @IBAction func popupButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let edit = UIAlertAction(title: "글 수정", style: .default) {
             _ in
            guard let nextVC = UIStoryboard.init(name: "SetStoryModal", bundle: nil).instantiateViewController(withIdentifier: "SetStoryModalVC") as? SetStoryModalVC else {
                return
            }
            
            nextVC.modalPresentationStyle = .overFullScreen
            nextVC.indexPath = self.indexPath
            self.present(nextVC, animated: true, completion: nil)
        }
        let dismiss = UIAlertAction(title: "글 삭제", style: .destructive) {
            _ in
            let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
            let fetchResult = PersistenceManager.shared.fetch(reqeust: request)
            PersistenceManager.shared.delete(object: fetchResult[self.indexPath])
            self.navigationController?.popViewController(animated: true)
            NotificationCenter.default.post(name: NSNotification.Name("ReloadData"), object: nil)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(edit)
        alert.addAction(dismiss)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
