//
//  EventDataModel.swift
//  TexasRangersApp
//
//  Created by divya akarapu on 11/29/20.
//

import Foundation

public struct EventDataModel {
    var title: String?
    var eventImageUrl: String?
    var eventDateTimeUTC: String?
    var eventDisplayLocation: String?
    var isFavouriteEvent: Bool = false
    var eventId: Int = 0
    
    init(eventId: Int? = 0, title: String? = "", eventImageUrl: String? = nil, eventDateTimeUTC: String? = "", eventDisplayLocation: String? = "", isFavouriteEvent: Bool? = false) {
        self.eventId = eventId ?? 0
        self.title = title
        self.eventImageUrl = eventImageUrl
        self.eventDateTimeUTC = eventDateTimeUTC
        self.eventDisplayLocation = eventDisplayLocation
        self.isFavouriteEvent = isFavouriteEvent ?? false
    }
}
