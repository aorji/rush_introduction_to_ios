//
//  TableViewController.swift
//  Introduction to iOS
//
//  Created by Anastasiia ORJI on 9/22/18.
//  Copyright © 2018 Alina FESYK. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, UISearchBarDelegate{
	
	@IBOutlet weak var searchBar: UISearchBar!
		
	var chosenSchool = SchoolData()
	let school = SchoolCollection()

	var filteredSchool = [SchoolData]()
	var isSearching = false
	
    override func viewDidLoad() {
		
        super.viewDidLoad()
		self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isSearching {
			return filteredSchool.count
		}
		return school.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CityListCell", for: indexPath)
		
		if isSearching {
			cell.textLabel?.text = filteredSchool[indexPath.row].name
			cell.detailTextLabel?.text = filteredSchool[indexPath.row].country
		} else {
			cell.textLabel?.text = school.list[indexPath.row].name
			cell.detailTextLabel?.text = school.list[indexPath.row].country
		}
		return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		chosenSchool = school.list[indexPath.row]
    }
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		
		if searchBar.text == nil || searchBar.text == "" {
			
			isSearching = false
			
			view.endEditing(true)
			
			tableView.reloadData()
			
		} else {
			
			isSearching = true
			
			filteredSchool = school.list.filter({$0.name.lowercased() == searchBar.text?.lowercased()})
			
			tableView.reloadData()
		}
	}
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMapWithSelectedCity" {
            guard let destinationVC = segue.destination as? FirstViewController else {
                return
            }
            destinationVC.chosenCity = chosenSchool
        }
    }

}

