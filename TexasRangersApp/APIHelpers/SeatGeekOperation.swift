//
//  SeatGeekOperation.swift
//  TexasRangersApp
//
//  Created by divya akarapu on 11/25/20.
//

import Foundation

class SeatGeekOperation {
    
    class func fetchSearchResults(with searchString: String, completionHandler: @escaping (Events?) -> Void) {
        guard let eventURL = URL(string: "https://api.seatgeek.com/2/events/?client_id=MjE0MDYxMTN8MTYwNjE2Njg5MC40NzkzNzc1&q=\(searchString)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: eventURL) { (data, response, error) in
            if let error = error {
                print("Error when fetching events \(error)")
            }
            
            if let data = data {
                do {
                    let eventsData = try JSONDecoder().decode(Events.self, from: data)
                    completionHandler(eventsData)
                    return
                } catch let error {
                    print("\(error)")
                }
            }
            completionHandler(nil)
        }
        
        task.resume()
    }
}

