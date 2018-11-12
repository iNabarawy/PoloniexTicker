//
//  ATNPoloniexService.swift
//  Poloniex
//
//  Created by Ahmed T.Nabarawy on 11/11/18.
//  Copyright © 2018 Ahmed T.Nabarawy. All rights reserved.
//

import Foundation
import Starscream
protocol ATNBitPoloniexServiceObserverProtocol {
	var objectID : Int! {get}
	func receivedUpdates(_ tick:Tick)
}
class ATNBitPoloniexService {
    static let shared = ATNBitPoloniexService()
    fileprivate var socket :WebSocket!
	var observers = [Int:ATNBitPoloniexServiceObserverProtocol]()
	
	init() {
		socket = WebSocket(url: URL(string: "wss://api2.poloniex.com")!)
		//websocketDidConnect
		socket.onConnect = {
			self.socket.write(string: "{\"command\":\"subscribe\",\"channel\":\"1002\"}")
			print("websocket is connected")
		}
		//websocketDidDisconnect
		socket.onDisconnect = { (error: Error?) in
			print("websocket is disconnected: \(error?.localizedDescription ?? "")")
		}
		//websocketDidReceiveMessage
		socket.onText = { (text: String) in
			//print("got some text: \(text)")
			guard let data = text.data(using: .utf8) else {return}
			let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any]
			guard let count = json??.count ,count > 2 else {return}
			if let tickerinfoAny = json??[2] as? [Any] {
				var tickerinfo = [String]()
				for i in tickerinfoAny {
					if let newI = i as? String {
						tickerinfo.append(newI)
					}else if let newI = i as? Int {
						tickerinfo.append("\(newI)")
					}
				}
				let newTick = Tick.init(id: Int(tickerinfo[0]) ?? 0, last: tickerinfo[1], lowestAsk: tickerinfo[2], highestBid: tickerinfo[3], percentChange: tickerinfo[4], baseVolume: tickerinfo[5], quoteVolume: tickerinfo[6], isFrozen: tickerinfo[7], high24hr: tickerinfo[8], low24hr: tickerinfo[9])
				self.notifyObservers(updates:newTick)
			}
		}
		//websocketDidReceiveData
		socket.onData = { (data: Data) in
			print("got some data: \(data.count)")
		}
	}
    func subscribe(_ observer:ATNBitPoloniexServiceObserverProtocol){
		if observers.count == 0 {
			//start the server
			socket.connect()
		}
		observers[observer.objectID] = observer
    }
	func unsubscribe(_ observer:ATNBitPoloniexServiceObserverProtocol){
		observers[observer.objectID] = nil
		if observers.count == 0 {
			//stop the server
			socket.disconnect()
		}
	}
	func notifyObservers(updates tick:Tick) {
		for (_,observer) in observers {
			observer.receivedUpdates(tick)
		}
	}
}
