//
//  EventViewController.swift
//  Hackdavis
//
//  Created by Athena Leong on 1/18/20.
//  Copyright © 2020 Athena Leong. All rights reserved.
//

import UIKit
import Firebase

class EventViewController: UIViewController {

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var goingButton: UIButton!
    
    var selectedID : String = "a"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = Database.database().reference()
        let userNode = db.child("event").child(selectedID)
                userNode.observeSingleEvent(of: .value, with: { (snapshot) in
                 if let userDict = snapshot.value as? [String:Any] {
                    self.eventName.text = userDict["name"] as! String
                    self.eventLocation.text = userDict["location"] as! String
                    self.eventDate.text = userDict["day"] as! String
                    self.eventDescription.text = userDict["description"] as! String
                    
                    
                 }
            })
        
        
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
