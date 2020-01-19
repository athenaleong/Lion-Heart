//
//  ListExtension.swift
//  Hackdavis
//
//  Created by Athena Leong on 1/18/20.
//  Copyright © 2020 Athena Leong. All rights reserved.
//

import Foundation
import UIKit
import Firebase


extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestedID.count
       }
       
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListTableView.dequeueReusableCell(withIdentifier: "FilCell", for: indexPath) as! FilteredCell
        let currentID =  suggestedID[indexPath.row]
        let userNode = db.child("event").child(String(currentID))
            userNode.observeSingleEvent(of: .value, with: { (snapshot) in
             if let userDict = snapshot.value as? [String:Any] {
                cell.eventName.text = userDict["name"] as! String
                cell.eventLocation.text = userDict["location"] as! String
                cell.eventDate.text = userDict["day"] as! String
                
             }
        })
    
       return cell
       
   }
       
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 570
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedID = suggestedID[indexPath.row]
        print(selectedID)
        self.performSegue(withIdentifier: "ListToEvent", sender: self)
        
        
        
    }
    
        
        
       
}



