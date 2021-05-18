//
//  mainVC.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/18.
//

import Foundation
import UIKit

class MainVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBtn = UIBarButtonItem(title: "영화", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBtn
        
    }
    @IBAction func touchMoreBtn(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MoreVC") as? MoreVC else{
            return
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
