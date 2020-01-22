//
//  ListViewController.swift
//  Hackdavis
//
//  Created by Athena Leong on 1/18/20.
//  Copyright © 2020 Athena Leong. All rights reserved.
//

import UIKit
import Firebase



class ListViewController: UIViewController {
    @IBOutlet weak var ListTableView: UITableView!
    
    var suggestedID = [String]()
    var suggestedDict: [Dictionary<String, Any>] = []
    var selectedID = "a"
    let db = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListTableView.delegate = self
        ListTableView.dataSource = self
        
        //to send off data and retrieve json
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "ListToEvent"{
               let destinationVC = segue.destination as! EventViewController
            destinationVC.selectedID = selectedID
                
        }
    }
    

    
}



