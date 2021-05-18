//
//  ViewController.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/08.
//

import UIKit

class MoreVC: UIViewController {

    //MARK: - Properties
    private var movieData : [Result] = []
    private let refreshControl = UIRefreshControl()
    
    private var selectedBookBtn = true
    private var selectedEggBtn = false
    private var selectedUpcomingBtn = false
    
    private let bookBtn: UIButton = {
        let bookBtn = UIButton()
        bookBtn.setTitle("예매율순", for: .normal)
        bookBtn.setTitleColor(.black, for: .normal)
        bookBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        bookBtn.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        bookBtn.setPreferredSymbolConfiguration(.init(pointSize: 3, weight: .regular, scale: .default), forImageIn: .normal)
        bookBtn.titleEdgeInsets = .init(top: .zero, left: 8, bottom: .zero, right: .zero)
        bookBtn.tintColor = .black
        bookBtn.addTarget(self, action: #selector(touchBookBtn), for: .touchUpInside)
        
        return bookBtn
    }()
    
    private let eggBtn: UIButton = {
        let eggBtn = UIButton()
        eggBtn.setTitle("Egg지수순", for: .normal)
        eggBtn.setTitleColor(.lightGray, for: .normal)
        eggBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        eggBtn.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        eggBtn.setPreferredSymbolConfiguration(.init(pointSize: 3, weight: .regular, scale: .default), forImageIn: .normal)
        eggBtn.titleEdgeInsets = .init(top: .zero, left: 8, bottom: .zero, right: .zero)
        eggBtn.tintColor = .lightGray
        eggBtn.addTarget(self, action: #selector(touchEggBtn), for: .touchUpInside)
        
        return eggBtn
    }()
    
    private let upcomingCheckBtn: UIButton = {
        let upcomingCheckBtn = UIButton()
        upcomingCheckBtn.setTitle("현재상영작보기", for: .normal)
        upcomingCheckBtn.setTitleColor(.lightGray, for: .normal)
        upcomingCheckBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        upcomingCheckBtn.tintColor = .lightGray
        upcomingCheckBtn.setImage(UIImage(systemName: "checkmark"), for: .normal)
        upcomingCheckBtn.setPreferredSymbolConfiguration(.init(pointSize: 12, weight: .bold, scale: .default), forImageIn: .normal)
        upcomingCheckBtn.addTarget(self, action: #selector(touchUpcomingBtn), for: .touchUpInside)
        
        return upcomingCheckBtn
    }()
    
    //MARK: - @IBOutlet Properties
    
    @IBOutlet weak var upcomingBtn: UIButton!
    @IBOutlet weak var arthouseBtn: UIButton!
    @IBOutlet weak var movieChartBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        setUI()
        registerCell()
    }
    
    //MARK: - @obcj Methods
    @objc
    func pullToRefresh(refresh: UIRefreshControl) {
        print("pullToRefresh()")
        refresh.endRefreshing()
        
        bookBtn.setTitleColor(.black, for: .normal)
        bookBtn.tintColor = .black
        selectedBookBtn = true
        
        eggBtn.setTitleColor(.lightGray, for: .normal)
        eggBtn.tintColor = .lightGray
        selectedEggBtn = false
        
        upcomingCheckBtn.setTitleColor(.lightGray, for: .normal)
        upcomingCheckBtn.tintColor = .lightGray
        selectedUpcomingBtn = false
        
        tableView.reloadData()
    }
    
    @objc
    func touchBookBtn(_ sender: UIButton) {
//        if !selectedBookBtn {
//            sender.setTitleColor(.black, for: .normal)
//            sender.tintColor = .black
//        } else {
//            sender.setTitleColor(.lightGray, for: .normal)
//            sender.tintColor = .lightGray
//        }
//        selectedBookBtn = !selectedBookBtn
        sender.setTitleColor(.black, for: .normal)
        sender.tintColor = .black
        selectedBookBtn = true
        
        eggBtn.setTitleColor(.lightGray, for: .normal)
        eggBtn.tintColor = .lightGray
        selectedEggBtn = false
        
        tableView.reloadData()
    }
    
    @objc
    func touchEggBtn(_ sender: UIButton) {
//        if !selectedEggBtn {
//            sender.setTitleColor(.black, for: .normal)
//            sender.tintColor = .black
//        } else {
//            sender.setTitleColor(.lightGray, for: .normal)
//            sender.tintColor = .lightGray
//        }
//        selectedEggBtn = !selectedEggBtn
        sender.setTitleColor(.black, for: .normal)
        sender.tintColor = .black
        selectedEggBtn = true
        
        bookBtn.setTitleColor(.lightGray, for: .normal)
        bookBtn.tintColor = .lightGray
        selectedBookBtn = false
        
        tableView.reloadData()
    }
    
    @objc
    func touchUpcomingBtn(_ sender: UIButton) {
        if !selectedUpcomingBtn {
            sender.setTitleColor(.red, for: .normal)
            sender.tintColor = .red
        } else {
            sender.setTitleColor(.lightGray, for: .normal)
            sender.tintColor = .lightGray
        }
        selectedUpcomingBtn = !selectedUpcomingBtn
        
        tableView.reloadData()
    }
    
    
    //MARK: - Methods
    
    private func setUI() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        
        movieChartBtn.tintColor = .black
        arthouseBtn.tintColor = .lightGray
        upcomingBtn.tintColor = .lightGray
        
        // 당겨서 새로고침
//        self.refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        self.refreshControl.addTarget(self, action: #selector(pullToRefresh(refresh:)), for: .valueChanged)
        tableView.refreshControl = self.refreshControl
    }
    
    private func registerCell() {
        let movieCell = UINib(nibName: "MovieCell", bundle: nil)
        tableView.register(movieCell, forCellReuseIdentifier: MovieCell.identifier)
    }
    
//    private func setHeaderView() -> UIView {
        //tableview header view
        
//        let bookBtn = UIButton(frame: CGRect(x: 4, y: 0 , width: 80, height: 40)) //frame.size.width - 60
//        let bookBtn = UIButton()
//        bookBtn.setTitle("예매율순", for: .normal)
//        bookBtn.setTitleColor(.black, for: .normal)
//        bookBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
//        bookBtn.setImage(UIImage(systemName: "circle.fill"), for: .normal)
//        bookBtn.setPreferredSymbolConfiguration(.init(pointSize: 3, weight: .regular, scale: .default), forImageIn: .normal)
//        bookBtn.titleEdgeInsets = .init(top: .zero, left: 8, bottom: .zero, right: .zero)
//        bookBtn.tintColor = .black
//        bookBtn.addTarget(self, action: #selector(touchBookBtn), for: .touchUpInside)
        
//        let eggBtn = UIButton(frame: CGRect(x: 80, y: 0, width: 80, height: 40)) //frame.size.width - 60
//        let eggBtn = UIButton()
//        eggBtn.setTitle("Egg지수순", for: .normal)
//        eggBtn.setTitleColor(.lightGray, for: .normal)
//        eggBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
//        eggBtn.setImage(UIImage(systemName: "circle.fill"), for: .normal)
//        eggBtn.setPreferredSymbolConfiguration(.init(pointSize: 3, weight: .regular, scale: .default), forImageIn: .normal)
//        eggBtn.titleEdgeInsets = .init(top: .zero, left: 8, bottom: .zero, right: .zero)
//        eggBtn.tintColor = .lightGray
//        eggBtn.addTarget(self, action: #selector(touchEggBtn), for: .touchUpInside)
        
//        let upcomingBtn = UIButton(frame: CGRect(x: frame.width - 100, y: 0, width: 100, height: 40))
//        let upcomingBtn = UIButton()
//        upcomingBtn.setTitle("현재상영작보기", for: .normal)
//        upcomingBtn.setTitleColor(.lightGray, for: .normal)
//        upcomingBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
//        upcomingBtn.tintColor = .lightGray
//        upcomingBtn.setImage(UIImage(systemName: "checkmark"), for: .normal)
//        upcomingBtn.setPreferredSymbolConfiguration(.init(pointSize: 12, weight: .bold, scale: .default), forImageIn: .normal)
//        upcomingBtn.addTarget(self, action: #selector(touchUpcomingBtn), for: .touchUpInside)
        
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 50))
//        let headerView = UIView()
//        headerView.addSubview(bookBtn)
//        headerView.addSubview(eggBtn)
//        headerView.addSubview(upcomingBtn)
        
