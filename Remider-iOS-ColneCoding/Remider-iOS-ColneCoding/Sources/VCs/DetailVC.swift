//
//  DetailVC.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/29.
//

import UIKit

class DetailVC: UIViewController {

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }
    
    //MARK: - Methods
    func setNavigationBar() {
        navigationItem.title = "세부사항"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
}
