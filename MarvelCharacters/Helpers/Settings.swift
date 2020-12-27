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
    //BASE INFO
    static let publicKey:String = "b426daffa89836d275893ff671357411"
    static let privateKey:String = "2640814ba22282f4f38b491ee2b7365ac6be519c"
    static let ts = Date().timeIntervalSince1970.description
    static let hash = "\(ts)\(privateKey)\(publicKey)".md5()
    static let limit = 30
    
    //TO GET CHARACTER LIST
    static let characterRequestURL:String = "https://gateway.marvel.com/v1/public/characters?ts=\(ts)&limit=\(limit)&apikey=\(publicKey)&hash=\(hash)&offset="
    
    //TO GET CHARACTER COMICS
    static let characterComicsBaseURL:String = "https://gateway.marvel.com:443/v1/public/characters/" //+charID
    static let characterComicsSpesifications:String = "/comics?format=comic&formatType=comic&orderBy=-onsaleDate&limit=10&ts=\(ts)&limit=\(limit)&apikey=\(publicKey)&hash=\(hash)&dateRange=2005-01-01%2C" //+todays date
}
