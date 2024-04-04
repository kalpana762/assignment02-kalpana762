//
//  propertyCell.swift
//  sampleexam02
//
//  Created by kalpana on 4/4/24.
//

import UIKit

class propertyCell: UITableViewCell {

    @IBOutlet weak var textLBL: UILabel!
    @IBOutlet weak var propertImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
