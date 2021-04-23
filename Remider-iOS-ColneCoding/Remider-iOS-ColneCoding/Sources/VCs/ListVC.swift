//
//  ListVC.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/18.
//

import UIKit

class ListVC: UIViewController {

    //MARK: - @IBOutlet Properties
    


    @IBOutlet weak var optionBarBtn: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - VIew Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        touchOptionBarBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }


    @IBAction func tochBackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Methods
    
    func editList(action: UIAction) {
        
        print("editList")
        let storyboard = UIStoryboard.init(name: "AddListViewController", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(identifier: "AddListViewController") as? AddListViewController else { return }
        
        self.present(nextVC, animated: true, completion: nil)
        
        //색과 리스트 타이틀 같이 보내주기
        
        nextVC.listTitle = navigationItem.title
    }
    
    func selectRemider(action: UIAction) {
        print("selectRemider")
        
        //editing mode

        if tableView.isEditing {
            optionBarBtn.title = ""
            optionBarBtn.image = UIImage(systemName: "ellipsis.circle")
            tableView.setEditing(false, animated: true)
        } else {
            optionBarBtn.title = "완료"
            //optionBarBtn.image =
            optionBarBtn.style = .done
            tableView.setEditing(true, animated: true)
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
        self.optionBarBtn.menu = barButtonMenu
    }

}
