//
//  ListCell.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/26.
//

import Foundation
import UIKit

class ListCell: UITableViewCell {

    //MARK: - Properties
    
    static let identifier = "ListCell"
    
    
    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var reminderField: UITextField!
    
    
    //MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reminderField.delegate = self
        reminderField.inputAccessoryView = setToolbar()
        setInfoBtn()
        
        //notification
        completeBtnNotification()
        
        setSelectImageView()
    }

    private func setToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        //resize
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let calendarBarBtn = UIBarButtonItem(image: UIImage(systemName: "calendar.badge.clock"), style: .plain, target: self, action: nil)
        
        let locationBarBtn = UIBarButtonItem(image: UIImage(systemName: "location"), style: .plain, target: self, action: nil)
        
        let flagBarBtn = UIBarButtonItem(image: UIImage(systemName: "flag"), style: .plain, target: self, action: nil)
        flagBarBtn.isEnabled = false
        
        let cameraBarBtn = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: nil)
        cameraBarBtn.isEnabled = false
        
        toolbar.items = [calendarBarBtn, flexibleSpace, locationBarBtn, flexibleSpace, flagBarBtn, flexibleSpace, cameraBarBtn]
        
        return toolbar
    }
    
    private func setSelectImageView() {
//        selectImageView.image = UIImage(systemName: "largecircle.fill.circle")
        selectImageView.image = UIImage(systemName: "circle")
        selectImageView.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        
        selectImageView.isUserInteractionEnabled = true
        let touchGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(setLargeCircleImageView))
        selectImageView.addGestureRecognizer(touchGestureRecognizer)
    }
    
    private func setInfoBtn() {
        infoBtn.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func touchInfoBtn(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("touchInfo"), object: nil)
    }
        
    //MARK: - @objc Methods
        
    @objc
    func setLargeCircleImageView() {
        if selectImageView.image == UIImage(systemName: "circle") {
            selectImageView.image = UIImage(systemName: "largecircle.fill.circle")
            selectImageView.tintColor = .systemBlue
        } else {
            selectImageView.image = UIImage(systemName: "circle")
            selectImageView.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
        
    @objc
    func setInfoBtnFalse() {
        setInfoBtn()
        reminderField.resignFirstResponder()
    }
    
}
extension ListCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        infoBtn.isHidden = false
        NotificationCenter.default.post(name: NSNotification.Name("BeginEditing"), object: nil)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        infoBtn.isHidden = true
        NotificationCenter.default.post(name: NSNotification.Name("EndEditing"), object: nil)
    }
}

extension ListCell {
    private func completeBtnNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(setInfoBtnFalse), name: NSNotification.Name("SelectCompleteBtn"), object: nil)
    }
}
