//
//  ReservationVC.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/21.
//

import UIKit

class ReservationVC: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - @IBOutlet Properties
    @IBOutlet weak var nowReservationLabel: UILabel!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setRegister()
//        self.view.backgroundColor?.withAlphaComponent(0.2)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
//        tableView.isUserInteractionEnabled = false
    }
    
    @IBAction func closeModalBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Methods
}

extension ReservationVC {
    private func setUI() {
        modalView.layer.cornerRadius = 18
        nowReservationLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    private func setRegister() {
        let theaterCell = UINib(nibName: "SelectTheaterTVC", bundle: nil)
        tableView.register(theaterCell, forCellReuseIdentifier: "SelectTheaterTVC")
        
        let locationCell = UINib(nibName: "SelectLocationTVC", bundle: nil)
        tableView.register(locationCell, forCellReuseIdentifier: "SelectLocationTVC")
        
        let dateCell = UINib(nibName: "SelectDateTVC", bundle: nil)
        tableView.register(dateCell, forCellReuseIdentifier: "SelectDateTVC")
    }
}

//MARK: - UITableViewDelegates
extension ReservationVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableView.automaticDimension
        } else if indexPath.row == 1 {
            return 70
        } else {
            return 270
        }
    }
}
//MARK: - UITableViewDataSources
extension ReservationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let theaterCell = tableView.dequeueReusableCell(withIdentifier: "SelectTheaterTVC") as? SelectTheaterTVC else {
                return UITableViewCell()
            }
            theaterCell.selectionStyle = .none
            return theaterCell
        } else if indexPath.row == 1 {
            guard let locationCell = tableView.dequeueReusableCell(withIdentifier: "SelectLocationTVC") as? SelectLocationTVC else {
                return UITableViewCell()
            }
            locationCell.selectionStyle = .none
            return locationCell
        } else {
            guard let dateCell = tableView.dequeueReusableCell(withIdentifier: "SelectDateTVC") as? SelectDateTVC else {
                return UITableViewCell()
            }
            dateCell.selectionStyle = .none
            return dateCell
        }
    }
}
