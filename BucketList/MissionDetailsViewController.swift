//
//  MissionDetailsViewController.swift
//  BucketList
//
//  Created by Daniel Kouba on 12/6/16.
//  Copyright © 2016 Daniel Kouba. All rights reserved.
//

import UIKit

class MissionDetailsViewController: UITableViewController {
    @IBOutlet weak var newMissionTextField: UITextField!
    var missionToEdit: String?
    var missionToEditIndexPath: Int?
    weak var delegate: MissionDetailsViewControllerDelegate?
    weak var cancelButtonDelegate: CancelButtonDelegate?
    
    
    
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        
        if var mission = missionToEdit {
            mission = newMissionTextField.text!
            delegate?.missionDetailsViewController(self, didFinishEditingMission: mission, atIndexPath: missionToEditIndexPath!)
        } else {
            let mission = newMissionTextField.text!
            delegate?.missionDetailsViewController(self, didFinishAddingMission: mission)
        }
        
        
    }
    
    
    
    // If we are editing a value
    // populate the text field with the value
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (missionToEdit != nil){
            self.newMissionTextField.text = missionToEdit
        }
    }
    
    
    
    
    
}

