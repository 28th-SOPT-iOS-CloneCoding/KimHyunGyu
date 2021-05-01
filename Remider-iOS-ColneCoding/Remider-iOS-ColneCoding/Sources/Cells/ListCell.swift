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
    
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var reminderField: UITextField!
    
    
    //MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reminderField.delegate = self
        setInfoBtn()
        
    }

    func setInfoBtn() {
        infoBtn.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func touchInfoBtn(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("touchInfo"), object: nil)
        
        
    }
    
}
extension ListCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        infoBtn.isHidden = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        infoBtn.isHidden = true
    }
}
