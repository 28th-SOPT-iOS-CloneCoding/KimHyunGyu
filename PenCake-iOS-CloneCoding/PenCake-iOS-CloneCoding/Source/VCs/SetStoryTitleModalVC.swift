//
//  SetStoryTitleModalVC.swift
//  PenCake-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/06/02.
//

import UIKit

class SetStoryTitleModalVC: UIViewController {

    //MARK: - Properties
    var titleText: String?
    var subtitleText: String?
    
    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.text = titleText
        titleTextField.font = UIFont(name: "NanumMyeongjoBold", size: 20)
        
        subtitleTextField.text = subtitleText
        subtitleTextField.font = UIFont(name: "NanumMyeongjo", size: 15)
        // Do any additional setup after loading the view.
    }
    @IBAction func dismissToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
