//
//  SavedVC.swift
//  Shorts
//
//  Created by Rohit Saini on 07/03/22.
//

import UIKit

class SavedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: SavedMoviesViewModel = SavedMoviesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        viewModel.fetchSavedMovies()
        viewModel.onFetchMovieSucceed = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
       
    }
    
    private func configUI(){
        self.title = "Saved"
        tableView.register(UINib(nibName: TABLE_VIEW.MOVIE_CELL.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW.MOVIE_CELL.rawValue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchSavedMovies()
    }

}

//MARK: - TableView Delegate
extension SavedVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.savedMovies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW.MOVIE_CELL.rawValue, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        cell.bindViewWith(viewModel: MovieViewModel(movie: viewModel.savedMovies[indexPath.row]))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: MovieDetailsVC = STORYBOARD.MAIN.load.instantiateViewController(withIdentifier: VIEW_CONTROLLER.MOVIE_DETAIL.rawValue) as! MovieDetailsVC
        let movie = viewModel.savedMovies[indexPath.row]
        vc.movie = movie
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
