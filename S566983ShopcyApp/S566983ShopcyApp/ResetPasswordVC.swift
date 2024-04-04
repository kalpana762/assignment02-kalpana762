//
//  ResetPasswordVC.swift
//  S566983ShopcyApp
//
//  Created by Prameela Pathuri on 25/03/2024.
//

import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    
    
    
    @IBOutlet weak var messageLBL: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "resetPasswordToLogin" {
            
            let vc = segue.destination as! LoginVC
        }
    }
    
    
    
    @IBAction func onClickSendLink(_ sender: Any) {
        
        if emailTF.text == "" {
            
            
            
            messageLBL.text = "Please enter email!."
            
            
            return
        }
            
        
        
            Task {
                
                do {
                    
                    try await AuthenticationManager.shared.resetPassword(email: emailTF.text!)
                    self.performSegue(withIdentifier: "resetPasswordToLogin", sender: self)
                    
                } catch {
                    
                    self.messageLBL.text = ""
                }
            }
    }
    

    @IBAction func cancelPasswordReset(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "resetPasswordToLogin", sender: self)
        
        
    }
}
