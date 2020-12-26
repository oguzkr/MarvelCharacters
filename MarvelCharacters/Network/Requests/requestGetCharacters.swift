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
    
    func getCharacters(page: Int, completed: @escaping () -> ()){
        SVProgressHUD.show()
        AF.request("\(url)\(page)").responseData { response in
            switch response.result {
            case .failure(let error):
                print("ERROR failure: \(error)")
            case .success(let data):
                do {
                    let characterData = try JSONDecoder().decode(Characters.self, from: data)
                    self.characters = characterData.data.results
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        print(self.url)
                        completed()
                    }
                } catch let error {
                    print("ERROR: \(error)")
                    SVProgressHUD.dismiss()
                }
            }
        }.resume()
    }
    
}
