//
//  ViewController.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/08.
//

import UIKit

class MoreVC: UIViewController {

    //MARK: - Properties
    
    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setUI()
        registerCell()
        
//        MovieApi.shared.getTopRatedMovie { response in
//           dump(response)
//
//        }
    }
    
    //MARK: - Methods
    
    func setUI() {
        tableView.separatorStyle = .none
    }
    
    func registerCell() {
        let movieCell = UINib(nibName: "MovieCell", bundle: nil)
        tableView.register(movieCell, forCellReuseIdentifier: MovieCell.identifier)
    }
}

//MARK: - UITableViewDataSources

extension MoreVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        MovieApi.shared.getTopRatedMovie { response in
            cell.setData(image: response[indexPath.row].posterPath, title: response[indexPath.row].title, vote: response[indexPath.row].voteAverage, popularity: response[indexPath.row].popularity, releaseDate: response[indexPath.row].releaseDate)
        }
        
        return cell
    }
    
    
}

//MARK: - UITableViewDelegates

extension MoreVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
