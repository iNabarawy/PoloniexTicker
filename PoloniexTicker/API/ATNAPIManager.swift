//
//  ATNAPIManager.swift
//  PoloniexTicker
//
//  Created by Ahmed T.Nabarawy on 11/11/18.
//  Copyright © 2018 Ahmed T.Nabarawy. All rights reserved.
//

import Foundation
enum ATNRequestResult {
	case success([Ticker])
	case failure(String)
}
class ATNAPIManager {
	
}

struct Ticker : Codable {
	var id: Int64
	var last: String
	var lowestAsk: String
	var highestBid: String
	var percentChange: String
	var baseVolume: String
	var quoteVolume: String
	var isFrozen: String
	var high24hr: String
	var low24hr: String

}
