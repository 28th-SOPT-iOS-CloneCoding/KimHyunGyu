//
//  ViewController.swift
//  PenCake-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/05/27.
//

import UIKit
import CoreData
import SnapKit

class MainViewController: UIViewController {

    // MARK: - Properties
    var list = [StoryList]()
    var storyList = [StoryModel]()
    var refreshControl = UIRefreshControl()
    lazy var infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.text = "여기를 아래로 당기면 글을 쓸 수 있어요"
        infoLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        infoLabel.font = UIFont(name: "NanumMyeongjo", size: 14)
        infoLabel.tag = 1
        
        return infoLabel
    }()
    
    var storyTitleButton: UIButton = {
        let button = UIButton()
        button.setTitle("이야기 1", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(storyTitleButtonClicked), for: .touchDown)
        button.titleLabel?.font = UIFont.init(name: "NanumMyeongjoBold", size: 20)
        
        return button
    }()
    
    var storySubtitleButton: UIButton = {
        let button = UIButton()
        button.setTitle("여기를 눌러서 제목을 변경하세요", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(storyTitleButtonClicked), for: .touchDown)
        button.titleLabel?.font = UIFont.init(name: "NanumMyeongjo", size: 14)
        
        return button
    }()
    
    var customNavigationBar: UIView = {
        let navigationBar = UIView()
        navigationBar.backgroundColor = .white
        navigationBar.clipsToBounds = true
        
        return navigationBar
    }()
    
    var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray4

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
            infoLabel.snp.makeConstraints({ make in
                make.centerX.equalTo(self.view)
                make.centerY.equalTo(self.view).offset(-100)
            })
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
        
        customNavigationBar.snp.makeConstraints({ make in
            make.height.equalTo(220)
            make.top.equalTo(self.view)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        })
        
        storyTitleButton.snp.makeConstraints({ make in
            make.centerX.equalTo(self.customNavigationBar)
            make.centerY.equalTo(self.customNavigationBar).offset(20)
        })
        
        storySubtitleButton.snp.makeConstraints({ make in
            make.centerX.equalTo(self.customNavigationBar)
            make.top.equalTo(self.storyTitleButton.snp.bottom).offset(20)
        })

        
        separatorView.snp.makeConstraints({ make in
            make.height.equalTo(0.5)
            make.left.right.equalTo(self.customNavigationBar).inset(15)
            make.bottom.equalTo(self.customNavigationBar.snp.bottom)
        })
        
        if storyList.count == 0 {
            //label 추가
            view.addSubview(infoLabel)

            infoLabel.snp.makeConstraints({ make in
                make.centerX.equalTo(self.view)
                make.centerY.equalTo(self.view).offset(-100)
            })
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
        let listRequest: NSFetchRequest<StoryList> = StoryList.fetchRequest()
        let fetchListResult = StoryListPersistenceManager.shared.fetch(reqeust: listRequest)
        list = fetchListResult
        print(list)
        
        let request: NSFetchRequest<StoryModel> = StoryModel.fetchRequest()
        let fetchResult = PersistenceManager.shared.fetch(reqeust: request)
        storyList = fetchResult
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return self.view.frame.height*(2/7) - 44
        return 200
    }
    
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTVC") as? StoryTVC else {
            return UITableViewCell()
        }
        cell.titleLabel?.font = UIFont.init(name: "NanumMyeongjo", size: 17)
        cell.dateLabel.font = UIFont.init(name: "NanumMyeongjo", size: 12)
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

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contenOffsetY = scrollView.contentOffset.y
        let customViewHeight = 220

        if contenOffsetY > 0 {
            if (customViewHeight - Int(contenOffsetY)) > 80 {
                if (customViewHeight - Int(contenOffsetY)) > 110 {
                    storyTitleButton.titleLabel?.font = UIFont(name: "NanumMyeongjo", size: 20)
                } else {
                    storyTitleButton.titleLabel?.font = UIFont(name: "NanumMyeongjo", size: 19.7)
                }
                customNavigationBar.snp.updateConstraints({ make in
                    make.height.equalTo(CGFloat(customViewHeight) - contenOffsetY)
                })
            } else {
                customNavigationBar.snp.updateConstraints({ make in
                    make.height.equalTo(80)
                })
                storyTitleButton.titleLabel?.font = UIFont(name: "NanumMyeongjo", size: 19.5)
            }
        }
    }
}
//extension ViewController: UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//}
