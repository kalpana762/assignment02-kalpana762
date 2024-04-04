//
//  LoginVC.swift
//  S566983ShopcyApp
//
//  Created by Prameela Pathuri on 25/03/2024.
//

import UIKit
import Lottie

class LoginVC: UIViewController {

    @IBOutlet weak var loginLAV: LottieAnimationView!
    
    @IBOutlet weak var messageLBL: UILabel!
    
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    
    @IBOutlet weak var loginBTN: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loginLAV.play()
        loginLAV.loopMode = .loop
        
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

    @IBAction func onLogin(_ sender: Any) {
        
        if usernameTF.text == "" {
            
            messageLBL.text = "Please enter Username!."
            
            
        }else if passwordTF.text == "" {
            
            messageLBL.text = "Please enter Password!"
            
            
        }else {
            
            Task {
                
                await login(email: usernameTF.text!, password: passwordTF.text!)
            }
        }
        
        
    }
    
    
    func login(email: String, password: String) async {
        do {
            
            try await AuthenticationManager.shared.signIn(email: email, password: password)
            
            
            self.performSegue(withIdentifier: "loginToProducts", sender: self)
            
        } catch {
            
            self.messageLBL.text = "Invalid Login Credentials! Please try again."
        }
    }
}
