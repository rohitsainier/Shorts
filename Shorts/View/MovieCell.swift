//
//  MovieCell.swift
//  Shorts
//
//  Created by Rohit Saini on 06/03/22.
//

import UIKit

class MovieCell: UITableViewCell {

    //OUTLETS
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindViewWith(viewModel: MovieViewDelegate) {
        let movie = viewModel.movie
        titleLbl.text = movie.originalTitle
        overviewLbl.text = movie.overview
        ImageClient.shared.setImage(from: movie.posterURL, placeholderImage: nil) { [weak self] image in
            self?.posterImage.image = image
        }
    }
}
