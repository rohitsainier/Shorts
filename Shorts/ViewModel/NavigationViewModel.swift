//
//  NavigationViewModel.swift
//  Shorts
//
//  Created by Rohit Saini on 07/03/22.
//

import Foundation
import UIKit

protocol NaviagtionDelegate{
    func hideNavigation(vc: UIViewController)
    func showNavigation(vc: UIViewController)
    func hideTabbar(vc: UIViewController)
    func showTabbar(vc: UIViewController)
}

extension NaviagtionDelegate{
    func hideNavigation(vc: UIViewController){
        vc.navigationController?.isNavigationBarHidden = true
    }
    func showNavigation(vc: UIViewController){
        vc.navigationController?.isNavigationBarHidden = false
    }
    func hideTabbar(vc: UIViewController){
        vc.navigationController?.tabBarController?.tabBar.isHidden = true
    }
    func showTabbar(vc: UIViewController){
        vc.navigationController?.tabBarController?.tabBar.isHidden = false
    }
}

