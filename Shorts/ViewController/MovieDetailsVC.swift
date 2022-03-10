//
//  MovieDetailsVC.swift
//  Shorts
//
//  Created by Rohit Saini on 06/03/22.
//

import UIKit

class MovieDetailsVC: UIViewController {

    //OUTLETS
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var bookmarkMovieBtn: UIButton!
    
    //VARIBALES
    var movie: Movie?
    
    private let viewModel: MovieDetailViewModel = MovieDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()

        // Do any additional setup after loading the view.
    }
    
    private func configUI(){
        if let movie = movie{
            titleLbl.text = movie.originalTitle
            overviewLbl.text = movie.overview
            bookmarkMovieBtn.setTitle("", for: .normal)
            if movie.movieImageData != nil{
                posterImage.image = UIImage(data: movie.movieImageData ?? Data())
            }
            else{
                ImageClient.shared.setImage(from: movie.posterURL, placeholderImage: nil) { [weak self] image in
                    self?.posterImage.image = image
                }
            }
            if viewModel.isSaved(movie: movie){
                self.bookmarkMovieBtn.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                self.bookmarkMovieBtn.tintColor = .blue
            }
        }
        
        viewModel.onAddToBookmarkMovieSucceed = { [weak self] in
            self?.bookmarkMovieBtn.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            self?.bookmarkMovieBtn.tintColor = .blue
        }
        
        viewModel.onBookmarkFailure = { error in
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.hideTabbar(vc: self)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.showTabbar(vc: self)
        
    }

   
}

//MARK: - ACTIONS
extension MovieDetailsVC{
    @IBAction func bookmarkBtnPressed(_ sender: UIButton) {
        if let movie = movie{
            if !viewModel.isSaved(movie: movie){
                viewModel.addToBookmark(movie: movie)
            }
        }
    }
}
