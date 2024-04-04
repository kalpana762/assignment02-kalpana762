//
//  CreateAccountVC.swift
//  S566983ShopcyApp
//
//  Created by Prameela Pathuri on 25/03/2024.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var messageLBL: UILabel!
    
    
    @IBOutlet weak var emailTF: UITextField!
    
    
    @IBOutlet weak var registerBTN: UIButton!
    
    
    @IBOutlet weak var passwordTF: UITextField!
    
    
    @IBOutlet weak var checkPasswordTF: UITextField!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

    
    @IBAction func passwordCheck(_ sender: UITextField) {
        
        if sender.text != checkPasswordTF.text {
            
            messageLBL.text = "Password should match!"
            return
        }
            
            messageLBL.text = ""
    }
    
    
    
    @IBAction func rePasswordCheck(_ sender: UITextField) {
        
        if sender.text != passwordTF.text {
            
            messageLBL.text = "Password should match!"
            return
        }
            
            messageLBL.text = ""
    }
    
    
    
    
    @IBAction func createUser(_ sender: Any) {
        Task { @MainActor in
            
            if emailTF.text == "" {
                
                messageLBL.text = "Please enter email!."
                
                
            }else if passwordTF.text == "" || checkPasswordTF.text == "" {
                
                messageLBL.text = "Please enter password in both fields!"
                
                
            }else if passwordTF.text != checkPasswordTF.text {
                
                messageLBL.text = "Password should match!"
                
                
            }else if passwordTF.text!.count < 6 {
                
                messageLBL.text = "The password must be 6 characters long or more."
                
                
            }else {
                
                Task {
                    
                    await register(email: emailTF.text!, password: passwordTF.text!)
                }
            }
            
        }
    }
    
    
    
    
    func register(email: String, password: String) async {
        do {
            try await AuthenticationManager.shared.createUser(email: email, password: password)
            
            self.performSegue(withIdentifier: "createAccountToLogin", sender: self)
        } catch {
            print("Error:", error.localizedDescription)
        }
    }
    
    
    
    
    @IBAction func cancelAccountCreation(_ sender: Any) {
        
        self.performSegue(withIdentifier: "createAccountToLogin", sender: self)
        
    }
    
}
