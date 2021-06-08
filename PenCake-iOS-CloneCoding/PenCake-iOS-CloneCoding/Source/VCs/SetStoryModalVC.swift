//
//  SetStoryModalVC.swift
//  PenCake-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/05/30.
//

import UIKit
import CoreData

class SetStoryModalVC: UIViewController {
    
    //MARK: - Properties
    var indexPath : Int = -1
    
    //MARK: - @IBOutlet Properties
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var completeButton: UIButton!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        if indexPath == -1 {
            detailTextView.text = "내용을 입력하세요"
        } else {
             let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
             let fetchResult = PersistenceManager.shared.fetch(reqeust: request)
            titleTextField.text = fetchResult[indexPath].title
            detailTextView.text = fetchResult[indexPath].detail
        }
        
    }

    private func setUI() {
        dismissButton.setTitle("취소", for: .normal)
        dismissButton.titleLabel?.font = UIFont.init(name: "NanumMyeongjo", size: 15)
        dismissButton.tintColor = .systemGray3
        
        completeButton.setTitle("완료", for: .normal)
        completeButton.titleLabel?.font = UIFont.init(name: "NanumMyeongjo", size: 15)
        completeButton.tintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        titleTextField.font = UIFont.init(name: "NanumMyeongjoBold", size: 20)
        detailTextView.font = UIFont.init(name: "NanumMyeongjo", size: 15)
        //텍필뷰 선택하면 네비타이틀로 제목이 올라감.
        detailTextView.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    @IBAction func dismissButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name("ReloadData"), object: nil)
    }
    @IBAction func completeButtonClicked(_ sender: Any) {
        let text: String
        if titleTextField.text?.isEmpty == true {
            text = "_"
        } else {
            text = titleTextField.text!
        }
        if indexPath == -1 {
            let storyOne = Story(title: text, detail: detailTextView.text ?? "", date: "0530")
             PersistenceManager.shared.insertStory(story: storyOne)
            
            NotificationCenter.default.post(name: NSNotification.Name("ReloadData"), object: nil)
        } else {
            let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
            let updateStory = Story(title: text, detail: detailTextView.text ?? "", date: "0530")
            PersistenceManager.shared.updateStory(reqeust: request, index: indexPath, story: updateStory)
            
            NotificationCenter.default.post(name: NSNotification.Name("ReloadData"), object: nil)
        }
        self.dismiss(animated: true, completion: nil)
        
    }
}
