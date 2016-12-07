//
//  MissionDetailsViewControllerDelegate.swift
//  BucketList
//
//  Created by Daniel Kouba on 12/6/16.
//  Copyright © 2016 Daniel Kouba. All rights reserved.
//

import Foundation

protocol MissionDetailsViewControllerDelegate: class {
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String)
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission mission: String, atIndexPath indexPath: Int)
}
