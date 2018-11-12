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
	var tickers = [Ticker]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ATNBitPoloniexService.shared.subscribe(self)
    }
	deinit {
		ATNBitPoloniexService.shared.unsubscribe(self)
	}
}

extension ATNHomeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ATNTickerTableViewCell
        let ticker = tickers[indexPath.row]
        cell?.configure(with: ticker)
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
	
	func receivedUpdates(_ ticker: Ticker) {
		self.tickers.insert(ticker, at: 0)
		self.tableView.reloadData()
		print("Ticker \(ticker)")
	}
	
	
}
