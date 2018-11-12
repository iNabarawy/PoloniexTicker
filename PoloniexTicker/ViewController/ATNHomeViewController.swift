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
	var ticks = [Tick]()
	var currentTheme: ATNTheme? {
		didSet{
			updateView()
		}
	}
	
    @IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var segmentedController: UISegmentedControl!
	@IBOutlet weak var inputTextFields: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        ATNBitPoloniexService.shared.subscribe(self)
		currentTheme = ATNTheme(backgroundColor: UIColor.white,foregroundColor: UIColor.black)
		
    }
	
	fileprivate func updateView() {
		tableView.reloadData()
		segmentedController.backgroundColor = currentTheme?.backgroundColor
		segmentedController.tintColor = currentTheme?.foregroundColor
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
        let tick = ticks[indexPath.row]
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
		self.ticks.insert(tick, at: 0)
		self.tableView.reloadData()
		print("Ticker \(tick)")
	}
}
