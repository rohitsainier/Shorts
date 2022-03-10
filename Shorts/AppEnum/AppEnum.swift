//
//  AppEnum.swift
//  Shorts
//
//  Created by Rohit Saini on 06/03/22.
//

import Foundation
import UIKit

enum TABLE_VIEW: String{
    case MOVIE_CELL = "MovieCell"
}

enum VIEW_CONTROLLER: String{
    case MOVIE_DETAIL = "MovieDetailsVC"
}

enum APP_LOADER:String{
    case CustomLoader = "CustomLoader"
}

enum STORYBOARD{
    case MAIN
    var load: UIStoryboard{
        switch self {
            case .MAIN:
                return UIStoryboard(name: "Main", bundle: nil)
        }
    }
}
