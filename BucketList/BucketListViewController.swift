//
//  ViewController.swift
//  BucketList
//
//  Created by Daniel Kouba on 12/6/16.
//  Copyright © 2016 Daniel Kouba. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, CancelButtonDelegate, MissionDetailsViewControllerDelegate {

    
    var missions = ["Skydive", "Scuba dive", "Eat a Ghost Pepper"]  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // How many cells to create?
    // As many cells as items in mission
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return missions.count
    }
    
    //Create cells from data
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MissionCell")
        
        cell!.textLabel?.text = missions[indexPath.row]
        
        return cell!
    }

    
    // Detect Cancel Button Pressed
    // Dismiss View
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("EditMission", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    
    // Override Segue
    // Call Delegates
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "AddNewMission" {
            
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! MissionDetailsViewController
            
            
            controller.cancelButtonDelegate = self
            controller.delegate = self
            
            
        } else if segue.identifier == "EditMission" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! MissionDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
            
            
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell){
                //Send cell text
                controller.missionToEdit = missions[indexPath.row]
                //Send cell index
                controller.missionToEditIndexPath = indexPath.row
            }
            
        }
    }
    
    // If finished adding mission dismiss view
    // Append data to missions
    // Reload table data
    
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String) {
        dismissViewControllerAnimated(true, completion: nil)
        missions.append(mission)
        tableView.reloadData()
    }
    

    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission mission: String, atIndexPath indexPath: Int) {
        dismissViewControllerAnimated(true, completion: nil)
        self.missions[indexPath] = mission
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        missions.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    
    
    
}

