//
//  CharacterDetailViewController.swift
//  MarvelCharacters
//
//  Created by Oğuz Karatoruk on 26.12.2020.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var imageViewChar: UIImageView!
    @IBOutlet weak var textViewChar: UITextView!
    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var charName = String()
    var charImageURL = String()
    var charDesc = String()
    var charComics = [SelectedHeroComicResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setHeroData()
    }
    
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setHeroData(){
        //set navigation title to character name
        self.navigationItem.title = charName
        //set image
        let url = URL(string: charImageURL)
        imageViewChar.sd_setImage(with: url, placeholderImage: UIImage.gif(asset: "load.gif"))
        //set comics label
        if charComics.count == 0 {
            labelHeader.text = "\(charName) has no comics".uppercased()
        }
        //set desc label depend on how mony comics character has
        if charDesc == "" {
            textViewChar.text = "No descriptoion for \(charName)"
        } else {
            textViewChar.text = charDesc
        }
        
        imageViewChar.layer.cornerRadius = 5
        imageViewChar.clipsToBounds = true
    }

}

extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charComics.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "comicsCell", for: indexPath) as! comicsTableViewCell

        cell.labelComicsTitle.text = charComics[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

}
