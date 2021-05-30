//
//  SetStoryModalVC.swift
//  PenCake-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/05/30.
//

import UIKit

class SetStoryModalVC: UIViewController {
    
    //MARK: - @IBOutlet Properties
    @IBOutlet weak var dismissToMain: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        navigationBar.tex
        titleTextField.font = UIFont.boldSystemFont(ofSize: 17)
        detailTextView.font = UIFont.systemFont(ofSize: 14)
        //텍필뷰 선택하면 네비타이틀로 제목이 올라감.
        detailTextView.text = "내용을 입력하세요"
        detailTextView.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }

    @IBAction func dismissButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        
        
        
    }
}
