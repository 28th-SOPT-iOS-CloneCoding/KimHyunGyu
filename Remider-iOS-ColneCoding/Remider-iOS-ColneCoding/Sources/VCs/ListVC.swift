//
//  ListVC.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/18.
//

import UIKit

class ListVC: UIViewController {

    //MARK: - Properties
    var reminderTitle = ""
    var reminderColor = ""
    var list = ["abc","def"]
    
    //MARK: - @IBOutlet Properties

    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - VIew Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelectionDuringEditing = true
        
        self.navigationItem.title = reminderTitle
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(hex: reminderColor)]
        
        touchOptionBarBtn()
        
        tableView.contentInsetAdjustmentBehavior = .never
        navigationItem.hidesSearchBarWhenScrolling = true
        
        let nib = UINib(nibName: "ListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ListCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        detailReminderNotification()
        textFieldNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    
    //MARK: - Methods
    
    func editList(action: UIAction) {
        print("editList")
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(identifier: "AddListViewController") as? AddListViewController else { return }
        
        self.present(nextVC, animated: true, completion: nil)
        
        //색과 리스트 타이틀 같이 보내주기
        //변수를 통해서 보내주었다.
//        nextVC.listTitle = "abc"
    }
    
    func selectRemider(action: UIAction) {
        print("selectRemider")

        //editing mode 손봐야함

        if tableView.isEditing {

        } else {
            tableView.setEditing(true, animated: true)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(setRightBarBtn))
        }
    }
    
    func showRemider(action: UIAction) {
        print("showRemider")
        //check 된 완료된 알림이 없다면 이렇게 나오고
        //check 완료된 알림이 있다면 "완료된 항목 가리기" eye.slash 이미지 가짐
    }
    
    func removeList(action: UIAction) {
        print("removeList")
        //목록 삭제
    }
    
    func touchOptionBarBtn() {
        let barButtonMenu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("이름 및 모양", comment: ""), image: UIImage(systemName: "pencil"), handler: editList),
            UIAction(title: NSLocalizedString("미리 알림 선택...", comment: ""), image: UIImage(systemName: "checkmark.circle"), handler: selectRemider),
            UIAction(title: NSLocalizedString("완료된 항목 보기", comment: ""), image: UIImage(systemName: "eye"), handler: showRemider),
            UIAction(title: NSLocalizedString("목록 삭제", comment: ""), image: UIImage(systemName: "trash"), handler: removeList)
        ])

        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "ellipsis.circle"), primaryAction: nil, menu: barButtonMenu)


        self.navigationItem.rightBarButtonItem?.menu = barButtonMenu
    }
    
    //MARK: - @objc Methods
    
    @objc
    func setRightBarBtn() {
        touchOptionBarBtn()
        tableView.setEditing(false, animated: true)
    }
    
    @objc
    func presentDetailReminder(notification: NSNotification) {
        let storyboard = UIStoryboard(name: "List", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(identifier: "DetailNavigationVC") as? UINavigationController else {
            return
        }
        
        self.present(nextVC, animated: true, completion: nil)

    }
    
    @objc
    func setMenuBtn() {
        touchOptionBarBtn()
        NotificationCenter.default.post(name: NSNotification.Name("SelectCompleteBtn"), object: nil)
    }
    
    @objc
    func setCompleteBtn() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(setMenuBtn))
    }

}

//MARK: - UITableViewDelegates

extension ListVC: UITableViewDelegate {

}

//MARK: - UITableViewDataSource

extension ListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier) as? ListCell else {
            return UITableViewCell()
        }
        
        cell.reminderField.text = list[indexPath.row]
        
        cell.selectionStyle = .blue

        return cell
    }
    
    //cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //movecell
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
    
    //swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let info = UIContextualAction(style: .normal, title: "세부사항") { action, view, completion in
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: DetailReminderVC.identifier) as? DetailReminderVC else {
                    return
                }
            //modally
            
            self.present(nextVC, animated: true, completion: nil)
            
            //swipe hide
            //reload 를 해서 부자연스럽지만 스와이프를 숨겼다.
            
        }
        let delete = UIContextualAction(style: .destructive, title: "삭제") { action, view, completion in
//            self.tableContents.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }

        return UISwipeActionsConfiguration(actions: [delete, info])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select")
        print(tableView.indexPathsForSelectedRows!)
    }
    
    
}

//MARK: - Notification

extension ListVC {
    
    private func detailReminderNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(presentDetailReminder(notification:)),
                                               name: NSNotification.Name("touchInfo"),
                                               object: nil)
    }
    private func textFieldNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(setCompleteBtn), name: NSNotification.Name("BeginEditing"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setMenuBtn), name: NSNotification.Name("EndEditing"), object: nil)
    }
}