//        return headerView
//    }
}

//MARK: - UITableViewDataSources

extension MoreVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        MovieApi.shared.getNowPlaying { response in
            if self.selectedBookBtn == true && self.selectedEggBtn == false {
                self.movieData = response.sorted(by: {$0.popularity > $1.popularity})
            } else {
                self.movieData = response.sorted(by: {$0.voteAverage > $1.voteAverage})
            }
            cell.setData(title: self.movieData[indexPath.row].title,
                         vote: self.movieData[indexPath.row].voteAverage,
                         popularity: self.movieData[indexPath.row].popularity,
                         releaseDate: self.movieData[indexPath.row].releaseDate)
            
            //먼저 내용부터 로딩. 사진은 비동기 처리.
            MovieApi.shared.getMoviePoster(path: self.movieData[indexPath.row].posterPath) { data in
                cell.setPosterImage(image: UIImage(data: data)!)
            }
        }
        
        return cell
    }
    
    //header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        bookBtn.translatesAutoresizingMaskIntoConstraints = false
        eggBtn.translatesAutoresizingMaskIntoConstraints = false
        upcomingCheckBtn.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(bookBtn)
        headerView.addSubview(eggBtn)
        headerView.addSubview(upcomingCheckBtn)
        
        bookBtn.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        //        bookBtn.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        bookBtn.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 0).isActive = true
        bookBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        eggBtn.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        eggBtn.leftAnchor.constraint(equalTo: bookBtn.rightAnchor, constant: 0).isActive = true
        eggBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        upcomingCheckBtn.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        upcomingCheckBtn.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: 0).isActive = true
        upcomingCheckBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        return headerView
    }
    
    
}

//MARK: - UITableViewDelegates

extension MoreVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
