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
    lazy var infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.text = "여기를 아래로 당기면 글을 쓸 수 있어요"
        infoLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        infoLabel.tag = 1
        return infoLabel
    }()
    
    // MARK: - @IBOutlet Properteis
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        connectTableView()
        fetchCoreData()
        
        if storyList.count == 0 {
            //label 추가
            view.addSubview(infoLabel)
            infoLabel.translatesAutoresizingMaskIntoConstraints = false
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name("ReloadData"), object: nil)
    }
    
    @objc
    func reloadTableView() {
        let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
        let fetchResult = PersistenceManager.shared.fetch(reqeust: request)
        storyList = fetchResult
        
        self.tableView.reloadData()
        if storyList.count == 0 {
            //label 추가
            view.addSubview(infoLabel)
            infoLabel.translatesAutoresizingMaskIntoConstraints = false
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        } else {
            let subInfoLabel = self.view.viewWithTag(1)
            subInfoLabel?.removeFromSuperview()
        }
        
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc
    func presentMoadal() {
        let nextVC = UIStoryboard.init(name: "SetStoryModal", bundle: nil).instantiateViewController(withIdentifier: "SetStoryModalVC")
        
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    private func connectTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let tableCell = UINib(nibName: "StoryTVC", bundle: nil)
        tableView.register(tableCell, forCellReuseIdentifier: "StoryTVC")
        
        tableView.refreshControl = refreshControl
        refreshControl.tintColor = .clear
        refreshControl.addTarget(self, action: #selector(presentMoadal), for: .valueChanged)
    }
    
    private func fetchCoreData() {
        let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
        let fetchResult = PersistenceManager.shared.fetch(reqeust: request)
//        print(fetchResult)
        storyList = fetchResult
//        print(storyList)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.top
    }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextVC = UIStoryboard.init(name: "StoryCellDetail", bundle: nil).instantiateViewController(withIdentifier: "StoryCellDetailVC") as? StoryCellDetailVC else {
            return
        }
        nextVC.indexPath = indexPath.row
        navigationController?.pushViewController(nextVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
