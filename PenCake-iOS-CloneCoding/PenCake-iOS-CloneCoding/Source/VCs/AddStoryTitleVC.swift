//
//  AddStoryTtitleVC.swift
//  PenCake-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/06/04.
//

import UIKit

class AddStoryTitleVC: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func dismissToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func pushToSubtitle(_ sender: Any) {
        guard let nextVC = UIStoryboard(name: "AddStorySubtitleModal", bundle: nil).instantiateViewController(withIdentifier: "AddStorySubtitleVC") as? AddStorySubtitleVC else {
            return
        }
        nextVC.titleText =
            titleTextField.text
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
