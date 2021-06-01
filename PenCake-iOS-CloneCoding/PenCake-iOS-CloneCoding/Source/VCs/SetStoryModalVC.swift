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
    @IBOutlet weak var dismissToMain: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        navigationBar.tex
        titleTextField.font = UIFont.boldSystemFont(ofSize: 17)
        detailTextView.font = UIFont.systemFont(ofSize: 14)
        //텍필뷰 선택하면 네비타이틀로 제목이 올라감.
        detailTextView.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        if indexPath == -1 {
            detailTextView.text = "내용을 입력하세요"
        } else {
             let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
             let fetchResult = PersistenceManager.shared.fetch(reqeust: request)
            titleTextField.text = fetchResult[indexPath].title
            detailTextView.text = fetchResult[indexPath].detail
        }
        
    }

    @IBAction func dismissButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name("ReloadData"), object: nil)
    }
    @IBAction func completeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        let text: String
        if titleTextField.text?.isEmpty == true {
            text = "_"
        } else {
            text = titleTextField.text!
        }
        let storyOne = Story(title: text, detail: detailTextView.text ?? "", date: "0530")
         PersistenceManager.shared.insertStory(story: storyOne)
        NotificationCenter.default.post(name: NSNotification.Name("ReloadData"), object: nil)
    }
}
