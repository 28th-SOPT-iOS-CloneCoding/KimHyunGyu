//
//  AddVC.swift
//  PenCake-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/06/01.
//

import UIKit

class AddVC: UIViewController {

    // MARK: - Properties
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addButton.setPreferredSymbolConfiguration(.init(pointSize: 70, weight: .thin, scale: .default), forImageIn: .normal)
        textLabel.font = UIFont.init(name: "NanumMyeongjo", size: 14)
        textLabel.text = "+를 눌러서 새 이야기를 시작하세요"
        textLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
    //새로운 페이지뷰컨생성
    }
    

}
