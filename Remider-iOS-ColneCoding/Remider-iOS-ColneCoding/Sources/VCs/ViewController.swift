//
//  ViewController.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/12.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    //MARK: - Properties
    
    //Realm
    var realm : Realm?
    var Lists: Results<ListModel>?
    var notificationToken: NotificationToken?
//    var tableContents = ["ㅊㅊ","ㅍ","ㅊㅊ","ㅍ","ㅊㅊ","ㅍ","ㅊㅊ","ㅍ","ㅊㅊ","ㅍ"]
    let sections = ["나의 목록"]
    
    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var tableEditBtn: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var allView: UIView!
    
    //MARK: - View Life Cycle
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        notificationToken?.invalidate()
    }
    deinit {
        notificationToken?.invalidate()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        realm = try? Realm()
        Lists = realm?.objects(ListModel.self)

        notificationToken = Lists?.observe { change in
            print("change: \(change)")
            self.tableView.reloadData()
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // UISearchControloler initialize
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        navigationItem.searchController = searchController
        
        //view cornerRadius
        
        scheduleView.layer.cornerRadius = 13
        todayView.layer.cornerRadius = 13
        allView.layer.cornerRadius = 13
        
        //navigationBar
        setBackBtn()
        
        //UIView touch event
        
//        let concern1Gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedconcern1(_:)))
//        scheduleView.addGestureRecognizer(concern1Gesture)
          
    }
//
//    @objc func tappedconcern1(_ gesture: UITapGestureRecognizer) {
//            let storyboard: UIStoryboard = UIStoryboard(name: "ViewController", bundle: nil)
//            let viewcontroller = storyboard.instantiateViewController(withIdentifier: "ScheduleListVC")
//            present(viewcontroller, animated: true)
//        }
    
    //MARK: - @IBAction Properties
    
    @IBAction func touchEditBtn(_ sender: UIBarButtonItem) {
        
        if tableView.isEditing {
            sender.title = "편집"
            sender.style = .plain
            tableView.setEditing(false, animated: true)
            
            //able searchBar
            
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchBar.placeholder = "검색"
            searchController.searchBar.isUserInteractionEnabled = true
            searchController.searchBar.alpha = 1
            navigationItem.searchController = searchController
            
        } else {
            sender.title = "완료"
            sender.style = .done
            tableView.setEditing(true, animated: true)
            
            // hide label
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
//            cell.countLabel.isHidden = true
//            
            
            //enable searchBar
            
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchBar.placeholder = "검색"
            searchController.searchBar.isUserInteractionEnabled = false
            searchController.searchBar.alpha = 0.5
            navigationItem.searchController = searchController
        }
    }

    //MARK: - Methods

    func setBackBtn() {
        let backBtn = UIBarButtonItem(title: "목록", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBtn
    }
    
}

//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    //cell height
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let info = UIContextualAction(style: .normal, title: "") { action, view, completion in
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "AddListViewController") as? AddListViewController else {
                    return
                }
            //modally
            nextVC.textFieldTitle = self.Lists?[indexPath.row].reminderTitle ?? ""
            nextVC.listBulletBtnColor = self.Lists?[indexPath.row].reminderColor ?? ""
            
            self.present(nextVC, animated: true, completion: nil)
            
            //swipe hide
            //reload 를 해서 부자연스럽지만 스와이프를 숨겼다.
            
        }
        let delete = UIContextualAction(style: .destructive, title: "") { action, view, completion in
//            self.tableContents.remove(at: indexPath.row)
            do {
                try self.realm?.write {
                    self.realm?.delete(self.Lists![indexPath.row])
                }
            } catch {
                print("Error")
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        info.image = UIImage(systemName: "info.circle.fill")
        delete.image = UIImage(systemName: "trash.fill")

        return UISwipeActionsConfiguration(actions: [delete, info])
    }
    
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //title 가져오기
        let storyboard = UIStoryboard.init(name: "List", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "List") as? ListVC else { return }
        
        nextVC.reminderTitle = Lists?[indexPath.row].reminderTitle ?? ""
        nextVC.reminderColor = Lists?[indexPath.row].reminderColor ?? ""
        
        
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //editingstyle 이라서 여기에 체크가 있을줄알았는데 없었다.
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        if indexPath.row == 0 {
//            return .none
//        } else {
//            return .delete
//        }
//    }
    
    //section title
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    //section header fontsize
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
            myLabel.frame = CGRect(x: 8, y: 0, width: 250, height: 20)
            myLabel.font = UIFont.boldSystemFont(ofSize: 24)
            myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

            let headerView = UIView()
            headerView.addSubview(myLabel)

            return headerView
    }
    
    //section header height
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    //cell text. section 0 으로 설정한 상태
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.listBulletBtn.backgroundColor = UIColor(hex: Lists?[indexPath.row].reminderColor ?? "#007aff")
        cell.listTitle?.text = Lists?[indexPath.row].reminderTitle
        cell.countLabel?.text = String(Lists?[indexPath.row].num ?? 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Lists?.count ?? 0
    }
    
    //moveRowAt
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    //remove row
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
//            tableContents.remove(at: indexPath.row)
            do {
                try realm?.write {
                    realm?.delete(Lists![indexPath.row])
                }
            } catch {
                print("Error")
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
