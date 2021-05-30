//
//  ViewController.swift
//  PenCake-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/05/27.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    // MARK: - Properties
//    var persistenceManager = PersistenceManager()
    var storyList = [StoryModel]()
    var refreshControl = UIRefreshControl()
    
    // MARK: - @IBOutlet Properteis
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectTableView()
        fetchCoreData()
    }
    
    @objc
    func presentMoadal() {
        let nextVC = UIStoryboard.init(name: "SetStoryModal", bundle: nil).instantiateViewController(withIdentifier: "SetStoryModalVC")
        
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: true, completion: nil)
        refreshControl.endRefreshing()
    }
    
    private func connectTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let tableCell = UINib(nibName: "StoryTVC", bundle: nil)
        tableView.register(tableCell, forCellReuseIdentifier: "StoryTVC")
        
        refreshControl.addTarget(self, action: #selector(presentMoadal), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
    }
    
    private func fetchCoreData() {
        let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
        let fetchResult = PersistenceManager.shared.fetch(reqeust: request)
        print(fetchResult)
        storyList = fetchResult
        print(storyList)
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTVC") as? StoryTVC else {
            return UITableViewCell()
        }
        
        cell.setData(title: storyList[indexPath.row].title ?? "" , date: storyList[indexPath.row].date ?? "")
        
        return cell
    }
    
    
}
