//
//  ContentTableViewCell.swift
//  MovieListApp2
//
//  Created by adham ragap on 15/08/2021.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    @IBOutlet weak var labelContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
