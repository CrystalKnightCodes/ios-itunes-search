//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Christy Hicks on 11/5/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    // MARK: - Outlets
    @IBOutlet weak var resultTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    let searchResultsController = SearchResultController()
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResultsController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath)

        // Configure the cell...
        let searchResult = searchResultsController.searchResults[indexPath.row]
        cell.detailTextLabel?.text = searchResult.creator
        cell.textLabel?.text = searchResult.title
    
        return cell
    }
}

// MARK: - Search Bar
extension SearchResultsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
            var resultType: ResultType!
                switch resultTypeSegmentedControl.selectedSegmentIndex {
                case 0:
                    resultType = .software
                case 1:
                    resultType = .musicTrack
                case 2:
                    resultType = .movie
                default:
                    resultType = .software
                }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { 
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
