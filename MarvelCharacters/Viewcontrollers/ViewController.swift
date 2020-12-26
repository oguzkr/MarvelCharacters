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
    var offSet = 0
    let margin: CGFloat = 10
    
    //VARAIBLES FOR DETAIL SCREEN
    var charName = String()
    var charImageURL = String()
    var charDesc = String()
    var charComics = [String]()
    

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectioView()
        network.getCharacters(offset: 0) {
            self.characters = self.network.characters
            self.collectionView.reloadData()
        }
    }
    
    func setCollectioView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        guard let collectionView = collectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
           flowLayout.minimumInteritemSpacing = margin
           flowLayout.minimumLineSpacing = margin
           flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }

    
    func insertNextPage(){
        offSet += 30
        network.getCharacters(offset: offSet) {
            print("Inserted between \(self.offSet) - \(self.offSet+30)")
            self.characters += self.network.characters
            self.collectionView.reloadData()
            self.scrollcontrol = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHeroDetail" {
            let detailVC = segue.destination as! CharacterDetailViewController
            detailVC.charName = charName
            detailVC.charImageURL = charImageURL
            detailVC.charDesc = charDesc
            detailVC.charComics = charComics
        }
    }
}




//MARK: EXTENSIONS
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height + 30  && scrollcontrol == true{
            if self.characters.count >= 30 {
                scrollcontrol = false
                insertNextPage()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        charImageURL = self.characters[indexPath.row].thumbnail.path + "." + self.characters[indexPath.row].thumbnail.thumbnailExtension.rawValue

        charName = self.characters[indexPath.row].name
        charDesc = self.characters[indexPath.row].resultDescription ?? "NO DESC"
        for comics in self.characters[indexPath.row].comics.items {
            charComics.append(comics.name)
            
            print("Appended \(comics.name)")
        }
    
   
        
        performSegue(withIdentifier: "showHeroDetail", sender: self)

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String = "cell"
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath as IndexPath)
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        let charname: UILabel = cell.contentView.viewWithTag(2) as! UILabel
        let image : UIImageView = cell.contentView.viewWithTag(1) as! UIImageView
        
        charname.text = self.characters[indexPath.row].name.uppercased()
        let url = URL(string: "\(self.characters[indexPath.row].thumbnail.path + "." + self.characters[indexPath.row].thumbnail.thumbnailExtension.rawValue)")
        image.sd_setImage(with: url, placeholderImage: UIImage.gif(asset: "load.gif"))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: 200)
    }
}
