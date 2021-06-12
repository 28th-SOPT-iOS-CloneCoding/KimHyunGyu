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
    var index : Int = -1
    
    //MARK: - @IBOutlet Properties
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var completeButton: UIButton!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    // MARK: - Methods
    private func setUI() {
        detailTextView.delegate = self
        
        dismissButton.setTitle("취소", for: .normal)
        dismissButton.titleLabel?.font = UIFont.init(name: "NanumMyeongjo", size: 15)
        dismissButton.tintColor = .systemGray3
        
        completeButton.setTitle("완료", for: .normal)
        completeButton.titleLabel?.font = UIFont.init(name: "NanumMyeongjo", size: 15)
        completeButton.tintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        titleTextField.font = UIFont.init(name: "NanumMyeongjoBold", size: 20)
        detailTextView.font = UIFont.init(name: "NanumMyeongjo", size: 15)
        detailTextView.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        if index == -1 {
            detailTextView.text = "내용을 입력하세요"
        } else {
             let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
             let fetchResult = PersistenceManager.shared.fetch(reqeust: request)
            titleTextField.text = fetchResult[index].title
            detailTextView.text = fetchResult[index].detail
            detailTextView.textColor = .black
        }
    }
    
    private func setTextViewPlaceholder() {
        if self.detailTextView.text == "내용을 입력하세요" {
            detailTextView.text = ""
            detailTextView.textColor = UIColor.black
        }
    }
    
    @IBAction func dismissButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name("ReloadMain"), object: nil)
    }
    @IBAction func completeButtonClicked(_ sender: Any) {
        let text: String
        if titleTextField.text?.isEmpty == true {
            text = "_"
        } else {
            text = titleTextField.text!
        }
        if index == -1 {
            let date = Date()
            let storyOne = Story(title: text, detail: detailTextView.text ?? "", date: date)
             PersistenceManager.shared.insertStory(story: storyOne)
            NotificationCenter.default.post(name: NSNotification.Name("ReloadMain"), object: nil)
        } else {
            let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
            let updateStory = Story(title: text, detail: detailTextView.text ?? "", date: Date())
            PersistenceManager.shared.updateStory(reqeust: request, index: index, story: updateStory)
            NotificationCenter.default.post(name: NSNotification.Name("ReloadData"), object: nil)
        }
        self.dismiss(animated: true, completion: nil)
        
    }
}
extension SetStoryModalVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        setTextViewPlaceholder()
    }
}
