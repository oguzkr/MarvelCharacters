//
//  comicsModel.swift
//  MarvelCharacters
//
//  Created by Oğuz Karatoruk on 26.12.2020.
//

import Foundation

// MARK: - Comics
struct SelectedHeroComics: Codable {
    let data: SelectedHeroComicDataClass
}

// MARK: - DataClass
struct SelectedHeroComicDataClass: Codable {
    let results: [SelectedHeroComicResult]
}

// MARK: - Result
struct SelectedHeroComicResult: Codable {
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case title
    }
}
