//
//  TexasRangersTableViewCell.swift
//  TexasRangersApp
//
//  Created by divya akarapu on 11/29/20.
//

import UIKit

class TexasRangersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventCityLabel: UILabel!
    @IBOutlet weak var eventDateTimeLabel: UILabel!
    @IBOutlet weak var eventThumbNail: UIImageView!
    @IBOutlet weak var favouriteBtn: UIButton!
    
    public func configureView(with event: EventDataModel) {
        eventTitleLabel.text = event.title
        eventDateTimeLabel.text = event.eventDateTimeUTC
        eventCityLabel.text = event.eventDisplayLocation
        eventThumbNail.layer.cornerRadius = 8.0
        favouriteBtn.isHidden = !event.isFavouriteEvent
        
        if let url = URL(string: event.eventImageUrl ?? ""), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.eventThumbNail.image = image
            }
        }
    }
}
