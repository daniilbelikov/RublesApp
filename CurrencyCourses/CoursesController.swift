//
//  CoursesController.swift
//  CurrencyCourses
//
//  Created by Daniil Belikov on 02/07/2019.
//  Copyright © 2019 Daniil Belikov. All rights reserved.
//

import UIKit

class CoursesController: UITableViewController {
    
    @IBAction func pushRefreshAction(_ sender: Any) {
        Model.shared.loadXMLFile(date: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "startLoadingXML"), object: nil, queue: nil) { (notification) in
            
            DispatchQueue.main.async {
                let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
                
                activityIndicator.color = UIColor.blue
                
                activityIndicator.startAnimating()
                self.navigationItem.rightBarButtonItem?.customView = activityIndicator
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dataRefreshed"), object: nil, queue: nil) { (notification) in
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = Model.shared.currentDate
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(self.pushRefreshAction(_:)))
                self.navigationItem.rightBarButtonItem = barButtonItem
            }
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("ErrorWhenXMLloading"), object: nil, queue: nil) { (notification) in
            let errorName = notification.userInfo?["ErrorName"]
            print(errorName as Any)
            DispatchQueue.main.async {
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(self.pushRefreshAction(_:)))
                self.navigationItem.rightBarButtonItem = barButtonItem
            }
        }

        navigationItem.title = Model.shared.currentDate
        Model.shared.loadXMLFile(date: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.shared.currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CoursesCell
        let courseForCell = Model.shared.currencies[indexPath.row]
        cell.initCell(currency: courseForCell)
        return cell
    }
}
