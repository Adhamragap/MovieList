//
//  DetailsViewController.swift
//  MovieListApp2
//
//  Created by adham ragap on 12/08/2021.
//

import UIKit
import Cosmos
import youtube_ios_player_helper
import CoreData

class DetailsViewController: UIViewController {
  
    var comingObject: ResultsData!
    var detailsArray = [Results]()
    var reviewsArray = [ResultsReview]()
    var allMovies : [ResultsData] = []
    var isCliced:Bool = false
    @IBOutlet weak var changeSaveButton: UIButton!
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var starCosmos: CosmosView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var descriptinLabel: UILabel!
    @IBOutlet weak var releseLabel: UILabel!
    var id: Int?
    var appDelegate:AppDelegate!
    var managedObjectContext:NSManagedObjectContext!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        changeSaveButton.tintColor = UIColor.yellow
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        callAPIForTrailer(id: id)
        callAPIForReivews(id: id)
        starCosmos.settings.fillMode = .precise
        starCosmos.rating  = (comingObject.vote_average) / 2
        movieImg.layer.masksToBounds = true
        movieImg.layer.cornerRadius = 20
        setupUi()
        
    }
    
    private func callAPIForTrailer(id: Int?) {
        APIserviceManagerTrailersByAlamofire().fetchDataFortrailers(id: id) { (fetchedData, error) -> (Void) in
            if let unwrappedData = fetchedData{
                self.detailsArray = unwrappedData
              
              //print(self.detailsArray)
                DispatchQueue.main.async {
                    
                    self.collectionView.reloadData()
                }
                //print ("data came : \(unwrappedData)")
                //print(self.id ?? 0)
                //print(self.comingObject.id ?? 0)
                self.movieName.text = self.comingObject.title
                self.movieImg.loadProfileCover(URL(string: "http://image.tmdb.org/t/p/w185/\(self.comingObject.poster_path ?? "")"))
              
                self.descriptinLabel.text = self.comingObject.overview
                self.releseLabel.text = "Realese:  \(self.comingObject.release_date!)"
                
            }
            if let unwrappedError = error{
                print(unwrappedError)
            }
        }
        
    }
    
    private func callAPIForReivews(id: Int?){
        APIserviceManagerReviewesByAlamofire().fetchDataForReviews(id: id) { (fetchedData, error) -> (Void) in
            if let unwrappedData = fetchedData{
               self.reviewsArray = unwrappedData
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            }
            if let unwrappedError = error{
                print(unwrappedError)
            }
        }

        
        
        
         
        
    }
    
    @IBAction func saveBttn(_ sender: Any) {
        switch isCliced {
        case false:
            changeSaveButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            let vc = storyboard?.instantiateViewController(identifier: "FavouriteViewController") as! FavouriteViewController
            navigationController?.pushViewController(vc, animated: true)
                        let entity = NSEntityDescription.entity(forEntityName: "FavouriteMovie", in: managedObjectContext)!
                        let favouriteMovie = NSManagedObject(entity: entity, insertInto: managedObjectContext)
                        favouriteMovie.setValue(comingObject.title, forKey: "name")
                        favouriteMovie.setValue(comingObject.vote_average, forKey: "rating")
                        favouriteMovie.setValue(comingObject.backdrop_path , forKey: "img")
                        do {
                            try  managedObjectContext.save()
                            print("data saved")
                        } catch let error as NSError {
                            print(error.localizedDescription)
                        }
            isCliced = true
        default:
            changeSaveButton.setImage(UIImage(systemName: "star"), for: .normal)
//            let vc = storyboard?.instantiateViewController(identifier: "FavouriteViewController") as! FavouriteViewController
//            navigationController?.pushViewController(vc, animated: true)
            isCliced = false
        }

    }
    

}
    extension DetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!
        TrailerCollectionViewCell
        let key = detailsArray[indexPath.row].key ?? ""
        cell.trailerShow.load(withVideoId: key)
        return cell
    }
    func setupUi(){
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2)), subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior =  .paging
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = layout
        }
    
    }

extension DetailsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTable", for: indexPath)
        cell.textLabel?.text = reviewsArray[indexPath.row].content ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ReviewVC") as! ReviewViewController
        vc.x = reviewsArray[indexPath.row].content ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
  
  
}
    


    
    
    
    
    
    
    
    
    
    
    
    
    
    

