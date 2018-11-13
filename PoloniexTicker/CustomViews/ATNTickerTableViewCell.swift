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
	@IBOutlet weak var arrowImageView: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	func configure(with tick:Tick, theme:ATNTheme?, numberToCompare number:Double?){
		self.backgroundColor = theme?.backgroundColor
		
        currencyNameLabel.text = tick.currency()
		currencyNameLabel.textColor = theme?.foregroundColor
		
        lastLabel.text = tick.last
		lastLabel.textColor = theme?.foregroundColor
		
		
        percentChangeLabel.text = tick.percentChange
		percentChangeLabel.textColor = theme?.foregroundColor
		
		
        quoteVolumeLabel.text = tick.quoteVolume
		quoteVolumeLabel.textColor = theme?.foregroundColor
		if let anumber = number {
			if Double(tick.last!) ?? 0 < anumber {
				arrowImageView.image = UIImage(named: "red")
			}else if Double(tick.last!) ?? 0 > anumber {
				arrowImageView.image = UIImage(named: "green")
			}else{
				arrowImageView.image = nil
			}
		}else {
			arrowImageView.image = nil
		}
    }
}
