//
//  ScheduleListTopCell.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/28.
//

import UIKit

class ScheduleListTopCell: UITableViewCell {

    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    
    //MARK: - Properties
    
    static let identifier = "ScheduleListTopCell"
    
    //MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setTextView()
        setTextField()
        
        textField.delegate = self
        textView.delegate = self
    }
    
    //MARK: - Methods
    
    private func setTextField() {
        textField.placeholder = "제목"
        textField.font = UIFont.systemFont(ofSize: 17)
    }
    
    private func setTextView() {
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.text = "메모"
        textView.textColor = #colorLiteral(red: 0.7647058824, green: 0.7647058824, blue: 0.7725490196, alpha: 1)
        textView.textContainerInset = .init(top: 8, left: -5, bottom: 0, right: 0)
//        textView.textContainerInset = .zero
    }
    
    private func setTrueNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("titleNotEmpty"), object: true)
    }
    private func setFalseNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("titleEmpty"), object: false)
    }
    
    //MARK: - textViewMethods
    private func setTextViewPlaceholder() {
        if textView.text == "" {
            textView.text = "메모"
            textView.textColor = UIColor.lightGray
        } else if textView.text == "메모"{
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: - UITextFieldDelegate

extension ScheduleListTopCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        //if text is not empty send notification
        if !text.isEmpty {
            setTrueNotification()
        } else {
            setFalseNotification()
        }
        return true
    }
}

//MARK: - UITextViewDelegateS

extension ScheduleListTopCell: UITextViewDelegate {
    //textView 편집 시작
    func textViewDidBeginEditing(_ textView: UITextView) {
        setTextViewPlaceholder()
    }
    
    //textView 편집 끝
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            setTextViewPlaceholder()
        }
    }
}
