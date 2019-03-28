//
//  ProgramObject.swift
//  w9Complications WatchKit Extension
//
//  Created by Justine Manikan on 11/8/18.
//  Copyright © 2018 Justine Manikan. All rights reserved.
//

import WatchKit

class ProgramObject: NSObject {
    
    var title : String?
    var speaker : String?
    var from : Date?
    var to : Date?
    var  details : String?
    
    func initWithData (title: String, speaker : String, from : Date, to : Date, details: String){
        
        self.title = title
        self.speaker = speaker
        self.from = from
        self.to = to
        self.details = details
        
    }
    
    

}
