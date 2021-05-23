//
//  ViewController.swift
//  CGV-iOS-ColneCoding
//
//  Created by kimhyungyu on 2021/05/08.
//

import UIKit
import SnapKit

class MoreVC: UIViewController {

    //MARK: - Properties
    private var movieData : [Result] = []
//    private let refreshControl = UIRefreshControl()
    
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
    
    private let reservationBtn: UIButton = {
        let reservationBtn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 70)))
        reservationBtn.setGradient(color1: UIColor(red: 232/255, green: 99/255, blue: 109/255, alpha: 0.85), color2: UIColor(red: 218/255, green: 113/255, blue: 53/255, alpha: 0.85))
        reservationBtn.layer.cornerRadius = reservationBtn.frame.height / 4
        
        reservationBtn.layer.masksToBounds = true
        
        reservationBtn.addTarget(self, action: #selector(presentReservation(_:)), for: .touchUpInside)
        
        return reservationBtn
    }()
    
    private let topBtn: UIButton = {
        let topBtn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
        topBtn.backgroundColor = UIColor(white: 1.0, alpha: 0.75)
        topBtn.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        topBtn.setPreferredSymbolConfiguration(.init(pointSize: 25, weight: .thin, scale: .default), forImageIn: .normal)
        topBtn.tintColor = UIColor.darkGray
        topBtn.addTarget(self, action: #selector(scrollUp(_:)), for: .touchUpInside)

        return topBtn
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
    func presentReservation(_ sender: UIButton) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ReservationVC") as? ReservationVC else {
            return
        }
        nextVC.modalPresentationStyle = .overFullScreen
        
        
        present(nextVC, animated: true, completion: nil)
    }
    
    @objc
    func scrollUp(_ sender: UIButton) {
        let topIndex = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: topIndex, at: .top, animated: true)
    }
    
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
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh(refresh:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        // 지금 예매 버튼
//        reservationBtn.translatesAutoresizingMaskIntoConstraints = false
//        topBtn.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(reservationBtn)
        view.addSubview(topBtn)
        
        reservationBtn.snp.makeConstraints { make in
//            make.width.equalToSuperview().multipliedBy(0.45)
            make.width.equalTo(160)
            make.height.equalTo(70)
            make.trailing.equalToSuperview().inset(-30)
            make.bottom.equalToSuperview().inset(30)
        }

        topBtn.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(-100)
        }
        reservationBtn.layer.cornerRadius = reservationBtn.frame.height / 2
        
        topBtn.layer.cornerRadius = topBtn.frame.height / 2
        topBtn.layer.shadowRadius = 2
        topBtn.layer.shadowOpacity = 0.25
        topBtn.layer.shadowColor = UIColor.black.cgColor
        topBtn.layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    private func registerCell() {
        let movieCell = UINib(nibName: "MovieCell", bundle: nil)
        tableView.register(movieCell, forCellReuseIdentifier: MovieCell.identifier)
    }
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
        bookBtn.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 0).isActive = true
        bookBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true

        eggBtn.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        eggBtn.leftAnchor.constraint(equalTo: bookBtn.rightAnchor, constant: 0).isActive = true
        eggBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true

        upcomingCheckBtn.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        upcomingCheckBtn.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: 0).isActive = true
        upcomingCheckBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true

//        bookBtn.snp.makeConstraints { make in
//            make.leading.equalTo(headerView.snp.leading).inset(10)
//            make.centerY.equalTo(headerView.snp.centerY)
//        }
//
//        eggBtn.snp.makeConstraints { make in
//            make.leading.equalTo(bookBtn.snp.trailing).inset(-10)
//            make.centerY.equalTo(headerView.snp.centerY)
//        }
//
//        upcomingCheckBtn.snp.makeConstraints { make in
//            make.trailing.equalTo(headerView.snp.trailing).inset(10)
//            make.centerY.equalTo(headerView.snp.centerY)
//        }
        
        return headerView
    }
    
    
}

//MARK: - UITableViewDelegates

extension MoreVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 10 {
            topBtn.isHidden = false
            
            topBtn.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(30)
            }
            
            reservationBtn.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(45 + self.topBtn.bounds.height)
            }
            
        } else {
            topBtn.isHidden = true
            
            topBtn.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(-100)
            }
            
            reservationBtn.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(30)
            }
        }
        
        
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
}
