//
//  PropertyDetailVC.swift
//  sampleexam02
//
//  Created by kalpana on 4/4/24.
//

import UIKit
import Lottie

class PropertyDetailVC: UIViewController {
   
    var name:String = ""
    var address = ""
    var price = ""
    var image = ""
    var bathroom = -1
    var bedroom = -1
    
    @IBOutlet weak var animationView: LottieAnimationView!
    
    @IBAction func purchase(_ sender: UIButton) {
        var amt = 0.0
        let total = Double(price)
        amt = 0.05*total!
        amt += total!
        animationView.alpha=1
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play(){ _ in
            self.animationView.alpha=0
            let alert = UIAlertController(title: "congratulations", message: "you have purchased the property. Total amount is $\(amt)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
                for(index,prop) in property.data.enumerated(){
                    if(prop.name == self.name){
                        property.purchased.append(prop)
                        property.data.remove(at: index)
                    }
                }
                
            }))
            self.present(alert,animated: true)
            self.purchaseBTN.isEnabled = false
        }
        
    }
    
    @IBOutlet weak var purchaseBTN: UIButton!
    @IBOutlet weak var bathroomLBL: UILabel!
    @IBOutlet weak var bedroomLBL: UILabel!
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var addressLBL: UILabel!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var propertyIV: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nameLBL.text = "Property:\(name)"
        self.addressLBL.text = "Address:\(address)"
        self.bathroomLBL.text = "Bathroom:\(bathroom)"
        self.bedroomLBL.text = "Bedroom:\(bedroom)"
        self.priceLBL.text = "Price:\(price)"
        self.propertyIV.image = UIImage(named: image)

        animationView.alpha = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
