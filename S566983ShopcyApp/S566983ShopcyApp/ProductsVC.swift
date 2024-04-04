//
//  ProductsVC.swift
//  S566983ShopcyApp
//
//  Created by Prameela Pathuri on 25/03/2024.
//

import UIKit
import SDWebImage

class ProductsVC: UIViewController {
    
    
    @IBOutlet var productViewCLCTN: [ProductView]!
    
    var key = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
        Task {
            await FireStoreOperations.fetchProducts()
            
            self.setProducts()
            
        }
    }
    
    func setProducts() -> Void {
        
        var counter = 0
        for key in ProductKeys.allCases {
            
            guard let product = FireStoreOperations.products[key.rawValue] else { return }
            
            let view = productViewCLCTN[counter]
            
            view.layer.cornerRadius = 4
            view.layer.borderColor = UIColor.black.cgColor
            view.layer.borderWidth = 2
            
            
            view.tag = counter
            
            view.titleLBL.text = product.title
            
            
            
            
            view.descriptionLBL.text = product.description
            
            let thumbnail = product.thumbnail ?? ""
            let url = URL(string: thumbnail)
            view.productIMG.sd_setImage(with: url) { _, _, _, _ in
                
            }
            
            
            
            view.ratingLBL.text = String(format: "%0.1f/5.0", product.rating)
            
            let price = product.price
            let percentage = product.discountPercentage
            
            let discount = price * percentage / 100.0
            let discount_price = price - discount
            view.discountAndActualPriceLBL.text = String(format: "$%0.2f/$%0.2f", discount_price, price)
            

            
            
            let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
            gesture.minimumPressDuration = 0.5
            view.addGestureRecognizer(gesture)
            counter = counter + 1
        }
    }
    
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            
            guard let view = gesture.view as? ProductView else {
                return
            }
            
            let tag = view.tag
            
            let key = ProductKeys.allCases[tag]
            self.key = key.rawValue
            
            performSegue(withIdentifier: "ProductDetail", sender: self)
        }
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
         if segue.identifier == "ProductDetail" {
             
             let vc = segue.destination as! ProductDetailsVC
             vc.productKey = self.key
         }
         
     }
     
    
    
    @IBAction func logout(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Logout", message: "Would you like to logout?", preferredStyle: .alert)
        
        let logoutAction = UIAlertAction(title: "Logout", style: .default) { (_) in
            self.logout()
        }
        alertController.addAction(logoutAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func logout() {
        
        do {
            
            try AuthenticationManager.shared.signOut()
            self.performSegue(withIdentifier: "productsToLogin", sender: self)
            
        } catch {
            
            print("Please try again.")
        }
    }
}
