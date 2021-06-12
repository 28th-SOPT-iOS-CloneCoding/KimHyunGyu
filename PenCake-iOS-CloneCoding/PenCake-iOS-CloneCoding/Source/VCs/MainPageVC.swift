//
//  MainPageViewController.swift
//  PenCake-iOS-CloneCoding
//
//  Created by kimhyungyu on 2021/06/01.
//

import UIKit
import CoreData

class MainPageVC: UIPageViewController, UIGestureRecognizerDelegate {

    // MARK: - Properties
//    private var currentIndex = 0
    var storyList = [StoryList]()
    lazy var vcArray: [UIViewController] = {
        return [self.vcInstance(name: "AddVC")]
    }()
    
    private func vcInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    // MARK: - @IBOutlet Properties
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.delegate = self
        self.dataSource = self

        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        setNotification()
        fetchCoreData()
    }
    //MARK: - @objc Methods
    @objc
    func reloadStorylist() {
        fetchCoreData()
    }
    
    //MARK: - Methods
    private func fetchCoreData() {
        let request: NSFetchRequest<StoryList> = StoryList.fetchRequest()
        let fetchResult = PersistenceManager.shared.fetch(reqeust: request)
        storyList = fetchResult
        let pageCount = storyList.count
        
        for _ in (0..<pageCount) {
            vcArray.append(vcInstance(name: "MainViewController"))
        }
        vcArray.reverse()
        if let firstVC = vcArray.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadStorylist), name: NSNotification.Name("ReloadStoryList"), object: nil)
    }
}

// MARK: - UIPageViewControllerDataSource
extension MainPageVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = vcArray.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        return vcArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = vcArray.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < vcArray.count else {
            return nil
        }
        
        return vcArray[nextIndex]
    }
}

// MARK: - UIPageViewControllerDelegate
extension MainPageVC: UIPageViewControllerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
}
