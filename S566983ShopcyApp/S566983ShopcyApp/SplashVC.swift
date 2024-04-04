//
//  SplashVC.swift
//  S566983ShopcyApp
//
//  Created by Prameela Pathuri on 25/03/2024.
//

import UIKit
import Lottie

class SplashVC: UIViewController {

    
    @IBOutlet weak var launchLAV: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        launchLAV.play { isDone in
            
            if isDone {
                
                self.performSegue(withIdentifier: "SplashToLogin", sender: self)
            }
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "SplashToLogin" {
            
            let vc = segue.destination as! LoginVC
        }
        
    }
    

}
