//
//  FavouriteTableViewCell.swift
//  MovieListApp2
//
//  Created by adham ragap on 17/08/2021.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var moveName: UILabel!
    @IBOutlet weak var moveImage: UIImageView!
    @IBOutlet weak var movieRating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
