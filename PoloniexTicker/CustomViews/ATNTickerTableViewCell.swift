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
    @IBOutlet weak var percentChangeLabel: UILabel!
    @IBOutlet weak var quoteVolumeLabel: UILabel!

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
		
		
        percentChangeLabel.text = ticker.percentChange
		percentChangeLabel.textColor = theme?.foregroundColor
		
		
        quoteVolumeLabel.text = ticker.quoteVolume
		quoteVolumeLabel.textColor = theme?.foregroundColor
    }
}
