//
//  AddListViewController.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/16.
//

import Foundation
import UIKit
import RealmSwift

class AddListViewController: UIViewController {
    
    //MARK: - Properties
    
    var realm: Realm?
    
    var textFieldTitle = ""
    var listBulletBtnColor = ""
    
    var colorChangeCount = 0
    var listTitle: String?
    var colorBtns = [UIButton]()
    var hasChanges: Bool {
        return textField.text != "" || colorChangeCount != 0
    }
    
    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var brownListBtn: UIButton!
    @IBOutlet weak var violletListBtn: UIButton!
    @IBOutlet weak var blueListBtn: UIButton!
    @IBOutlet weak var greenListBtn: UIButton!
    @IBOutlet weak var yellowListBtn: UIButton!
    @IBOutlet weak var orangeListBtn: UIButton!
    @IBOutlet weak var redListBtn: UIButton!
    @IBOutlet weak var listBulletBtn: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewWillLayoutSubviews() {
        if #available(iOS 13.0, *) {
            self.isModalInPresentation = self.hasChanges
        } else {
            //Fallback on earlier versions
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try? Realm()
        
        self.presentationController?.delegate = self
        
        setListBulletBtn()
        setTextField()
        
        colorBtns = [redListBtn,orangeListBtn, yellowListBtn, greenListBtn, blueListBtn, violletListBtn, brownListBtn]
        
        setColorListBtn(colorBtns)
        textField.delegate = self
    }
    
    //MARK: - @IBAction Properties
    
    @IBAction func touchSaveBtn(_ sender: UIButton) {
        
        //realm update 설정
        
        try! realm?.write {
            realm?.add(inputData(database: ListModel()))
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchCancelBtn(_ sender: UIButton) {
        if hasChanges {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let dismiss = UIAlertAction(title: "변경 사항 폐기", style: .destructive) { _ in
                //Hide keyboard
                self.resignFirstResponder()
                self.dismiss(animated: true, completion: nil)
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(dismiss)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: - Methods
    
    private func setListBulletBtn() {
        if listBulletBtnColor.isEmpty {
            listBulletBtn.backgroundColor = .systemBlue
            listBulletBtn.layer.shadowColor = listBulletBtn.backgroundColor?.cgColor
        } else {
            listBulletBtn.backgroundColor = UIColor(hex: listBulletBtnColor)
            listBulletBtn.layer.shadowColor = UIColor(hex: listBulletBtnColor).cgColor
        }
        listBulletBtn.layer.cornerRadius = listBulletBtn.frame.height/2
        listBulletBtn.setPreferredSymbolConfiguration(.init(pointSize: 30, weight: .bold, scale: .large), forImageIn: .normal)
        
        listBulletBtn.layer.shadowOpacity = 0.7
        listBulletBtn.layer.shadowOffset = CGSize.zero
        listBulletBtn.layer.shadowRadius = 8
        listBulletBtn.isUserInteractionEnabled = false
    }
    private func setTextField() {
        textField.text = self.textFieldTitle
        textField.borderStyle = .none
        textField.layer.cornerRadius = textField.frame.height/4
    }
    private func setColorListBtn(_ btns: [UIButton]) {
        colorBtns.map{ $0.layer.cornerRadius = $0.frame.width / 2 }
        colorBtns.map{ $0.addTarget(self, action: #selector(setImageColor), for: .touchUpInside)}
    }
    
    func inputData(database: ListModel) -> ListModel {
        if let text = textField.text {
            database.reminderTitle = text
        }
        if let color = listBulletBtn.backgroundColor {
            database.reminderColor = color.toHexString()
            print(database.reminderColor)
        }
        
        return database
    }
    
    //MARK: - @objc methods
    
    @objc func setImageColor(button btn: UIButton) {
        listBulletBtn.backgroundColor = btn.backgroundColor
        listBulletBtn.layer.shadowColor = btn.backgroundColor?.cgColor
        self.colorChangeCount += 1
        isModalInPresentation = true
    }
}

//MARK: - UIAdaptivePresentationControllerDelegate

extension AddListViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        print("presentationControllerDidAttemptToDismiss")
        if hasChanges {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let dismiss = UIAlertAction(title: "변경 사항 폐기", style: .destructive) { _ in
                //Hide keyboard

                self.resignFirstResponder()
                self.dismiss(animated: true, completion: nil)
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(dismiss)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: - UITextFieldDelegates

extension AddListViewController: UITextFieldDelegate {
    //notification
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty {
            saveBtn.isEnabled = true
        } else {
            saveBtn.isEnabled = false
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        saveBtn.isEnabled = false
        return true
    }
}
