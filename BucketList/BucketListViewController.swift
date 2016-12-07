//
//  ViewController.swift
//  BucketList
//
//  Created by Daniel Kouba on 12/6/16.
//  Copyright © 2016 Daniel Kouba. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, CancelButtonDelegate, MissionDetailsViewControllerDelegate {

    
//    var missions = ["Skydive", "Scuba dive", "Eat a Ghost Pepper"]  
    var missions = [Mission]()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    
    
    
    override func viewDidLoad() {

        
////////////////////////////////////////
// This is to add an element into Core Data :: Mission
////////////////////////////////////////
    
//       let mission = NSEntityDescription.insertNewObjectForEntityForName("Mission", inManagedObjectContext: managedObjectContext) as! Mission
    
//        mission.details = "Sky Diving"
        
//        if managedObjectContext.hasChanges {
//            do {
//                try managedObjectContext.save()
//                print("Success")
//            } catch {
//                print("\(error)")
//            }
//        }
        
        ////////////////////////////////////////
        //This is the Core Data Query
        ////////////////////////////////////////
        let missionRequest = NSFetchRequest(entityName: "Mission")
        
        do {
            // get the results by executing the fetch request we made earlier
            let results = try managedObjectContext.executeFetchRequest(missionRequest)
            // downcast the results as an array of Mission objects
            missions = (results as? [Mission])!
            // print the details of each mission
            for mission in missions {
                print("\(mission.details)")
            }
        } catch {
            // print the error if it is caught (Swift automatically saves the error in "error")
            print("\(error)")
        }
        print(missions)
        super.viewDidLoad()
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
        
        print(missions)
        
        cell!.textLabel?.text = missions[indexPath.row].details
        
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
                controller.missionToEdit = missions[indexPath.row].details
                //Send cell index
                controller.missionToEditIndexPath = indexPath.row
            }
            
        }
    }
    
    // If finished adding mission dismiss view
    // Append data to missions
    // Reload table data
    
    
    //Comment this back in and change to CRUD CoreData

    ////////////////////////////////////////
    //Core Data CRUD
    ////////////////////////////////////////
    
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String) {
        dismissViewControllerAnimated(true, completion: nil)
//        missions.append(mission)
        
        
        
        tableView.reloadData()
    }
    

    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission mission: String, atIndexPath indexPath: Int) {
        dismissViewControllerAnimated(true, completion: nil)
//        self.missions[indexPath] = mission
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        missions.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    
    
    
}

