//
//  EditListVC.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/29.
//

import UIKit

class EditListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setNavigationBar()
        registerCell()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func setNavigationBar() {
        self.navigationItem.title = "목록"
    }
    
    func registerCell() {
        let nibCell = UINib(nibName: "DetailEditListCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: DetailEditListCell.identifier)
    }
}

extension EditListVC: UITableViewDelegate {
    
}
extension EditListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailEditListCell.identifier, for: indexPath) as? DetailEditListCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
}
