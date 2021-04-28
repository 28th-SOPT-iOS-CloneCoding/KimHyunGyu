//
//  ListVC.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/18.
//

import UIKit

class ListVC: UIViewController {

    //MARK: - Properties
    
    var list = ["abc","def"]
    
    //MARK: - @IBOutlet Properties

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - VIew Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        touchOptionBarBtn()
        
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.hidesSearchBarWhenScrolling = true
        
        let nib = UINib(nibName: "ListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ListCell")
        
        tableView.delegate = self
        tableView.dataSource = self
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
        nextVC.listTitle = "abc"
    }
    
    func selectRemider(action: UIAction) {
        print("selectRemider")

        //editing mode 손봐야함

        if tableView.isEditing {
//            touchOptionBarBtn()
//            tableView.setEditing(false, animated: true)
        } else {
            tableView.setEditing(true, animated: true)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(setRightBarBtn))
        }
    }
    @objc func setRightBarBtn() {
        touchOptionBarBtn()
        tableView.setEditing(false, animated: true)
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

        self.navigationItem.title = "abc"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "ellipsis.circle"), primaryAction: nil, menu: barButtonMenu)
//        self.navigationItem.rightBarButtonItem?.title = ""
//        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "ellipsis.circle")
//        self.navigationItem.rightBarButtonItem?.tintColor = .systemBlue

        self.navigationItem.rightBarButtonItem?.menu = barButtonMenu
    }

}

extension ListVC: UITableViewDelegate {

}

extension ListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier) as? ListCell else {
            return UITableViewCell()
        }
        cell.testLabel.text = list[indexPath.row]
        
        return cell
    }
}
//
//extension ListVC: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if let height = navigationController?.navigationBar.frame.size.height, height == 44 {
//            topConstraint.constant = 0
//        } else {
//            topConstraint.constant = 44
//        }
//    }
//}
