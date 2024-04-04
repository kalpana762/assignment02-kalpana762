//
//  PropertyVC.swift
//  sampleexam02
//
//  Created by kalpana on 4/4/24.
//

import UIKit

class PropertyVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var sample:property = property(name: "", propertyImage: "", address: "", price: 0, numberOfBedrooms: 0, numberOfBathrooms: 0)
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return property.section.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
        case 0..<3:
            return property.section[section]
        default:
            return property.section[section]
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return property.first.count
        case 1:
            return property.second.count
        case 2:
            return property.Third.count
        default:
            return property.purchased.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = propertyTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? propertyCell
        let sec = indexPath.section
        switch(sec){
        case 0:
            cell?.propertImg.image=UIImage(named: property.first[indexPath.row].propertyImage)
            cell?.textLBL.text = property.first[indexPath.row].name
        case 1:
            cell?.propertImg.image=UIImage(named: property.second[indexPath.row].propertyImage)
            cell?.textLBL.text = property.second[indexPath.row].name
        case 2:
            cell?.propertImg.image=UIImage(named: property.Third[indexPath.row].propertyImage)
            cell?.textLBL.text = property.Third[indexPath.row].name
        default:
            cell?.propertImg.image=UIImage(named: property.purchased[indexPath.row].propertyImage)
            cell?.textLBL.text = property.purchased[indexPath.row].name
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.section){
        case 0:
            sample = property.first[indexPath.row]
            performSegue(withIdentifier: "propertyListings", sender: self)
        case 1:
            sample = property.second[indexPath.row]

            performSegue(withIdentifier: "propertyListings", sender: self)
        case 2:
            sample = property.Third[indexPath.row]

            performSegue(withIdentifier: "propertyListings", sender: self)
        case 3:
            sample = property.Third[indexPath.row]

            performSegue(withIdentifier: "propertyListings", sender: self)
        default:
            print("Its a purchased section")
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "propertyListings"){
            let destVC = segue.destination as? PropertyDetailVC
            destVC?.address=sample.address
            destVC?.name=sample.name
            destVC?.bathroom=sample.numberOfBathrooms
            destVC?.bedroom=sample.numberOfBedrooms
            destVC?.price=String(sample.price)
            destVC?.image=sample.propertyImage
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        property.first.removeAll()
        property.second.removeAll()
        property.Third.removeAll()
        for inp in property.data{
            switch(inp.price){
            case 500000..<750000:
                property.first.append(inp)
            case 750000..<10000000:
                property.second.append(inp)
            case 10000000...:
                property.Third.append(inp)
            default:
                property.purchased.append(inp)
            }
        }
        propertyTableView.reloadData()
    }
    
    @IBOutlet weak var propertyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.propertyTableView.delegate=self
        self.propertyTableView.dataSource = self
        
        for inp in property.data{
            switch(inp.price){
            case 500000..<750000:
                property.first.append(inp)
            case 750000..<10000000:
                property.second.append(inp)
            case 10000000...:
                property.Third.append(inp)
            default:
                property.purchased.append(inp)
            }
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
