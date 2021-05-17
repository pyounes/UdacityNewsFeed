//
//  SettingsVC.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/17/21.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var deleteOnExitSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.deleteOnExitSwitch.isOn = deleteOnExit

    }
    
    @IBAction func deleteOnExitSwitched(_ sender: UISwitch) {
        deleteOnExit = self.deleteOnExitSwitch.isOn
    }
    
}
