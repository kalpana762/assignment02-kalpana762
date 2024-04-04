//
//  ProductDetailsVC.swift
//  S566983ShopcyApp
//
//  Created by Prameela Pathuri on 25/03/2024.
//

import UIKit
import SDWebImage

class ProductDetailsVC: UIViewController {

    
    @IBOutlet weak var ratingLBL: UILabel!
    
    @IBOutlet weak var descriptionTV: UITextView!
    
    @IBOutlet weak var imageChangePC: UIPageControl!
    @IBOutlet weak var imgIV: UIImageView!
    
    
    
    @IBOutlet weak var messageLBL: UILabel!
    
    @IBOutlet weak var priceLBL: UILabel!
    
    
    
    
    @IBOutlet weak var memorySize: UIButton!
    
    
    @IBOutlet weak var itemColors: UIButton!
    
    
    
    
    @IBOutlet weak var cartBTN: UIButton!
    
    
    
    @IBOutlet weak var buyBTN: UIButton!
    
    
    var memory = ""
    var color = ""
    var productKey = ""
    
    var images: [String] = []
    var pageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuPopUpButton()
        setupColorPopUpButton()
        
        
        let prod = FireStoreOperations.products[productKey]
        
        self.navigationItem.title = prod!.title
        
        descriptionTV.text = prod!.description
        ratingLBL.text = String(format: "%0.1f⭐️", prod!.rating)
        
        images = prod!.images
        
        let url = URL(string: images[0])
        imgIV.sd_setImage(with: url) { _, _, _, _ in
            
            
        }
        
        imageChangePC.numberOfPages = prod!.images.count
        imageChangePC.currentPage = 0
        
        
        
        imgIV.isUserInteractionEnabled = true
        
        let price = prod!.price
        let percentage = prod!.discountPercentage
        
        let discount = price * percentage / 100.0




        let discount_price = price - discount
        
        
        priceLBL.text = String(format: "$%0.2f", discount_price)
        
        
        
        
        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(_:)))
       rightGesture.direction = .right
        imgIV.addGestureRecognizer(rightGesture)
        
        
        
        
        
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(_:)))
        leftGesture.direction = .left
        imgIV.addGestureRecognizer(leftGesture)
        
    }
    
    
    
    
    
    func setupColorPopUpButton() {
        let popUpColorButtonClosure = { (action: UIAction) in
 
            
            
            
            
            self.color = action.title
        }
        
        itemColors.menu = UIMenu(children: [
            UIAction(title: "White⬜️", handler: popUpColorButtonClosure),
            
            
            
            UIAction(title: "Black⬛️", handler: popUpColorButtonClosure),
            
            
            
            UIAction(title: "Red🟥", handler: popUpColorButtonClosure),
            
            
            
            UIAction(title: "Green🟩", handler: popUpColorButtonClosure),
            
            
            
            UIAction(title: "Blue🟦", handler: popUpColorButtonClosure)
        ])
        itemColors.showsMenuAsPrimaryAction = true
        
        self.color = "White⬜️"
    }
    
    
    
    
    @objc func swipeGestureHandler(_ sender: UISwipeGestureRecognizer) {
        
        switch sender.direction {
            
            
            
        case .right:
            
            if pageIndex > 0 {
                
                pageIndex -= 1
                
                
                
                
            }
        case .left:
            
            if pageIndex < images.count - 1 {
                
                pageIndex += 1
            }
        default:
            break
        }
        
        
        let url = URL(string: images[pageIndex])
        
        
        
        
        
        
        
        imgIV.sd_setImage(with: url) { _, _, _, _ in
            
        }
        
        imageChangePC.currentPage = pageIndex
    }
    
    func setupMenuPopUpButton() {
        let popUpMenuButtonClosure = { (action: UIAction) in

            self.memory = action.title
        }
        
        memorySize.menu = UIMenu(children: [
            
            
            
            UIAction(title: "128GB", handler: popUpMenuButtonClosure),
            
            
            UIAction(title: "256GB", handler: popUpMenuButtonClosure),
            
            
            UIAction(title: "512GB", handler: popUpMenuButtonClosure),
            
            
            UIAction(title: "1TB", handler: popUpMenuButtonClosure),
            
            
            
            UIAction(title: "2TB", handler: popUpMenuButtonClosure)
        ])
        memorySize.showsMenuAsPrimaryAction = true
        
        self.memory = "128GB"
    }
    
    
 
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

    @IBAction func addToCart(_ sender: Any) {
        
        messageLBL.text = "Item Added to Cart!"
        Task {
            FireStoreOperations.products[productKey]?.cartCount += 1
            
            
            
            await FireStoreOperations.updateProduct(productKey)
        }
        
        cartBTN.isEnabled = false
    }
    
    
    @IBAction func buy(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Confirm Order", message: "Price: \(priceLBL.text!)\nSize: \(memory)\nColor: \(color)", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            
            
            
            self.confirmOrder()
            
            
        }
        alertController.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func confirmOrder() -> Void {
        
        let alertController = UIAlertController(title: "Thank you", message: "Thanks for shopping with us!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        
        
        alertController.addAction(okAction)
        


        present(alertController, animated: true, completion: nil)
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
            
            
            
            self.performSegue(withIdentifier: "productDetailsToLogin", sender: self)
            
        } catch {
            
            print("some error.")
        }
    }
}
