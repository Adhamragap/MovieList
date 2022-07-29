//
//  ViewController.swift
//  MovieListApp2
//
//  Created by adham ragap on 11/08/2021.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func fetchData(_ sender: Any) {
//        ApiServiceManager().fetchDataFromAPI { (moviesArray, error) -> (Void) in
//            if let unwrapedMoviesArray = moviesArray{
//                print(moviesArray)
////
//
//            }
//            if let unwrapedError = error{
//                print(error)
//            }
//        ApiServiceManager().fetchDataFromApiByAlamofire{ (moviesArray, error) -> (Void) in
//            if let unwrappedmoviesArray = moviesArray{
//                DispatchQueue.main.async { [self] in
//                    self.movieName.text = unwrappedmoviesArray[0].title
//                    movieImage.sd_setImage(with: URL(string: "\(unwrappedmoviesArray[0].backdrop_path)"), placeholderImage: UIImage(systemName: "exclamationmark.icloud"))
//
//                }
//            if let unwrappedError = error{
//                print(unwrappedError)
//            }
//        }
      
    }
    


    }

