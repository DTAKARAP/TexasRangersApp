//
//  TexasRangersDetailViewController.swift
//  TexasRangersApp
//
//  Created by divya akarapu on 11/29/20.
//

import UIKit

class EventsDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var favoriteBtn: UIBarButtonItem!
    
    var event: EventDataModel?
    var updateFavourites: ((Int) -> Void)?
    
    override func viewDidLoad() {
        if let event = event {
            navigationItem.title =  event.title
            dateTimeLabel.text = event.eventDateTimeUTC
            cityLabel.text = event.eventDisplayLocation
            imageView.layer.cornerRadius = 8.0
            if event.isFavouriteEvent {
                favoriteBtn.image = UIImage(systemName: "heart.fill")
            }
            
            if let url = URL(string: event.eventImageUrl ?? ""), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    @IBAction func favouriteAction(_ sender: Any) {
        let isFavourite = event?.isFavouriteEvent ?? false
        favoriteBtn.image = isFavourite ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill")
        event?.isFavouriteEvent = !isFavourite
        updateFavourites?(event?.eventId ?? 0)
    }
}
