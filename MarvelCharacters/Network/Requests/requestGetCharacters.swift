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
    var url = Settings.characterRequestURL

    func getCharacters(completed: @escaping () -> ()){
        SVProgressHUD.show()
        AF.request(url).responseData { response in
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
                    print(self.url)
                    SVProgressHUD.dismiss()
                }
            }
        }.resume()
    }
    
}
