//
//  ProductView.swift
//  S566983ShopcyApp
//
//  Created by Prameela Pathuri on 25/03/2024.
//

import UIKit

class ProductView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLBL: UILabel!
    
    @IBOutlet weak var descriptionLBL: UILabel!
    
    
    @IBOutlet weak var ratingLBL: UILabel!
    @IBOutlet weak var discountAndActualPriceLBL: UILabel!
    
    
    
    @IBOutlet weak var productIMG: UIImageView!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }

    func customInit() {
        
        Bundle.main.loadNibNamed("ProductView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        productIMG.isUserInteractionEnabled = true
        productIMG.contentMode = .scaleToFill
        contentView.layer.cornerRadius = 6
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.borderWidth = 2.0
        contentView.clipsToBounds = true
    }
}
