//
//  ScheduleListVC.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/16.
//

import UIKit

class ScheduleListVC: UIViewController {
    
    //MARK: - Properties
    
    var hasChanges: Bool {
        return true
    }
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presentationController?.delegate = self
        isModalInPresentation = true
    }
}

//MARK: - UIAdaptivePresentationControllerDelegate

extension ScheduleListVC: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        print("presentationControllerDidAttemptToDismiss")
        if true {
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
