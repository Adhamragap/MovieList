//
//  ReviewViewController.swift
//  MovieListApp2
//
//  Created by adham ragap on 16/08/2021.
//

import UIKit

class ReviewViewController: UIViewController {


    @IBOutlet weak var reviewDeeply: UILabel!
    var x = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewDeeply.text = x
    }
    

    
}
