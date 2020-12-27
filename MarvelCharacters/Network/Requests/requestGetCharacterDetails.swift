//
//  requestGetCharacters.swift
//  MarvelCharacters
//
//  Created by Oğuz Karatoruk on 26.12.2020.
//

import Foundation
import Alamofire
import SVProgressHUD

class networkManager {
    
    var characters = [Result]()
    var selectedCharComics = [SelectedHeroComicResult]()

    var getCharListUrl = Settings.characterRequestURL

    func getCharacters(offset: Int, completed: @escaping () -> ()){
        SVProgressHUD.show()
        AF.request("\(getCharListUrl)\(offset)").responseData { response in
            switch response.result {
            case .failure(let error):
                print("ERROR failure: \(error)")
            case .success(let data):
                do {
                    let characterData = try JSONDecoder().decode(Characters.self, from: data)
                    self.characters = characterData.data.results
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        completed()
                    }
                } catch let error {
                    print("ERROR: \(error)")
                    SVProgressHUD.dismiss()
                }
            }
        }.resume()
    }
    
    func getComicsOfCharacter(characterID:Int, completed: @escaping () -> ()){
        SVProgressHUD.show()
        let requestURL = "\(Settings.characterComicsBaseURL)\(characterID)\(Settings.characterComicsSpesifications)\(todaysDate())"
        
        AF.request(requestURL).responseData { response in
            switch response.result {
            case .failure(let error):
                print("ERROR failure: \(error)")
            case .success(let data):
                do {
                    let comicsData = try JSONDecoder().decode(SelectedHeroComics.self, from: data)
                    self.selectedCharComics = comicsData.data.results
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        completed()
                    }
                } catch let error {
                    print("ERROR: \(error)")
                    SVProgressHUD.dismiss()
                }
            }
        }.resume()
    }
    
    func todaysDate()->String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        return result
    }
    
}
