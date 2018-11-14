//
//  ATNLoginViewController.swift
//  PoloniexTicker
//
//  Created by Ahmed T.Nabarawy on 11/11/18.
//  Copyright © 2018 Ahmed T.Nabarawy. All rights reserved.
//

import UIKit
import KeychainAccess
import LocalAuthentication
class ATNLoginViewController: UIViewController {
	
	@IBOutlet weak var userNameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	var context:LAContext!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.userNameTextField.text = ""
		self.passwordTextField.text = ""
	}
	
	@IBAction func touchID(_ sender: Any) {
		context = LAContext()
		
		context.localizedCancelTitle = "Enter Username/Password"
		
		// First check if we have the needed hardware support.
		var error: NSError?
		if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
			
			let reason = "Log in to your account"
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason ) { success, error in
				if success {
					// Move to the main thread because a state update triggers UI changes.
					DispatchQueue.main.async { [unowned self] in
						let keychain = Keychain(service: "com.inabarawy.PoloniexTicker").synchronizable(true).accessibility(.whenUnlocked)
						DispatchQueue.global().async {
							do {
								let password = try keychain.get("password")
								let userName =  try keychain.get("user")
								DispatchQueue.main.async {
									self.userNameTextField.text = userName
									self.passwordTextField.text = password
									self.authenticated()
								}
								
							} catch let error {
								// Error handling if needed...
								print("\(error.localizedDescription)")
							}
						}
					}
					
				} else {
					print(error?.localizedDescription ?? "Failed to authenticate")
					// Fall back to a asking for username and password.
					DispatchQueue.main.async {
						self.userNameTextField.becomeFirstResponder()
					}
				}
			}
		} else {
			print(error?.localizedDescription ?? "Can't evaluate policy")
			self.userNameTextField.becomeFirstResponder()
		}
	}
	@IBAction func login(_ sender: Any) {
		let keychain = Keychain(service: "com.inabarawy.PoloniexTicker").synchronizable(true).accessibility(.whenUnlocked)
		if keychain["user"]?.lowercased() == userNameTextField.text?.lowercased() && keychain["password"] == passwordTextField.text {
			authenticated()
		}else{
			alert(title: "Error!", message: "Wrong username or password!", actionTitle: "Retry", cancelTitle: nil) { (confirmed) in
				self.userNameTextField.becomeFirstResponder()
			}
		}
	}
	func authenticated(){
		performSegue(withIdentifier: "home", sender: nil)
	}
	@IBAction func newUser(_ sender: Any) {
		performSegue(withIdentifier: "register", sender: nil)
	}
}

