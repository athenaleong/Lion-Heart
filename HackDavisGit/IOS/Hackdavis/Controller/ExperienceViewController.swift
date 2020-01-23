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
    
    @IBOutlet weak var logOutButton: UIButton!
    
    var expList = ["Outdoors","Arts and Crafts", "Culinary","Mentorship and Teaching", "Fundraising", "Caregiving", "Music", "Adverising"]
    var selectedID: Int?
    var suggestedID = ["a", "b"] //FIXME

    @IBOutlet weak var experienceTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        experienceTableView.delegate = self
        experienceTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "ExperienceToList"{
               let destinationVC = segue.destination as! ListViewController
            destinationVC.suggestedID = suggestedID
        }
    }
    
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        try! Auth.auth().signOut()
         print("hello")
        self.dismiss(animated: false, completion: nil)
    }
    
}

extension ExperienceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = experienceTableView.dequeueReusableCell(withIdentifier: "ExpCell", for: indexPath) as! ExperienceCell
        print(indexPath.row)
        let exp = expList[indexPath.row]
        print(exp)
        cell.expLabel.text = exp
 
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedID = indexPath.row
        print(expList[selectedID!])
        var dic = ["uid" : Auth.auth().currentUser!.uid, "experiences": expList[selectedID!] ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dic)
        
        // create post request
        let url = URL(string: "http:www.someweb.com")! //FIXME WITH ClOUD FUNCTION
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData
        

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
           
            }
        }

        task.resume()

        
        
        //FIXME some func to cloud function to generate suggested ID

        
        
        self.performSegue(withIdentifier: "ExperienceToList", sender: self)
        
    }
    
    
    
}


