//
//  AddListViewController.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/16.
//

import Foundation
import UIKit

class AddListViewController: UIViewController {
    
    //MARK: - Properties
    
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
        
        self.presentationController?.delegate = self
        
        setListBulletBtn()
        setTextField()
        
        colorBtns = [redListBtn,orangeListBtn, yellowListBtn, greenListBtn, blueListBtn, violletListBtn, brownListBtn]
        
        setColorListBtn(colorBtns)
        textField.delegate = self
    }
    
    //MARK: - @IBAction Properties
    
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
    
    //텍스트필드 차면 버튼 활성화
//    @IBAction func textFieldValueChanged(_ sender: UITextField) {
//        if textField.text?.isEmpty == true {
//            saveBtn.isEnabled = true
//        } else {
//            saveBtn.isEnabled = false
//        }
//    }
    
    //MARK: - Methods
    
    private func setListBulletBtn() {
        listBulletBtn.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        listBulletBtn.layer.cornerRadius = listBulletBtn.frame.height/2
        listBulletBtn.setPreferredSymbolConfiguration(.init(pointSize: 30, weight: .bold, scale: .large), forImageIn: .normal)
        
        listBulletBtn.layer.shadowColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        listBulletBtn.layer.shadowOpacity = 0.7
        listBulletBtn.layer.shadowOffset = CGSize.zero
        listBulletBtn.layer.shadowRadius = 8
        listBulletBtn.isUserInteractionEnabled = false
    }
    private func setTextField() {
        textField.borderStyle = .none
        textField.layer.cornerRadius = textField.frame.height/4
    }
    private func setColorListBtn(_ btns: [UIButton]) {
        colorBtns.map{ $0.layer.cornerRadius = $0.frame.width / 2 }
        colorBtns.map{ $0.addTarget(self, action: #selector(setImageColor), for: .touchUpInside)}
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
