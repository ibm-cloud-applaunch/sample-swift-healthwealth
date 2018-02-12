//
//  PrescriptionTableViewController.swift
//  HealthWealth
//
//  Created by Vittal Pai on 2/5/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import UIKit

class PrescriptionTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 1) {
            if (AppLaunchAdapter.sharedInstance.isPrescriptionMenuEnabled()) {
                let menuType = AppLaunchAdapter.sharedInstance.getPrescriptionMenuType()
                if (menuType != "MapView") {
                    performSegue(withIdentifier: "mapNavigation", sender: self)
                } else {
                    performSegue(withIdentifier: "formNavigation", sender: self)
                }
            } else {
                 showAlert("This feature is yet to be implemented")
            }
        } else {
            showAlert("This feature is yet to be implemented")
        }
    }
    
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    

}
