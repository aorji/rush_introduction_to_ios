//
//  ListViewController.swift
//  Introduction to iOS
//
//  Created by Anastasiia ORJI on 9/23/18.
//  Copyright © 2018 Alina FESYK. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
	
	var chosenSchool = SchoolData()
	let school = SchoolCollection()
	var filteredSchool = [SchoolData]()
//	var isSearching = false
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		searchBar.delegate = self
		filteredSchool = school.list
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate{
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			return filteredSchool.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = filteredSchool[indexPath.row].name
		cell.detailTextLabel?.text = filteredSchool[indexPath.row].country
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		chosenSchool = filteredSchool[indexPath.row]
		tableView.deselectRow(at: indexPath, animated: true)
		performSegue(withIdentifier: "goToMapWithSelectedSchool", sender: self)
	}
	
	//MARK: - go to map with chosen school
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToMapWithSelectedSchool" {
			guard let destinationVC = segue.destination as? FirstViewController else {
				return
			}
			destinationVC.chosenSchool = self.chosenSchool
		}
	}
	
}

extension ListViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText.count == 0 {
			filteredSchool = school.list
		} else {
			filteredSchool = school.list.filter({$0.name.lowercased().contains(searchText.lowercased())})
		}
		tableView.reloadData()
	}
}
