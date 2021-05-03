//
//  DetailVC.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/29.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9490196078, blue: 0.9725490196, alpha: 1)
        
        setNavigationBar()
        
        registerCell()
    }
    
    //MARK: - Methods
    func setNavigationBar() {
        navigationItem.title = "세부사항"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func registerCell() {
        let calendarCell = UINib(nibName: "DateDetailReminderCell", bundle: nil)
        tableView.register(calendarCell, forCellReuseIdentifier: DateDetailReminderCell.identifier)
        
        let locationCell = UINib(nibName: "LocationDetailReminderCell", bundle: nil)
        tableView.register(locationCell, forCellReuseIdentifier: LocationDetailReminderCell.identifier)
        
        let priorityCell = UINib(nibName: "PriorityDetailReminderCell", bundle: nil)
        tableView.register(priorityCell, forCellReuseIdentifier: PriorityDetailReminderCell.identifier)
    }
}

//MARK: - UITableViewDelegates

extension DetailVC: UITableViewDelegate{}

//MARK: - UITableViewDatasource

extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let dateCell = tableView.dequeueReusableCell(withIdentifier: DateDetailReminderCell.identifier, for: indexPath) as? DateDetailReminderCell else {
                return UITableViewCell()
            }
            dateCell.selectionStyle = .none
            
            return dateCell
        } else if indexPath.section == 1 {
            guard let locationCell = tableView.dequeueReusableCell(withIdentifier: LocationDetailReminderCell.identifier, for: indexPath) as? LocationDetailReminderCell else {
                return UITableViewCell()
            }
            locationCell.selectionStyle = .none
            
            return locationCell
        } else if indexPath.section == 2 {
            guard let priorityCell = tableView.dequeueReusableCell(withIdentifier: PriorityDetailReminderCell.identifier, for: indexPath) as? PriorityDetailReminderCell else {
                return UITableViewCell()
            }
            priorityCell.accessoryType = .disclosureIndicator
            
            return priorityCell
        } else { return UITableViewCell() }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        } else { return 60 }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
}
