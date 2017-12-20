//
//  MenuController.swift
//  BreadWallet
//
//  Created by German Mendoza on 9/26/17.
//  Copyright © 2017 Aaron Voisine. All rights reserved.
//

import UIKit

class MenuController: BaseController {

    @IBOutlet weak var titleLabel1: UILabel!
    @IBOutlet weak var titleLabel2: UILabel!
    @IBOutlet weak var titleLabel3: UILabel!
    @IBOutlet weak var titleLabel4: UILabel!
    
    
    @IBOutlet weak var syncImageView: UIImageView!
    @IBOutlet weak var syncLabel: UILabel!
    @IBOutlet weak var cotainerViewHeightConstraint: NSLayoutConstraint!
    var optionSelected:Int = 1
    
    override func setup(){
        cotainerViewHeightConstraint.constant = K.main.height - 130
        selectTitle()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.syncStarted),
            name: Notification.Name.BRPeerManagerSyncStartedNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.syncFinished),
            name: Notification.Name.BRPeerManagerSyncFinishedNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.syncFailed),
            name: Notification.Name.BRPeerManagerSyncFailedNotification,
            object: nil)
    }
    
    /**
    * This method is called when the instance is dealocated in swift.s
    */
    deinit {
        NotificationCenter.default.removeObserver(self);
    }


    @IBAction func tappedMyWalletButton(_ sender: Any) {
        if optionSelected == 1 {
            slideMenuController()?.closeLeft()
            return
        }
        
        let homeController = RootController.shared
        let nav = UINavigationController(rootViewController: homeController)
        slideMenuController()?.changeMainViewController(nav, close: true)
        optionSelected = 1
        selectTitle()
    }
    @IBAction func tappedAddressBookButton(_ sender: Any) {
        if optionSelected == 2 {
            slideMenuController()?.closeLeft()
            return
        }
        let controller = AddressContactController()
        let navigation = UINavigationController(rootViewController: controller)
        slideMenuController()?.changeMainViewController(navigation, close: true)
        optionSelected = 2
        selectTitle()
    }
    @IBAction func tappedSettingButton(_ sender: Any) {
        if optionSelected == 3 {
            slideMenuController()?.closeLeft()
            return
        }
        let controller =  SettingsController.shared
        //let controller = TxHistoryController.shared
        let nav = UINavigationController(rootViewController: controller)
        slideMenuController()?.changeMainViewController(nav, close: true)
        optionSelected = 3
        selectTitle()
    }
    @IBAction func tappedDonationButton(_ sender: Any) {
        if optionSelected == 4 {
            slideMenuController()?.closeLeft()
            return
        }
        let controller = DonationController(nibName:"Donation", bundle:nil)
        let navigation = UINavigationController(rootViewController: controller)
        slideMenuController()?.changeMainViewController(navigation, close: true)
        optionSelected = 4
        selectTitle()
    }
    
    func selectTitle(){
        titleLabel1.textColor = K.color.gray_r155g155b155
        titleLabel2.textColor = K.color.gray_r155g155b155
        titleLabel3.textColor = K.color.gray_r155g155b155
        titleLabel4.textColor = K.color.gray_r155g155b155
        
        switch optionSelected {
        case 1:
            titleLabel1.textColor = K.color.purple_r85g71b108
            break
        case 2:
            titleLabel2.textColor = K.color.purple_r85g71b108
            break
        case 3:
            titleLabel3.textColor = K.color.purple_r85g71b108
            break
        case 4:
            titleLabel4.textColor = K.color.purple_r85g71b108
            break
        default:
            print("default")
            break
        }
    }
    
    @objc func syncStarted(){
        print("Sync started!");
        syncLabel.text = "Syncing..";
        let progress:Double = (BRPeerManager.sharedInstance()?.syncProgress)!;
        syncLabel.text = String.init(format: "Syncing %0.1f%%", (progress > 0.1 ? progress - 0.1 : 0.0)*111.0);
    }
    
    @objc func syncFinished(){
        print("Sync finished!");
        syncLabel.text = "Synced";
    }
    
    @objc func syncFailed(){
        print("Sync failed!");
        syncLabel.text = "Not connection";
    }
    
    
}
