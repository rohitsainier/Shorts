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

//MARK: - TableView Delegate
extension HomeVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieType == .Trending ? viewModel.trendingMovies?.results.count ?? 0 : viewModel.nowPlayingMovies?.results.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW.MOVIE_CELL.rawValue, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        if let movie = viewModel.movieType == .Trending ? viewModel.trendingMovies?.results[indexPath.row] : viewModel.nowPlayingMovies?.results[indexPath.row]{
            cell.bindViewWith(viewModel: MovieViewModel(movie: movie))
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: MovieDetailsVC = STORYBOARD.MAIN.load.instantiateViewController(withIdentifier: VIEW_CONTROLLER.MOVIE_DETAIL.rawValue) as! MovieDetailsVC
        if let movie = viewModel.movieType == .Trending ? viewModel.trendingMovies?.results[indexPath.row] : viewModel.nowPlayingMovies?.results[indexPath.row]{
            vc.movie = movie
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch viewModel.movieType {
            case .Trending:
                if let trendingMovies = viewModel.trendingMovies{
                    if indexPath.row == trendingMovies.results.count - 1 && trendingMovies.totalPages > trendingMovies.page{
                        viewModel.fetchNextBadge(type: .Trending, page: trendingMovies.page + 1)
                    }
                }
                
            case .NowPlaying:
                if let nowPlayingMovies = viewModel.nowPlayingMovies{
                    if indexPath.row == nowPlayingMovies.results.count - 1 && nowPlayingMovies.totalPages > nowPlayingMovies.page{
                        viewModel.fetchNextBadge(type: .NowPlaying, page: nowPlayingMovies.page + 1)
                    }
                }
        }
        
    }
}

