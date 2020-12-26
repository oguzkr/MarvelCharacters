//
//  Settings.swift
//  MarvelCharacters
//
//  Created by Oğuz Karatoruk on 26.12.2020.
//

import Foundation
import UIKit
import CryptoSwift

struct Settings {
    
    static let publicKey:String = "b426daffa89836d275893ff671357411"
    static let privateKey:String = "2640814ba22282f4f38b491ee2b7365ac6be519c"
    static let ts = Date().timeIntervalSince1970.description
    static let hash = "\(ts)\(privateKey)\(publicKey)".md5()
    static let limit = 30
    static let characterRequestURL:String = "https://gateway.marvel.com/v1/public/characters?ts=\(ts)&limit=\(limit)&apikey=\(publicKey)&hash=\(hash)&offset="
    
    
    static let darkColor = UIColor(named: "darkColor")
    static let marvelRedColor = UIColor(named: "marvelRedColor")
    static let marvelRedLightColor = UIColor(named: "marvelRedLightColor")

}
