//
//  CartTableVC.swift
//  S566983ShopcyApp
//
//  Created by Prameela Pathuri on 25/03/2024.
//

import UIKit
import SDWebImage

class CartTableVC: UIViewController {
    
    
    @IBOutlet weak var productsTV: UITableView!
    
    @IBOutlet weak var messageLBL: UILabel!
    
    @IBOutlet weak var priceLBL: UILabel!
    
    var cartProducts: [Product] = []
    var cartKeys : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsTV.delegate = self
        productsTV.dataSource = self
        
        cartKeys.removeAll()
        cartProducts.removeAll()
        
        for key in FireStoreOperations.products.keys {
            
            let val = FireStoreOperations.products[key]
            
            if val?.cartCount ?? 0 > 0 {
                
                cartProducts.append(val!)
                cartKeys.append(key)
            }
        }
        
        self.productsTV.reloadData()
        self.calculateAmount()
        
    }
    

    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     
    
    
    @IBAction func buyCart(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Confirm Order", message: "Do you want make the total purchase of amount \(priceLBL.text ?? "")?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            
            self.clearCart()
            self.confirmOrderAlert()
        }
        alertController.addAction(confirmAction)
        
        // Add Cancel Action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present Alert Controller
        present(alertController, animated: true, completion: nil)
    }
    

    
    
    func confirmOrderAlert() -> Void {
        
        let alertController = UIAlertController(title: "Thank you", message: "Thanks for shopping with us!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        
        // Present Alert Controller
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func clearCart(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Clear Cart", message: "Do you wish to clear items in your cart?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            
            self.clearCart()
        }
        alertController.addAction(confirmAction)
        
        // Add Cancel Action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present Alert Controller
        present(alertController, animated: true, completion: nil)
    }
    
    func clearCart() -> Void {
        
        var i = 0
        for key in cartKeys {
            
            FireStoreOperations.products[key]?.cartCount = 0
            
            Task {
                await FireStoreOperations.updateProduct(key)
                
                i += 1
                if i == cartKeys.count {
                    
                    self.cartKeys.removeAll()
                    self.cartProducts.removeAll()
                    
                    for key in FireStoreOperations.products.keys {
                        
                        let prod = FireStoreOperations.products[key]
                        if prod?.cartCount ?? 0 > 0 {
                            
                            cartProducts.append(prod!)
                            cartKeys.append(key)
                        }
                    }
                }
                
                self.productsTV.reloadData()
                self.calculateAmount()
            }
        }
    }
    
    
    
    func calculateAmount() {
        
        var total = 0.0
        
        for i in 0..<cartProducts.count {
            
            let product = cartProducts[i]
            
            let price = product.price
            let percentage = product.discountPercentage
            
            let discount = price * percentage / 100.0
            let discount_price = price - discount
            
            let counter = Double(product.cartCount)
            let prodcut_toal = counter * discount_price
            
            total += prodcut_toal
        }
        
        priceLBL.text = String(format: "$%0.2f", total)
    }
    
    
    
}


extension CartTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cartProducts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! productCell

        
        let product = cartProducts[indexPath.row]
        
        let url_str = product.thumbnail
        let url = URL(string: url_str)
        cell.productIV.sd_setImage(with: url) { _, _, _, _ in
            
        }
        
        cell.titleLBL.text = product.title
        
        let price = product.price
        let percentage = product.discountPercentage
        
        let discount = price * percentage / 100.0
        let discount_price = price - discount
        
        cell.priceLBL.text = String(format: "$%0.2f", discount_price)
        cell.productCountLBL.text = String(format: "%d", product.cartCount)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let minusAction = UIContextualAction(style: .normal, title: "+") { [weak self] (action, view, completionHandler) in
            
            let key = self?.cartKeys[indexPath.row] ?? ""
            Task {
                
                
                FireStoreOperations.products[key]?.cartCount += 1
                
                
                
                await FireStoreOperations.updateProduct(key)
                
                
                self?.cartKeys.removeAll()
                self?.cartProducts.removeAll()
                
                for key in FireStoreOperations.products.keys {
                    
                    let val = FireStoreOperations.products[key]
                    
                    if val?.cartCount ?? 0 > 0 {
                        
                        self?.cartProducts.append(val!)
                        self?.cartKeys.append(key)
                    }
                }
                
                self?.productsTV.reloadData()
                self?.calculateAmount()
            }
        }
        minusAction.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [minusAction])
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let plusAction = UIContextualAction(style: .normal, title: "-") { [weak self] (action, view, completionHandler) in
            
            let key = self?.cartKeys[indexPath.row] ?? ""
            
            Task {
                
                
                FireStoreOperations.products[key]?.cartCount -= 1
                
                
                
                await FireStoreOperations.updateProduct(key)
                
                
                self?.cartKeys.removeAll()
                self?.cartProducts.removeAll()
                
                for key in FireStoreOperations.products.keys {
                    
                    let val = FireStoreOperations.products[key]
                    
                    if val?.cartCount ?? 0 > 0 {
                        
                        self?.cartProducts.append(val!)
                        self?.cartKeys.append(key)
                    }
                }
                
                self?.productsTV.reloadData()
                self?.calculateAmount()
            }
            
        }
        plusAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [plusAction])
    }

 
}
