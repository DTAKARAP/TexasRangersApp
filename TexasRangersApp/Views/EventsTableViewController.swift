//
//  ViewController.swift
//  TexasRangersApp
//
//  Created by divya akarapu on 11/23/20.
//

import UIKit
import Foundation

class EventsTableViewController: UIViewController {

    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var loadingContainerView: UIView!
    
    var searchBar = UISearchBar()
    var viewModel = EventsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.bringSubviewToFront(loadingContainerView)
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if viewModel.events.count > 0 {
            showAnimatingView()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if viewModel.events.count > 0 {
            tableView.reloadData()
            hideAnimatingView()
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        searchBar.text = ""
        hideKeyboard()
    }
    
    fileprivate func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search events here"
        navigationItem.titleView = searchBar
    }
    
    fileprivate func showDetailView(_ details: EventDataModel) {
        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc: EventsDetailViewController = sb.instantiateViewController(withIdentifier: "detailViewStoryBoardId") as? EventsDetailViewController else {
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
    
    fileprivate func showAnimatingView() {
        containerView.bringSubviewToFront(loadingContainerView)
        loadingView.startAnimating()
    }
    
    fileprivate func hideAnimatingView() {
        loadingView.stopAnimating()
        containerView.bringSubviewToFront(tableView)
    }
    
    fileprivate func hideTableView() {
        containerView.bringSubviewToFront(loadingContainerView)
        loadingView.stopAnimating()
        tableView.reloadData()
    }
}

extension EventsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showAnimatingView()
        viewModel.fetchEvents(with: searchBar.text ?? "") { [weak self] (result) in
            if result {
                DispatchQueue.main.async {
                    self?.hideAnimatingView()
                    self?.hideKeyboard()
                    self?.tableView.reloadData()
                }
            } else {
                let alert = UIAlertController(title: "No events found", message: "Please try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self?.searchBar.text = ""
                    self?.hideTableView()
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}

extension EventsTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellid") as? EventsTableViewCell {
            cell.configureView(with: viewModel.events[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailView(viewModel.events[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}





