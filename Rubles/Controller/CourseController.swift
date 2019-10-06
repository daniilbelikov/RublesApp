//
//  CourseController.swift
//  Rubles: exchange rates
//
//  Created by Alexander Senin & Daniil Belikov on 01/10/2019.
//  Copyright © 2019 GolDuck development. All rights reserved.
//

import UIKit

class CourseController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "startLoadingXML"), object: nil, queue: nil) { (notification) in
            
            DispatchQueue.main.async {
                let activityIndicator = UIActivityIndicatorView(style: .gray)
                activityIndicator.color = .orange
                activityIndicator.startAnimating()
                self.navigationItem.rightBarButtonItem?.customView = activityIndicator
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dataRefreshed"), object: nil, queue: nil) { (notification) in
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = Model.shared.currentDate
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.pushRefreshAction(_:)))
                self.navigationItem.rightBarButtonItem = barButtonItem
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("ErrorWhenXMLloading"), object: nil, queue: nil) { (notification) in
            let errorName = notification.userInfo?["ErrorName"]
            print(errorName as Any)
            
            DispatchQueue.main.async {
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.pushRefreshAction(_:)))
                self.navigationItem.rightBarButtonItem = barButtonItem
            }
        }
        navigationItem.title = Model.shared.currentDate
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Model.shared.loadXMLFile(date: nil)
    }
    
    @IBAction func pushRefreshAction(_ sender: Any) {
        Model.shared.loadXMLFile(date: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CourseCell
        let courseForCell = Model.shared.currencies[indexPath.row]
        cell.initCell(currency: courseForCell)
        return cell
    }
}
