//
//  TableViewController.swift
//  SimCardInfo
//
//  Created by Vinayak Tudayekar on 21/09/21.
//

import UIKit
import CoreTelephony
import DeviceCheck


class TableViewController: UITableViewController {
    //Declare variable
    
    let networkInfo = CTTelephonyNetworkInfo()

    
    static let tableViewCellIdentifier = "Cell"
    
    private let CellIdentifier = "Cell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.prompt = "CTTelephonyNetworkInfo"
        
        navigationItem.title = "CTCarrier"
        //initialization

        getDeviceToken()
        if #available(iOS 12, *){
            networkInfo.serviceSubscriberCellularProvidersDidUpdateNotifier = { [networkInfo] carrierIdentifier in
                let carrier: CTCarrier? = networkInfo.serviceSubscriberCellularProviders?[carrierIdentifier]
                let alert = UIAlertController(title: "Sim Alert", message: "Sim card changed", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("User did change SIM")
            DispatchQueue.main.async {
                print("User did change SIM")
            }
            
        }
        }else {
            networkInfo.subscriberCellularProviderDidUpdateNotifier = { carrier in
                DispatchQueue.main.async {
                    print("User did change SIM")
                }
            }
        }
    }
    
    func getDeviceToken(){
        if DCDevice.current.isSupported { // Always test for availability.
            DCDevice.current.generateToken { token, error in

                guard error == nil else { return/* Handle the error. */ }
                print("token =\(String(describing: token?.base64EncodedString()))")

                // Send the token to your server.
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let carrier = networkInfo.subscriberCellularProvider
        
        var cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)
        
        if cell == nil {
            
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: CellIdentifier)
        }
        
        switch indexPath.row {
        case 0 /*Supplier name*/:
            cell?.textLabel?.text = "carrierName"
            cell?.detailTextLabel?.text = carrier?.carrierName
        case 1 /*Country code */:
            cell?.textLabel?.text = "mobileCountryCode"
            cell?.detailTextLabel?.text = carrier?.mobileCountryCode
        case 2 /*Supplier network number */:
            cell?.textLabel?.text = "mobileNetworkCode"
            cell?.detailTextLabel?.text = carrier?.mobileNetworkCode
        case 3:
            cell?.textLabel?.text = "isoCountryCode"
            cell?.detailTextLabel?.text = carrier?.isoCountryCode
        case 4 /*Whether to allow voip */:
            cell?.textLabel?.text = "allowsVOIP"
            cell?.detailTextLabel?.text = carrier?.allowsVOIP ?? false ? "YES" : "NO"
        default:
            break
        }
        
        return cell ?? UITableViewCell()

    }



}
