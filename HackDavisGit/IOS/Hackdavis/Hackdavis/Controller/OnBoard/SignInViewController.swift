//
//  SignInViewController.swift
//  Hackdavis
//
//  Created by Athena Leong on 1/18/20.
//  Copyright © 2020 Athena Leong. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

//UI Elements
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    
    //Variables
    var userEmail : String?
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [UIColor(red:1.00, green:0.92, blue:0.69, alpha:1.0).cgColor, UIColor(red:1.00, green:0.86, blue:0.45, alpha:1.0).cgColor
        ]
        layer.shouldRasterize = true
        //layer.startPoint = CGPoint(x: 0,y: 0.5)
        //layer.startPoint = CGPoint(x: 1,y: 1)
        backgroundView.layer.addSublayer(layer)
        self.hideKeyboardWhenTappedAround()
    
//        emailTextField.leftViewMode = UITextField.ViewMode.always
//        let imageView = UIImageView(image: UIImage(named: "envelope"))
//        //imageView.frame.size = CGSize(width: 500, height: 500)
//        emailTextField.leftView = imageView
//        emailTextField.leftView?.frame = CGRect(x: 0, y:0, width: 10, height: 10)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser {
            self.performSegue(withIdentifier: "SignInToExperience", sender: self)
        }
    }
    func hideKeyboardWhenTappedAround() {
     let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(SignInViewController.dismissKeyboard))
        //tap.
      tap.cancelsTouchesInView = true
      view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
       view.endEditing(true)
    }
    func handleSignIn() {
        guard let userEmail = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: userEmail, password: password) { user, error in
            if error != nil || user == nil{
                self.displayAlert(type : "nil" , title: "Incorrect Login", message : "The login details you entered is incorrect. Please try again." )
            }
            else{
                let currentID = Auth.auth().currentUser!.uid
                UserDefaults.standard.set(currentID, forKey: "user")
                print(currentID)
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                self.performSegue(withIdentifier: "SignInToExperience", sender: self)
            }
        }
    }
            
            
            
    func displayAlert(type: String, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        switch type{
        case "Verification":
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            let resendVerification = UIAlertAction(title: "Resend Verfication Email", style: .default, handler: { action in
                self.sendVerificationMail()
                
            })
            alert.addAction(defaultAction)
            alert.addAction(resendVerification)
            self.present(alert, animated: true, completion: nil)
        default:
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func sendVerificationMail(){
        Auth.auth().currentUser!.sendEmailVerification(completion: { (error) in
            self.displayAlert(type: "nil", title: "Verification", message : "Verification Email Send" )
            })
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        handleSignIn()
    }
    
    
    @IBAction func signUpPressed(_ sender: Any) {
        print("segue")
        self.performSegue(withIdentifier: "SignInToSignUp", sender: self)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight(notification: notification) - (view.frame.height - signUpButton.frame.maxY)
            view.frame.origin.y -= max(lastKeyboardOffset, 0)
            keyboardAdjusted = true
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardAdjusted == true {
            view.frame.origin.y += max(lastKeyboardOffset, 0)
            keyboardAdjusted = false
        }
    }

    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
}

