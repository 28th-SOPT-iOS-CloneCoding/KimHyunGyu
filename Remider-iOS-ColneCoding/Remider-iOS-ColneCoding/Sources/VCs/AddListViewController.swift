//
//  AddListViewController.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/16.
//

import Foundation
import UIKit

class AddListViewController: UIViewController {
    @IBOutlet weak var listBulletBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setListBulletBtn()
    }
    
    //MARK: - @IBAction Properties
    
    @IBAction func touchCancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Methods
    
    private func setListBulletBtn() {
        listBulletBtn.backgroundColor = .systemBlue
        listBulletBtn.layer.cornerRadius = listBulletBtn.frame.height/2
        listBulletBtn.setPreferredSymbolConfiguration(.init(pointSize: 30, weight: .bold, scale: .large), forImageIn: .normal)
    }
}
