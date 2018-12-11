//
//  SettingsTableViewController.swift
//  Poppin
//
//  Created by Blake Swaidner on 12/10/18.
//  Copyright © 2018 MoBamba. All rights reserved.
//

import CoreLocation
import UIKit

class SettingsTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.navigationController as? CustomNavigationBarController)?.updateNavigationTitle(to: "poppin.")
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 150.0 : 51.0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsProfileTableViewCell.identifier, for: indexPath) as? SettingsProfileTableViewCell else { return UITableViewCell() }
            cell.configureCell()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath)
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Location Services"
                cell.selectionStyle = .none
                let switchView = UISwitch(frame: .zero)
                switchView.isUserInteractionEnabled = false
                switchView.setOn(CLLocationManager.locationServicesEnabled(), animated: true)
                cell.accessoryView = switchView
                
            case 1:
                cell.textLabel?.text = "Sign Out"
                cell.accessoryType = .disclosureIndicator
                
            default:
                break
            
            }
            return cell
            
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                switchToggled()
            } else {
                
            }
        }
    }
    
    func switchToggled() {
        if !CLLocationManager.locationServicesEnabled() {
            if let url = URL(string: "App-Prefs:root=Privacy&path=LOCATION") {
                // If general location settings are disabled then open general location settings
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                // If general location settings are enabled then open location settings for the app
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    
}