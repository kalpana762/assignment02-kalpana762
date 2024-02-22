//
//  EventPlannerVCViewController.swift
//  KalpanaExam01
//
//  Created by Guest User on 2/21/24.
//

import UIKit

class EventPlannerVCViewController: UIViewController {
    @IBOutlet var banquetHallIMG: UIImageView!
    @IBOutlet var caterSWCH: UISwitch!
    @IBOutlet var banquetHallSizeSC: UISegmentedControl!
    @IBOutlet var venueF: UITextField!
    @IBOutlet var numGuestsTF: UITextField!
    @IBOutlet var promoTF: UITextField!
    @IBOutlet var bookBTN: UIButton!
    @IBOutlet var Clear: UIButton!
    var total = 0
    @IBAction func selectBanquetHall(_ sender: UISegmentedControl) {
        switch banquetHallSizeSC.selectedSegmentIndex{
        case 0:
            total += 5000
            banquetHallIMG.image = UIImage(named: "small")
        case 1:
            total += 10000
            banquetHallIMG.image = UIImage(named: "medium")
        case 2:
            total += 15000
            banquetHallIMG.image = UIImage(named: "large")
        default:
            break
        }
    }
    
    @IBAction func book(_ sender: UIButton) {
        guard let venue = venueF.text, !venue.isEmpty else{
            venueF.placeholder = "please enter the venue."
            return
        }
        guard let guests = numGuestsTF.text, !guests.isEmpty, let guest = Int(guests) else{
            numGuestsTF.placeholder = "please enter the number of guests may attend."
            return
        }
        
        if(caterSWCH.isOn){
            total += 150 * guest
        }
        switch banquetHallSizeSC.selectedSegmentIndex{
        case 0:
            total += 5000
            banquetHallIMG.image = UIImage(named: "small")
        case 1:
            total += 10000
            banquetHallIMG.image = UIImage(named: "medium")
        case 2:
            total += 15000
            banquetHallIMG.image = UIImage(named: "large")
        default:
            break
        }
        if let promo = promoTF.text, promo.lowercased() == "ugadi"{
            total -= total*10/100
        }
        
        let alert = UIAlertController(title: "Booking Details", message: "venue : \(venue)\nNumber of guests: \(guest)\ntotalPrice : \(total)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.bookBTN.isEnabled = false
        }))
        present(alert,animated: true,completion: nil)
        
    }
    
    
    @IBAction func clear(_ sender: UIButton) {
        setupinitial()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupinitial()
        
        
        // Do any additional setup after loading the view.
    }
    func setupinitial(){
        banquetHallIMG.image = UIImage(named: "small")
        caterSWCH.isOn = false
        banquetHallSizeSC.selectedSegmentIndex = 0
        bookBTN.isEnabled = true
        Clear.isEnabled = true
        venueF.placeholder = "venue"
        numGuestsTF.placeholder = "total number of guests"
        promoTF.placeholder = "promo code"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    #Preview("KalpanaExam01"){
        UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
    }
    
}
