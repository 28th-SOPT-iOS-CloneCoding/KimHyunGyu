//
//  ScheduleListVC.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/16.
//

import UIKit

class ScheduleListVC: UIViewController {
    
    //MARK: - Properties
    
    var hasChanges = false
    
    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //navigation bar
        setNavigationBar()
        registerCell()
        
        //notificationCenter
        setTrueNotification()
        setFalseNotification()
        
        self.navigationController?.presentationController?.delegate = self
        isModalInPresentation = true
    }
    
    //MARK: - @IBAction Properties
    
    
    //MARK: - Methods
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(touchBackBtn))
        navigationItem.title = "새로운 미리 알림"
    }
    private func registerCell() {
        let topCell = UINib(nibName: "ScheduleListTopCell", bundle: nil)
        tableView.register(topCell, forCellReuseIdentifier: ScheduleListTopCell.identifier)
        
        let middleCell = UINib(nibName: "DetailCell", bundle: nil)
        tableView.register(middleCell, forCellReuseIdentifier: DetailCell.identifier)
        
        let bottomCell = UINib(nibName: "EditListCell", bundle: nil)
        tableView.register(bottomCell, forCellReuseIdentifier: EditListCell.identifier)
        
    }

    //MARK: - @objc Methods
    @objc
    func touchBackBtn() {
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
    
    //notification handler
    
    @objc
    func setHasChangesTrue(notification: NSNotification) {
        if let trueBool = notification.object as? Bool {
            self.navigationItem.rightBarButtonItem?.isEnabled = trueBool
            hasChanges = trueBool
        } else { return }
    }
    
    @objc
    func setHasChangesFalse(notification: NSNotification) {
        if let falseBool = notification.object as? Bool {
            self.navigationItem.rightBarButtonItem?.isEnabled = falseBool
//            hasChanges = trueBool
        } else { return }
    }
    
    
}

//MARK: - NotificationCenter

extension ScheduleListVC {
    private func setTrueNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setHasChangesTrue(notification:)),
                                               name: NSNotification.Name("titleNotEmpty"),
                                               object: nil)
    }
    private func setFalseNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setHasChangesFalse(notification:)),
                                               name: NSNotification.Name("titleEmpty"),
                                               object: nil)
    }
}

//MARK: - UIAdaptivePresentationControllerDelegate

extension ScheduleListVC: UIAdaptivePresentationControllerDelegate {
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

//MARK: - UITableViewDelegates

extension ScheduleListVC: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSources

extension ScheduleListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") else {
                return
            }
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        else if indexPath.section == 2 {
            guard let editListVC = self.storyboard?.instantiateViewController(withIdentifier: "EditListVC") else {
                return
            }
            self.navigationController?.pushViewController(editListVC, animated: true)
        } else { return }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else { return 50 }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let topCell = tableView.dequeueReusableCell(withIdentifier: ScheduleListTopCell.identifier, for: indexPath) as? ScheduleListTopCell else {
                return UITableViewCell()
            }
            topCell.selectionStyle = .none
    
            return topCell
        } else if indexPath.section == 1 {
            guard let middleCell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath) as? DetailCell else {
                return UITableViewCell()
            }
            middleCell.accessoryType = .disclosureIndicator
            
            return middleCell
        } else {
            guard let bottomCell = tableView.dequeueReusableCell(withIdentifier: EditListCell.identifier, for: indexPath) as? EditListCell else {
                return UITableViewCell()
            }
            bottomCell.accessoryType = .disclosureIndicator
            
            return bottomCell
        }
    }
}
