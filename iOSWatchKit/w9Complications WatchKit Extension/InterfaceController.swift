//
//  InterfaceController.swift
//  w9Complications WatchKit Extension
//
//  Created by Justine Manikan on 11/8/18.
//  Copyright © 2018 Justine Manikan. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet var progTable : WKInterfaceTable!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        let myDelegate =  WKExtension.shared().delegate as! ExtensionDelegate
        
        self.progTable.setNumberOfRows(myDelegate.programs.count, withRowType: "ProgRowController")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        
        for(index, prog) in myDelegate.programs.enumerated(){
            let row = self.progTable.rowController(at: index) as! ProgRowController
            row.lblTitle.setText(prog.title)
            row.lblSpeaker.setText(prog.speaker)
            
            let timeString = dateFormatter.string(from: prog.from!)
            let timeString2 = dateFormatter.string(from: prog.to!)
            row.lblFrom.setText(timeString)
            row.lblTo.setText("-\(timeString2)")
        }
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
