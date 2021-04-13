//
//  ViewController.swift
//  Remider-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/04/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UISearchControloler initialize
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        navigationItem.searchController = searchController
        navigationItem.title = ""
//
//        //UIToolbar initialize
//        
//        let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 100))
//        view.addSubview(toolbar)
//        
//        toolbar.translatesAutoresizingMaskIntoConstraints = false
//        toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
//        toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
//        toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true
//
//        var items: [UIBarButtonItem] = []
//
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let toolbarItem1 = UIBarButtonItem(title: "새로운 미리 알림", style: .plain, target: self, action: nil)
//        let toolbarItem2 = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: nil)
//
//        items.append(toolbarItem1)
//        items.append(flexibleSpace)
//        items.append(toolbarItem2)
//
//        toolbar.setItems(items, animated: true)
    }


}

