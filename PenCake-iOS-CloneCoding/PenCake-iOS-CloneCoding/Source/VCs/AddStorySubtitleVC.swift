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
    var storyList = [StoryList]()
    
    //MARK: - @IBOutlet Properties
    @IBOutlet weak var subtitleTextField: UITextField!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func dismissToTitle(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func dismissToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        subtitleText = subtitleTextField.text
        
    }
    
    
}
