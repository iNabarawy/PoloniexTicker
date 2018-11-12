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
	func configure(with ticker:Tick, theme:ATNTheme?){
		self.backgroundColor = theme?.backgroundColor
		
        currencyNameLabel.text = ticker.currency()
		currencyNameLabel.textColor = theme?.foregroundColor
		
        lastLabel.text = ticker.last
		lastLabel.textColor = theme?.foregroundColor
		
        lowestAskLabel.text = ticker.lowestAsk
		lowestAskLabel.textColor = theme?.foregroundColor
		
        highestBidLabel.text = ticker.highestBid
		highestBidLabel.textColor = theme?.foregroundColor
		
        percentChangeLabel.text = ticker.percentChange
		percentChangeLabel.textColor = theme?.foregroundColor
		
        baseVolumeLabel.text = ticker.baseVolume
		baseVolumeLabel.textColor = theme?.foregroundColor
		
        quoteVolumeLabel.text = ticker.quoteVolume
		quoteVolumeLabel.textColor = theme?.foregroundColor
		
        isFrozenLabel.text = ticker.isFrozen == "0" ? "Active" : "Frozen"
		isFrozenLabel.textColor = theme?.foregroundColor
		
        high24hrLabel.text = ticker.high24hr
		high24hrLabel.textColor = theme?.foregroundColor
		
        low24hrLabel.text = ticker.low24hr
		low24hrLabel.textColor = theme?.foregroundColor
    }
}
