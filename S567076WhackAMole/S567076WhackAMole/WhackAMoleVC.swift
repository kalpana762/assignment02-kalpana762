//
//  WhackAMoleVC.swift
//  S567076WhackAMole
//
//  Created by Kalpana on 2/13/24.
//

import UIKit
import Lottie
import AudioToolbox

class WhackAMoleVC: UIViewController {
    var gameTime: Timer?
    var timeRemaining = 60
    var scoring = 0
    var moleWhackedCount = 0
    var moleCount = 0
    var explosionCount = 0
    var bombCount = 0
    var highScore: Int {
        get {
            UserDefaults.standard.integer(forKey: "HighScore")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "HighScore")
        }
    }
    
    @IBOutlet weak var timerLBL: UILabel!
    @IBOutlet weak var highScoreLBL: UILabel!
    @IBOutlet weak var scoreLBL: UILabel!
    @IBOutlet weak var scoreSV: UIStackView!
    @IBOutlet weak var highScoreSV: UIStackView!
    @IBOutlet weak var timerSV: UIStackView!
    @IBOutlet weak var startBTN: UIButton!
    @IBOutlet var gameBtnCLCTN: [UIButton]!

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
    @IBAction func onClickGameBTN(_ sender: UIButton){
        if let currentImage = sender.currentImage {
                if currentImage == UIImage(named: "mole") {
                    sender.setImage(UIImage(named: "moleHit"), for: .normal)
                    scoring += 10
                    moleWhackedCount += 1
                    AudioServicesPlaySystemSound(1001)
                } else if currentImage == UIImage(named: "bomb") {
                    sender.setImage(UIImage(named: "blast"), for: .normal)
                    scoring -= 5
                    explosionCount += 1
                    AudioServicesPlaySystemSound(1322)
                }
                scoreLBL.text = "Score: \(scoring)"
            }
    }
    @IBAction func onStart(_ sender: UIButton){
         timerStart()
         enableButtons()
         startBTN.isEnabled = false
        
    }
    func timerStart(){
        gameTime = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func timerUpdate(){
        let minutes = timeRemaining / 60
                let seconds = timeRemaining % 60
                timerLBL.text = String(format: "%02d:%02d", minutes, seconds)
                if timeRemaining == 0 {
                    gameEnd()
                } else {
                    let randomIndex = Int.random(in: 0..<gameBtnCLCTN.count)
                    updateButton(at: randomIndex)
                }
        timeRemaining -= 1
    }
    func updateButton(at index: Int) {
            let button = gameBtnCLCTN[index]
            let isMole = !isPrime(Int.random(in: 1...100))
            let imageName = isMole ? "mole" : "bomb"
            if isMole {
                moleCount += 1
            } else {
                bombCount += 1
            }
            button.setImage(UIImage(named: imageName), for: .normal)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                button.setImage(UIImage(named: "hole"), for: .normal)
            }
        }
    func isPrime(_ number: Int) -> Bool {
            if number <= 1 {
                return false
            }
            if number <= 3 {
                return true
            }
            var i = 2
            while i*i <= number {
                if number % i == 0 {
                    return false
                }
                i += 1
            }
            return true
        }
    
    
    func gameEnd(){
        gameTime?.invalidate()
        timeRemaining = 60
        timerLBL.text = "1:00"
        updateHighScore()
        startBTN.isEnabled = false
        enableButtons()
        let message = "Your score is \(scoring).\nYou have tapped on the mole \(moleWhackedCount) times out of \(moleCount).\nYou have tapped on the bomb \(explosionCount) times out of \(bombCount)."
        let alert = UIAlertController(title: "Time's Up! ⏱⏱", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onReset(_ sender: UIButton){
        gameReset()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 163/255, green: 210/255, blue: 86/255, alpha: 1.0)
        // Do any additional setup after loading the view.
        applyBorder(to: timerSV)
        applyBorder(to: highScoreSV)
        applyBorder(to: scoreSV)
        applyattributes(to: gameBtnCLCTN)
        highScoreLBL.text = String(highScore)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func applyBorder(to view: UIView){
        view.layer.cornerRadius = 5.0
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.black.cgColor
    }
    func applyattributes(to button: [UIButton]){
        for buttons in button{
            buttons.layer.cornerRadius = 5.0
            buttons.layer.borderWidth = 2.0
            buttons.layer.borderColor = UIColor.black.cgColor
            buttons.contentVerticalAlignment = .fill
            buttons.contentHorizontalAlignment = .fill
        }
    }
    func updateHighScore() {
            if scoring > highScore {
                highScore = scoring
                highScoreLBL.text = String(highScore)
            }
        }
    func gameReset(){
        timeRemaining = 60
        scoring = 0
                moleWhackedCount = 0
                moleCount = 0
                explosionCount = 0
                bombCount = 0
                timerLBL.text = "01:00"
                scoreLBL.text = "Score: 0"
                startBTN.isEnabled = true
                for button in gameBtnCLCTN {
                    button.setImage(UIImage(named: "hole"), for: .normal)
                }
        gameTime?.invalidate()
                updateHighScore()
        AudioServicesPlaySystemSound(1152)
    }
    func enableButtons() {
        for button in gameBtnCLCTN {
            button.isEnabled = true
        }
    }
    
    func disableButtons() {
        for button in gameBtnCLCTN {
            button.isEnabled = false
        }
    }
}
