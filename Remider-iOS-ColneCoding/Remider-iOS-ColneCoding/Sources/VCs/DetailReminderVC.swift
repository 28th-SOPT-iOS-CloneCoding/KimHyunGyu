//
//  DetailReminderVC.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/01.
//

import UIKit

class DetailReminderVC: UIViewController {

    //MARK : - Properties
    
    static let identifier = "DetailReminderVC"
    
    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9490196078, blue: 0.9725490196, alpha: 1)
        
        registerCell()
        
    }
    
    private func registerCell() {
        let titleCell = UINib(nibName: "TitleDetailReminderCell", bundle: nil)
        tableView.register(titleCell, forCellReuseIdentifier: TitleDetailReminderCell.identifier)
        
        let calendarCell = UINib(nibName: "DateDetailReminderCell", bundle: nil)
        tableView.register(calendarCell, forCellReuseIdentifier: DateDetailReminderCell.identifier)
        
        let repeatCell = UINib(nibName: "RepeatDetailReminderCell", bundle: nil)
        tableView.register(repeatCell, forCellReuseIdentifier: RepeatDetailReminderCell.identifier)
        
        let locationCell = UINib(nibName: "LocationDetailReminderCell", bundle: nil)
        tableView.register(locationCell, forCellReuseIdentifier: LocationDetailReminderCell.identifier)
        
        let priorityCell = UINib(nibName: "PriorityDetailReminderCell", bundle: nil)
        tableView.register(priorityCell, forCellReuseIdentifier: PriorityDetailReminderCell.identifier)
        
        let listCell = UINib(nibName: "ListDetailReminderCell", bundle: nil)
        tableView.register(listCell, forCellReuseIdentifier: ListDetailReminderCell.identifier)
    }
    
    func setNavigationBar() {
        navigationItem.title = "세부사항"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(touchBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: nil)
    }
    
    @objc
    func touchBack() {
        dismiss(animated: true, completion: nil)
    }

}

//MARK: - UITableViewDelegates

extension DetailReminderVC: UITableViewDelegate{}

//MARK: - UITableViewDatasource

extension DetailReminderVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let titleCell = tableView.dequeueReusableCell(withIdentifier: TitleDetailReminderCell.identifier, for: indexPath) as? TitleDetailReminderCell else {
                return UITableViewCell()
            }
            titleCell.selectionStyle = .none
    
            return titleCell
        } else if indexPath.section == 1 {
            guard let dateCell = tableView.dequeueReusableCell(withIdentifier: DateDetailReminderCell.identifier, for: indexPath) as? DateDetailReminderCell else {
                return UITableViewCell()
            }
            dateCell.selectionStyle = .none
            
            return dateCell
        } else if indexPath.section == 2 {
            guard let repeatCell = tableView.dequeueReusableCell(withIdentifier: RepeatDetailReminderCell.identifier, for: indexPath) as? RepeatDetailReminderCell else {
                return UITableViewCell()
            }
            repeatCell.accessoryType = .disclosureIndicator
            
            return repeatCell
        } else if indexPath.section == 3 {
            guard let locationCell = tableView.dequeueReusableCell(withIdentifier: LocationDetailReminderCell.identifier, for: indexPath) as? LocationDetailReminderCell else {
                return UITableViewCell()
            }
            locationCell.selectionStyle = .none
            
            return locationCell
        } else if indexPath.section == 4 {
            if indexPath.row == 0{
                guard let priorityCell = tableView.dequeueReusableCell(withIdentifier: PriorityDetailReminderCell.identifier, for: indexPath) as? PriorityDetailReminderCell else {
                    return UITableViewCell()
                }
                priorityCell.accessoryType = .disclosureIndicator
                
                return priorityCell
            } else {
                guard let listCell = tableView.dequeueReusableCell(withIdentifier: ListDetailReminderCell.identifier, for: indexPath) as? ListDetailReminderCell else {
                    return UITableViewCell()
                }
                listCell.accessoryType = .disclosureIndicator
                
                return listCell
            }
        }
        else { return UITableViewCell() }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 1 {
            return 120
        } else { return 60 }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
}
