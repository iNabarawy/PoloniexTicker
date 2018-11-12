//
//  ATNTickerTableViewCell.swift
//  Poloniex
//
//  Created by iSeddiqi Apple on 11/12/18.
//  Copyright © 2018 iSeddiqi. All rights reserved.
//

import UIKit

class ATNTickerTableViewCell: UITableViewCell {
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var lowestAskLabel: UILabel!
    @IBOutlet weak var highestBidLabel: UILabel!
    @IBOutlet weak var percentChangeLabel: UILabel!
    @IBOutlet weak var baseVolumeLabel: UILabel!
    @IBOutlet weak var quoteVolumeLabel: UILabel!
    @IBOutlet weak var isFrozenLabel: UILabel!
    @IBOutlet weak var high24hrLabel: UILabel!
    @IBOutlet weak var low24hrLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with ticker:Ticker){
        currencyNameLabel.text = ticker.currency()
        lastLabel.text = ticker.last
        lowestAskLabel.text = ticker.lowestAsk
        highestBidLabel.text = ticker.highestBid
        percentChangeLabel.text = ticker.percentChange
        baseVolumeLabel.text = ticker.baseVolume
        quoteVolumeLabel.text = ticker.quoteVolume
        isFrozenLabel.text = ticker.isFrozen == "0" ? "Active" : "Frozen"
        high24hrLabel.text = ticker.high24hr
        low24hrLabel.text = ticker.low24hr
    }
}
