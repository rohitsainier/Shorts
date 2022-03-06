//
//  ViewController.swift
//  Shorts
//
//  Created by Rohit Saini on 04/03/22.
//

import UIKit

final class HomeVC: UIViewController {

    //OUTLETS
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    //VARIABLES
    private let viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        viewModel.fetchMovie(type: .Trending)
        viewModel.fetchMovie(type: .NowPlaying)
        viewModel.onFetchMovieSucceed = { [weak self] in            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.onFetchMovieFailure = { error in
            print(error)
        }
    }
    
    private func configUI(){
        tableView.register(UINib(nibName: TABLE_VIEW.MOVIE_CELL.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW.MOVIE_CELL.rawValue)
    }
}

//MARK: - ACTIONS
extension HomeVC{
    @IBAction func segmentIndexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
            case 0:
                viewModel.setMovieType(type: .Trending)
            case 1:
                viewModel.setMovieType(type: .NowPlaying)
            default:
                break
        }
    }
}

extension HomeVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieType == .Trending ? viewModel.trendingMovies.count : viewModel.nowPlayingMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW.MOVIE_CELL.rawValue, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        return cell
    }
}

