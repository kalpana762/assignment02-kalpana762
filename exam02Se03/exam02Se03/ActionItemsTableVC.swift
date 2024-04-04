//
//  ActionItemsTableVC.swift
//  exam02Se03
//
//  Created by kalpana on 4/4/24.
//

import UIKit

class ActionItemsTableVC: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    let dataManager = DataManager.sharedDataManager
    
    func tableView(_ tableView: UITableView, numberOfSections section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50.0)
    }

    @IBOutlet weak var ActionTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
