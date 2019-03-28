//
//  ExtensionDelegate.swift
//  w9Complications WatchKit Extension
//
//  Created by Justine Manikan on 11/8/18.
//  Copyright © 2018 Justine Manikan. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    
    var programs : [ProgramObject] = []
    
    
    
    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        let progObj = ProgramObject()
        let calendar = Calendar.current
        let start1 = calendar.date(byAdding: .minute, value: 90, to: Date())
        let end1 = start1?.addingTimeInterval(60 * 60)
        
        progObj.initWithData(title: "C#", speaker: "Justine", from: start1!, to: end1!, details: "Teach C#")
        programs.append(progObj)
        
        let progObj2 = ProgramObject()
        let start2 = end1?.addingTimeInterval(30*60)
        let end2 = start2?.addingTimeInterval(60*60)
        
        progObj2.initWithData(title: "C", speaker: "Kyle", from: start2!, to: end2!, details: "Teach C")
        programs.append(progObj2)
        
        let progObj3 = ProgramObject()
        let start3 = end2?.addingTimeInterval(30*60)
        let end3 = start3?.addingTimeInterval(60*60)
        
        progObj3.initWithData(title: "C++", speaker: "Soriano", from: start3!, to: end3!, details: "Teach C++")
        programs.append(progObj3)
        
        
        
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }

}
