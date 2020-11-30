//
//  TexasRangersViewModel.swift
//  TexasRangersApp
//
//  Created by divya akarapu on 11/29/20.
//

import Foundation

class TexasRangersViewModel {
    
    var events = [EventDataModel]()
    let persistentId = "favoriteIds"
    
    public func fetchEvents(with searchStr: String, completionHandler: @escaping (Bool) -> Void) {
        SeatGeekOperation.fetchSearchResults(with: searchStr) { [weak self] (response) in
            if let events = response?.events, events.count > 0 {
                self?.events = self?.bindModel(with: events) ?? [EventDataModel]()
                completionHandler(true)
            } else {
                self?.events = [EventDataModel]()
                completionHandler(false)
            }
        }
    }
    
    public func addToFavourites(with eventId: Int) {
        var localIds = [Int]()
        if let ids = UserDefaults.standard.value(forKey: persistentId) as? [Int] {
            localIds = ids
        }
        if localIds.contains(eventId) {
            if let i = localIds.firstIndex(where: { $0 == eventId }) {
                localIds.remove(at: i)
            }
        } else {
            localIds.append(eventId)
        }
    
        UserDefaults.standard.removeObject(forKey: persistentId)
        UserDefaults.standard.set(localIds, forKey: persistentId)
        
        let updatedEvents = events.map({ EventDataModel(eventId: $0.eventId, title: $0.title, eventImageUrl: $0.eventImageUrl, eventDateTimeUTC: $0.eventDateTimeUTC, eventDisplayLocation: $0.eventDisplayLocation, isFavouriteEvent: determineIfFavourite(with: $0.eventId)) })
        events = updatedEvents
    }
    
    fileprivate func bindModel(with events: [Event]) -> [EventDataModel] {
        return events.map({ EventDataModel(eventId: $0.id, title: $0.performers?.first?.name ?? "", eventImageUrl: $0.performers?.first?.image ?? "", eventDateTimeUTC: inputFormatter(with: $0.datetimeUTC ?? ""), eventDisplayLocation: $0.venue?.displayLocation, isFavouriteEvent: determineIfFavourite(with: $0.id ?? 0)) })
    }
    
    fileprivate func outputFormatter(with date: Date) -> String{
        let aFormatter = DateFormatter()
        aFormatter.dateFormat = "EEE MMM dd, yyyy hh:mm a"
        aFormatter.amSymbol = "AM"
        aFormatter.pmSymbol = "PM"
        return aFormatter.string(from: date)
    }
    
    fileprivate func inputFormatter(with dateString: String) -> String {
        let aFormatter = DateFormatter()
        aFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let aDay = aFormatter.date(from: dateString) ?? Date()
        return outputFormatter(with: aDay)
    }
    
    fileprivate func determineIfFavourite(with id: Int) -> Bool {
        let localIds = UserDefaults.standard.value(forKey: persistentId) as? [Int]
        return localIds?.contains(id) ?? false
    }
}
