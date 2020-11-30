//
//  ViewController.swift
//  TexasRangersApp
//
//  Created by divya akarapu on 11/23/20.
//

import UIKit
import Foundation

class TexasRangersTableViewController: UITableViewController {
    
    var searchBar = UISearchBar()
    var viewModel = TexasRangersViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if viewModel.events.count > 0 {
            tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellid") as? TexasRangersTableViewCell {
            cell.configureView(with: viewModel.events[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailView(viewModel.events[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        searchBar.text = ""
        hideKeyboard()
    }
    
    fileprivate func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    fileprivate func showDetailView(_ details: EventDataModel) {
        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc: TexasRangersDetailViewController = sb.instantiateViewController(withIdentifier: "detailViewStoryBoardId") as? TexasRangersDetailViewController else {
            return
        }
        vc.event = details
        vc.updateFavourites = self.addEventsToFavourites
        navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    fileprivate func addEventsToFavourites(_ eventId: Int) {
        viewModel.addToFavourites(with: eventId)
    }
}

extension TexasRangersTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchEvents(with: searchBar.text ?? "") { [weak self] (result) in
            if result {
                DispatchQueue.main.async {
                    self?.hideKeyboard()
                    self?.tableView.reloadData()
                }
            } else {
                let alert = UIAlertController(title: "No events found", message: "Please try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}

class TexasRangersViewModel {
    
    var events = [EventDataModel]()
    
    public func fetchEvents(with searchStr: String, completionHandler: @escaping (Bool) -> Void) {
        SeatGeekOperation.fetchSearchResults(with: searchStr) { [weak self] (response) in
            if let events = response?.events, !events.isEmpty {
                self?.events = self?.bindModel(with: events) ?? [EventDataModel]()
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }
    
    public func addToFavourites(with eventId: Int) {
        var localIds = [Int]()
        if let ids = UserDefaults.standard.value(forKey: "favoriteIds") as? [Int] {
            localIds = ids
        }
        if localIds.contains(eventId) {
            if let i = localIds.firstIndex(where: { $0 == eventId }) {
                localIds.remove(at: i)
            }
        } else {
            localIds.append(eventId)
        }
    
        UserDefaults.standard.removeObject(forKey: "favoriteIds")
        UserDefaults.standard.set(localIds, forKey: "favoriteIds")
        
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
        let localIds = UserDefaults.standard.value(forKey: "favoriteIds") as? [Int]
        return localIds?.contains(id) ?? false
    }
}

class TexasRangersDetailViewController: UIViewController {
    
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


