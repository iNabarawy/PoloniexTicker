//
//  Ticker.swift
//  PoloniexTicker
//
//  Created by Ahmed T.Nabarawy on 11/11/18.
//  Copyright © 2018 Ahmed T.Nabarawy. All rights reserved.
//

import Foundation
struct Ticker {
	var id: Int
	var last: String?
	var lowestAsk: String?
	var highestBid: String?
	var percentChange: String?
	var baseVolume: String?
	var quoteVolume: String?
	var isFrozen: String?
	var high24hr: String?
	var low24hr: String?
	
	func currency()-> String {
		return ATNCurrencyHelper.shared.currencyNameForID(id:self.id)
	}
}
