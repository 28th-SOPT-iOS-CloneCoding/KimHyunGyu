//
//  AddStroySubtitleVC.swift
//  PenCake-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/06/04.
//

import UIKit

class AddStorySubtitleVC: UIViewController {
    
    // MARK: - Properties
    var titleText: String?
    var subtitleText: String?
    var list = List(storyDetail: "", storyName: "")
    
    //MARK: - @IBOutlet Properties
    @IBOutlet weak var subtitleTextField: UITextField!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - @IBAction Methods
    @IBAction func dismissToTitle(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func dismissToMain(_ sender: Any) {
        if subtitleTextField.text?.isEmpty == true {
            makeAlert(title: "", message: "소제목을 입력해주세요")
        } else {
            if let titleText = titleText, let subTitle = subtitleTextField.text {
                list.storyName = titleText
                list.storyDetail = subTitle
                PersistenceManager.shared.insertStoryList(list: list)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ReloadStoryList"), object: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
}
