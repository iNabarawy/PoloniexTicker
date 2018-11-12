//
//  ATNLoginViewController.swift
//  PoloniexTicker
//
//  Created by Ahmed T.Nabarawy on 11/11/18.
//  Copyright © 2018 Ahmed T.Nabarawy. All rights reserved.
//

import UIKit
import KeychainAccess

class ATNLoginViewController: UIViewController {

	@IBOutlet weak var userNameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}


	@IBAction func touchID(_ sender: Any) {
		let keychain = Keychain(service: "com.inabarawy.PoloniexTicker").synchronizable(true).accessibility(.whenUnlocked)
		DispatchQueue.global().async {
			do {
				let password = try keychain
					.authenticationPrompt("Authenticate to login to PoloniexTicker")
					.get("password")
				let userName =  try keychain.get("user")
				DispatchQueue.main.async {
					self.userNameTextField.text = userName
					self.passwordTextField.text = password
					self.authenticated()
				}
				
			} catch let error {
				// Error handling if needed...
				print("\(error)")
			}
		}
	}
	@IBAction func login(_ sender: Any) {
		let keychain = Keychain(service: "com.inabarawy.PoloniexTicker").synchronizable(true).accessibility(.whenUnlocked)
		if keychain["user"] == userNameTextField.text && keychain["password"] == passwordTextField.text {
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

