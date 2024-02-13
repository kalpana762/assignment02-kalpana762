//
//  ViewController.swift
//  S567076WhackAMole
//
//  Created by Kalpana on 2/9/24.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var timerSV: UIView!
    @IBOutlet  weak var highScoreSV: UIView!
    @IBOutlet weak var scoreSV: UIView!
    @IBOutlet weak var StartBTN: UIButton!
    @IBOutlet weak var Reset: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!

    @IBOutlet weak var launchLAV: LottieAnimationView!
    {
        didSet {
            launchLAV.loopMode = .playOnce
            launchLAV.animationSpeed=1.0
            launchLAV.play { [weak self] _ in
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut]) {
                    self?.launchLAV.alpha = 0.0
                }
            }
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bringSubviewToFront(launchLAV)
        launchLAV.loopMode = .playOnce
        launchLAV.play { completed in
            if completed {
                
                self.launchLAV.isHidden = true
            }
        }
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 163/255, green: 210/255, blue: 86/255, alpha: 1.0)
    
        applyBorder(to: timerSV)
        applyBorder(to: highScoreSV)
        applyBorder(to: scoreSV)
        
        applyattributes(to: button1)
        applyattributes(to: button2)
        applyattributes(to: button3)
        applyattributes(to: button4)
        applyattributes(to: button5)
        applyattributes(to: button6)
        applyattributes(to: button7)
        applyattributes(to: button8)
        applyattributes(to: button9)

        
    }

    func applyBorder(to view: UIView){
        view.layer.cornerRadius = 5.0
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.black.cgColor
    }
    func applyattributes(to button: UIButton){
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.black.cgColor
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
    }
    
    
    
}

