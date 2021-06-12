//
//  AddStoryTtitleVC.swift
//  PenCake-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/06/04.
//

import UIKit

class AddStoryTitleVC: UIViewController {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var titleTextField: UITextField!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        // Do any additional setup after loading the view.
    }
    
    // MARK: - @IBAction Methods
    @IBAction func dismissToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func pushToSubtitle(_ sender: Any) {
        if titleTextField.text?.isEmpty == false {
            guard let nextVC = UIStoryboard(name: "AddStorySubtitleModal", bundle: nil).instantiateViewController(withIdentifier: "AddStorySubtitleVC") as? AddStorySubtitleVC else {
                return
            }
            
            nextVC.titleText =
                titleTextField.text
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else {
            makeAlert(title: "", message: "제목을 입력해주세요")
        }
    }
    
}
