//
//  SecondViewController.swift
//  Introduction to iOS
//
//  Created by Alina FESYK on 9/22/18.
//  Copyright © 2018 Alina FESYK. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var tableView: UITableView!
	var barIndexDictionary : [String: Int] = [:]
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
		tableView.reloadData()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
	
	func addMemberToDictionary() -> [String: Int] {
		for index in 0...2 {
			
		}
	}
}

