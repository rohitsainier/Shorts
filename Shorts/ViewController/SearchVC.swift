//
//  SearchVC.swift
//  Shorts
//
//  Created by Rohit Saini on 08/03/22.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let viewModel:SearchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    private func configUI(){
        self.title = "Seach"
        tableView.register(UINib(nibName: TABLE_VIEW.MOVIE_CELL.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW.MOVIE_CELL.rawValue)
        viewModel.onFetchMovieSucceed = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.onFetchMovieFailure = {[weak self] error in
            print(error)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
}

//MARK: - UISearchBarDelegate Delegate
extension SearchVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchMovies(query: searchText)
    }
}

//MARK: - TableView Delegate
extension SearchVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = viewModel.searchedMovies?.results{
            return movies.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW.MOVIE_CELL.rawValue, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        if let movie = viewModel.searchedMovies?.results[indexPath.row]{
            cell.bindViewWith(viewModel: MovieViewModel(movie: movie))
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: MovieDetailsVC = STORYBOARD.MAIN.load.instantiateViewController(withIdentifier: VIEW_CONTROLLER.MOVIE_DETAIL.rawValue) as! MovieDetailsVC
        if let movie = viewModel.searchedMovies?.results[indexPath.row]{
            vc.movie = movie
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
