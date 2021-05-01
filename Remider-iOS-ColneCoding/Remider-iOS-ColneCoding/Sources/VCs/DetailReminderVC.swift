//
//  DetailReminderVC.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/01.
//

import UIKit

class DetailReminderVC: UIViewController {

    static let identifier = "DetailReminderVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        // Do any additional setup after loading the view.
        
    }
    
    func setNavigationBar() {
        navigationItem.title = "세부사항"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(touchBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: nil)
    }
    
    @objc
    func touchBack() {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
