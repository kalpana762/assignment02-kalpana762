//
//  productCell.swift
//  S566983ShopcyApp
//
//  Created by Prameela Pathuri on 25/03/2024.
//

import UIKit

class productCell: UITableViewCell {

    @IBOutlet weak var productCountLBL: UILabel!
    
    
    @IBOutlet weak var titleLBL: UILabel!
    
    @IBOutlet weak var productIV: UIImageView!
    
    
    
    @IBOutlet weak var priceLBL: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
