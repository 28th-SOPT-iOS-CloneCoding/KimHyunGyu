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
    
    var storyTitleButton: UIButton = {
        let button = UIButton()
        button.setTitle("이야기 1", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(storyTitleButtonClicked), for: .touchDown)
        button.titleLabel?.font = UIFont.init(name: "NanumMyeongjoBold", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var storySubtitleButton: UIButton = {
        let button = UIButton()
        button.setTitle("여기를 눌러서 제목을 변경하세요", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(storyTitleButtonClicked), for: .touchDown)
        button.titleLabel?.font = UIFont.init(name: "NanumMyeongjo", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var customNavigationBar: UIView = {
        let navigationBar = UIView()
        navigationBar.backgroundColor = .white
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        //높이 설정하고 뷰디드로드에서 여기안에 버튼 두개 넣어주기.
        
        return navigationBar
    }()
    
    var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.separator
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    // MARK: - @IBOutlet Properteis
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCoreData()
        setUI()
        connectTableView()
        setNotificationCenter()
        
        
    }
    
    // MARK: - @objc Methods
    @objc
    func storyTitleButtonClicked() {
        //present 로 뷰 띄우기
        guard let nextVC = UIStoryboard(name: "SetStoryTitleModal", bundle: nil).instantiateViewController(withIdentifier: "SetStoryTitleModalVC") as? SetStoryTitleModalVC else {
            return
        }
        
        nextVC.titleText = self.storyTitleButton.title(for: .normal)
        nextVC.subtitleText = self.storySubtitleButton.title(for: .normal)
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: true , completion: nil)
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
    
    // MARK: - Methods
    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name("ReloadData"), object: nil)
    }
    
    private func setUI() {
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(customNavigationBar)
        customNavigationBar.addSubview(storyTitleButton)
        customNavigationBar.addSubview(storySubtitleButton)
        customNavigationBar.addSubview(separatorView)
        
        customNavigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        customNavigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        customNavigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        customNavigationBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/7).isActive = true
        customNavigationBar.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        storyTitleButton.centerXAnchor.constraint(equalTo: customNavigationBar.centerXAnchor).isActive = true
        storyTitleButton.centerYAnchor.constraint(equalTo: customNavigationBar.centerYAnchor, constant: 0).isActive = true
        
        storySubtitleButton.centerXAnchor.constraint(equalTo: customNavigationBar.centerXAnchor).isActive = true
        storySubtitleButton.topAnchor.constraint(equalTo: storyTitleButton.bottomAnchor, constant: 20).isActive = true
        
        separatorView.leftAnchor.constraint(equalTo: customNavigationBar.leftAnchor, constant: 15).isActive = true
        separatorView.rightAnchor.constraint(equalTo: customNavigationBar.rightAnchor, constant: -15).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: customNavigationBar.bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        
        if storyList.count == 0 {
            //label 추가
            view.addSubview(infoLabel)
            infoLabel.translatesAutoresizingMaskIntoConstraints = false
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        }
    }
    
    private func connectTableView() {
        tableView.separatorStyle = .none
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
        storyList = fetchResult
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.height*(2/7) - 44
    }
    
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTVC") as? StoryTVC else {
            return UITableViewCell()
        }
        cell.titleLabel?.font = UIFont.init(name: "NanumMyeongjo", size: 17)
        cell.dateLabel.font = UIFont.init(name: "NanumMyeongjo", size: 12)
//        let backgroundCell = UIView()
//        backgroundCell.backgroundColor = .white
//        cell.selectedBackgroundView = backgroundCell
        cell.selectionStyle = .none

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

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scroll")
        let contenOffsetY = scrollView.contentOffset.y
        print(contenOffsetY)
//        let viewHeight = self.view.frame.height*(2/7)
        if contenOffsetY > 0 {
            customNavigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            customNavigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            customNavigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            customNavigationBar.heightAnchor.constraint(equalToConstant: 200 - contenOffsetY).isActive = true
        } else {
            customNavigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            customNavigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            customNavigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            customNavigationBar.heightAnchor.constraint(equalToConstant: 200 - contenOffsetY).isActive = true
        }
    }
}
