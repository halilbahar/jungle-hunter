//
//  SearchTableViewController.swift
//  jungle-hunter-app
//
//  Created by Administrator on 25.04.20.
//  Copyright © 2020 htl-leonding. All rights reserved.
//

import UIKit
import MapKit

class SearchTableViewController: UIViewController {

    var mapSearch: MapViewController?
    var matchingAnnotations:[MKAnnotation] = []
    var mapView: MKMapView? = nil
    @IBOutlet weak var tableView: UITableView!
    var dataSource : DataSourceSearch!
    var delegateClass : DataSourceDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = DataSourceSearch()
        self.delegateClass = DataSourceDelegate()
        self.tableView.delegate = delegateClass
        self.tableView.dataSource = dataSource
    }

}

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBarText = searchController.searchBar.text!
        self.matchingAnnotations = []
        
        for annotation in mapView!.annotations {
            if((annotation.title)!!.lowercased().contains("" + searchBarText.lowercased())) {
                matchingAnnotations.append(annotation)
            }
        }
        self.dataSource.matchingAnnotations = self.matchingAnnotations
        self.delegateClass.mapSearch = self.mapSearch
        self.delegateClass.matchingAnnotations = self.matchingAnnotations
        self.tableView.reloadData()
    }
    
    
}

class DataSourceSearch: NSObject, UITableViewDataSource {
    var matchingAnnotations:[MKAnnotation] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchingAnnotations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! TableViewCell
        cell.search_title.text = self.matchingAnnotations[indexPath.row].title!
        return cell
    }
}

class DataSourceDelegate: NSObject, UITableViewDelegate {
    var matchingAnnotations:[MKAnnotation] = []
    var mapSearch: MapViewController?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mapSearch?.zoomIn(annotation: matchingAnnotations[indexPath.row])
    }
}
