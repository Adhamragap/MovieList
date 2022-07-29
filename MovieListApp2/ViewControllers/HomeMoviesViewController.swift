//
//  HomeMoviesViewController.swift
//  MovieListApp2
//
//  Created by adham ragap on 11/08/2021.
//

import UIKit
import CoreData

class HomeMoviesViewController: UIViewController {
    @IBOutlet weak var activityAndicator: UIActivityIndicatorView!
    var moviesArray: [ResultsData] = []
//  var offlineCoreData : [NSManagedObject] = []
//    var appDelegate:AppDelegate!
//    var managedObjectContext:NSManagedObjectContext!
    @IBOutlet weak var checkBttn: UIBarButtonItem!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityAndicator.startAnimating()
       
//        appDelegate = UIApplication.shared.delegate as! AppDelegate
//        managedObjectContext = appDelegate.persistentContainer.viewContext

     }
    override func viewWillAppear(_ animated: Bool) {
      
            collectionView.delegate = self
            collectionView.dataSource = self
            fetchingMovieImage()

    }
    
    func fetchingMovieImage(){  //For Fetching Movie Image
        ApiServiceManager().fetchDataFromApiByAlamofire { (fetchedMoviesArray, error) -> (Void) in
            if let unwrappedMoviesArray = fetchedMoviesArray{
              //  print("data is coming")
               
                self.moviesArray = unwrappedMoviesArray
                self.activityAndicator.stopAnimating()
                DispatchQueue.main.async {
                    
                    self.collectionView.reloadData()
                }
            }
            if let unwrappedError = error{
                print(unwrappedError)
            }
        }
    }
    
    }
extension HomeMoviesViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let item = moviesArray[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
    
//       let url = moviesArray[indexPath.row].backdrop_path
//        cell.movieImage.sd_setImage(with: URL(string: "http://image.tmdb.org/t/p/w185/\(url  ?? "")")!, placeholderImage: UIImage(systemName:  "square.and.arrow.up"))
        cell.movieImage.layer.masksToBounds = true
        cell.movieImage.layer.cornerRadius = 20
      
    cell.movieImage.loadProfileCover(URL(string: "http://image.tmdb.org/t/p/w185/\(item.backdrop_path ?? "")"))//pod kingfisher for image
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.size.width - 10)/2, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController{
            let itemID = moviesArray[indexPath.row].id
            vc.id = itemID
            vc.comingObject = moviesArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)}
    }
    
    }

