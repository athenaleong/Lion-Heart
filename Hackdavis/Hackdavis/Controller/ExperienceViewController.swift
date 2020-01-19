//
//  ExperienceViewController.swift
//  Hackdavis
//
//  Created by Athena Leong on 1/18/20.
//  Copyright © 2020 Athena Leong. All rights reserved.
//

import UIKit
import Firebase

class ExperienceViewController: UIViewController {
    
    var expList = ["Outdoors","Arts and Crafts", "Culinary","Mentorship and Teaching", "Fundraising", "Caregiving", "Music", "Adverising"]

    @IBOutlet weak var experienceTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        experienceTableView.delegate = self
        experienceTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

}

extension ExperienceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = experienceTableView.dequeueReusableCell(withIdentifier: "ExpCell", for: indexPath) as! ExperienceCell
        print(indexPath.row)
        let exp = expList[indexPath.row]
        cell.expLabel.text = exp
 
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 200
    }
    
    
}


