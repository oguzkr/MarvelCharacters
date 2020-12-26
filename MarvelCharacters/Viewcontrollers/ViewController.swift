//
//  ViewController.swift
//  MarvelCharacters
//
//  Created by Oğuz Karatoruk on 26.12.2020.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftGifOrigin
import SVProgressHUD

class ViewController: UIViewController {
    
    var network: networkManager = networkManager()
    var characters = [Result]()
    var scrollcontrol = true
    var cameraFilterOptions = Array<String>()
    let margin: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        network.getCharacters() {
            self.characters = self.network.characters
            //self.collectionView.reloadData()
            print(self.characters[0].name)
        }
    }


}

