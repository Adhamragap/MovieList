//
//  FavouriteViewController.swift
//  MovieListApp2
//
//  Created by adham ragap on 11/08/2021.
//

import UIKit
import CoreData

class FavouriteViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var appDelegate:AppDelegate!
    var managedObjectContext:NSManagedObjectContext!
    var allMovies: [ResultsData] = [] // the array which we will use it in favourite table view
    var coreDataMoviesArray : [NSManagedObject] = [] // core data array
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
//        tableView.delegate = self
//        tableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteMovie") // for fetching coreData in favorite tableview
        tableView.delegate = self
        tableView.dataSource = self
        do {
            
            
          coreDataMoviesArray = try managedObjectContext.fetch(fetchRequest)
            allMovies.removeAll()
            for mov in coreDataMoviesArray{
                let name = mov.value(forKey: "name") as! String
                let rating = mov.value(forKey: "rating") as! Double
                let img = mov.value(forKey: "img") as! String
                
                let movObject = ResultsData( backdrop_path: img, id: 0, overview: "", poster_path: "", release_date: "", title: name, vote_average: rating, vote_count: 0)
                allMovies.append(movObject)
            }
            
            tableView.reloadData()
            
            
            
            
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    
  
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allMovies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavouriteTableViewCell
        let item = allMovies[indexPath.row]
//        cell.textLabel?.text = allMovies[indexPath.row].title
//        cell.detailTextLabel?.text = allMovies[indexPath.row].release_date
//        cell.imageView?.loadProfileCover(URL(string: "http://image.tmdb.org/t/p/w185/\(item.backdrop_path ?? "")"))
        cell.movieRating.text = "rate \(allMovies[indexPath.row].vote_average) of 10"
        cell.moveName.text = allMovies[indexPath.row].title
        cell.moveImage.loadProfileCover(URL(string: "http://image.tmdb.org/t/p/w185/\(item.backdrop_path ?? "")"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            allMovies.remove(at: indexPath.row)
            managedObjectContext.delete(coreDataMoviesArray[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        navigationController?.popViewController(animated: true)
    }
}
