//
//  ViewController.swift
//  Poloniex
//
//
//  Created by Ahmed T.Nabarawy on 11/11/18.
//  Copyright © 2018 Ahmed T.Nabarawy. All rights reserved.
//


import UIKit

class ATNHomeViewController: UIViewController {
	var ticks = [Int:Tick]()
	var currentTheme: ATNTheme? {
		didSet{
			updateView()
		}
	}
	
    @IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var segmentedController: UISegmentedControl!
	@IBOutlet weak var inputTextField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        ATNBitPoloniexService.shared.subscribe(self)
		currentTheme = ATNTheme(backgroundColor: UIColor.white,foregroundColor: UIColor.black)
		
    }
	
	fileprivate func updateView() {
		tableView.reloadData()
		segmentedController.backgroundColor = currentTheme?.backgroundColor
		segmentedController.tintColor = currentTheme?.foregroundColor
		
		inputTextField.backgroundColor = currentTheme?.backgroundColor
		inputTextField.textColor = currentTheme?.foregroundColor
		inputTextField.layer.borderColor = currentTheme?.foregroundColor?.cgColor
		inputTextField.layer.borderWidth = 1
		inputTextField.layer.cornerRadius = 5
		
		view.backgroundColor = currentTheme?.backgroundColor
	}

	@IBAction func switchThemes(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case ATNThemeStyle.light.rawValue:
			currentTheme = ATNTheme(backgroundColor: UIColor.white,foregroundColor: UIColor.black)
		case ATNThemeStyle.dark.rawValue:
			currentTheme = ATNTheme(backgroundColor: UIColor.black,foregroundColor: UIColor.white)
		default: break
		}
	}
	
	deinit {
		ATNBitPoloniexService.shared.unsubscribe(self)
	}
}

extension ATNHomeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ATNTickerTableViewCell
		let tick = Array(ticks.values).sorted{$0.id<$1.id}[indexPath.row]
		cell?.configure(with: tick, theme: currentTheme)
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
}

extension ATNHomeViewController : ATNBitPoloniexServiceObserverProtocol {
	var objectID: Int! {
		return self.hashValue
	}
	
	func receivedUpdates(_ tick: Tick) {
		if (ticks[tick.id] != nil){
			let arrayOfTicks = Array(ticks.values).sorted{$0.id<$1.id}
			var index = 0
			for i in arrayOfTicks {
				if i.id == tick.id {
					break
				}
				index = index + 1
			}
			ticks[tick.id] = tick
			let indexPath = IndexPath(row: index, section: 0)
			if tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false {
				self.tableView.reloadRows(at: [indexPath], with: .fade)
			}
		}else{
			ticks[tick.id] = tick
			self.tableView.reloadData()
		}
	}
	
}

extension ATNHomeViewController : UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
