//
//  InitialViewController.swift
//  Hackdavis
//
//  Created by Athena Leong on 1/18/20.
//  Copyright © 2020 Athena Leong. All rights reserved.
//
import UIKit
import Firebase

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "toExperience", sender: self)
        }
        else{
            performSegue(withIdentifier: "toSignIn", sender: self)
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
