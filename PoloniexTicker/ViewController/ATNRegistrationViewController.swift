//
//  ATNRegistrationViewController.swift
//  PoloniexTicker
//
//  Created by Ahmed T.Nabarawy on 11/12/18.
//  Copyright © 2018 Ahmed T.Nabarawy. All rights reserved.
//

import UIKit
import KeychainAccess

class ATNRegistrationViewController: UIViewController {
	
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var userNameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var mobileTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var confirmPasswordTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	@IBAction func registerNewUser(_ sender: Any) {
		if (verifyPassword()){
			let keychain = Keychain(service: "com.inabarawy.PoloniexTicker").synchronizable(true).accessibility(.whenUnlocked)
			keychain["user"] = userNameTextField.text
			keychain["password"] = passwordTextField.text
			keychain["email"] = emailTextField.text
			keychain["name"] = nameTextField.text
			keychain["mobile"] = mobileTextField.text
			
			alert(title: "Success!", message: "Your account is now created, please login through the login page", actionTitle: "Ok", cancelTitle: nil) { (confirmed) in
				self.dismiss(animated: true, completion: nil)
			}
		}
	}
	@discardableResult
	func verifyPassword() -> Bool{
		if confirmPasswordTextField.text != passwordTextField.text {
			self.alert(title: "Error!", message: "Passwords don't match.", actionTitle: "Retry", cancelTitle: nil) { (confirmed) in
				self.passwordTextField.text = ""
				self.confirmPasswordTextField.text = ""
				self.passwordTextField.becomeFirstResponder()
			}
		}else if (passwordTextField.text?.count ?? 0) < 8 {
			alert(title: "Error!", message: "Password should be at least 8 alphanumeric phrase", actionTitle: "Retry", cancelTitle: nil) { (confirmed) in
				self.passwordTextField.text = ""
				self.confirmPasswordTextField.text = ""
				self.passwordTextField.becomeFirstResponder()
			}
		}else {
			return true
		}
		return false
	}
}
extension ATNRegistrationViewController : UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		if let nextTextField = view.viewWithTag(textField.tag + 1) as? UITextField {
			nextTextField.becomeFirstResponder()
		}else{
			textField.resignFirstResponder()
			verifyPassword()
		}
		return true
	}
}

extension UIViewController {
	@discardableResult
	func alert(title:String?,message:String?,actionTitle:String?,cancelTitle:String?,success:(((Bool)->Void)?))->UIAlertController {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		if actionTitle != nil {
			let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
				success?(true)
			}
			alertController.addAction(action)
		}
		if cancelTitle != nil {
			let cancel = UIAlertAction(title: cancelTitle, style: .cancel, handler: { (action) in
				success?(false)
			})
			alertController.addAction(cancel)
		}
		DispatchQueue.main.async {
			self.present(alertController,animated: false)
		}
		return alertController
	}
}
extension String {
	var isValidEmail : Bool {
		get {
			let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
			let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
			let isValid = emailTest.evaluate(with: self)
			return isValid;
		}
	}
}
