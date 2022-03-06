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
    
    var movie: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()

        // Do any additional setup after loading the view.
    }
    
    private func configUI(){
        if let movie = movie{
            titleLbl.text = movie.originalTitle
            overviewLbl.text = movie.overview
            ImageClient.shared.setImage(from: movie.posterURL, placeholderImage: nil) { [weak self] image in
                self?.posterImage.image = image
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }

}
