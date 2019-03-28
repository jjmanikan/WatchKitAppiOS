//
//  ComplicationController.swift
//  w9Complications WatchKit Extension
//
//  Created by Justine Manikan on 11/8/18.
//  Copyright © 2018 Justine Manikan. All rights reserved.
//

import ClockKit
import WatchKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        
        let currentDate = Date()
        handler(currentDate)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        var currentDate = Date()
        currentDate = currentDate.addingTimeInterval(24*60*60)
        handler(currentDate)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        if complication.family == .modularLarge {
            
            let myDelegate = WKExtension.shared().delegate as! ExtensionDelegate
            let template = CLKComplicationTemplateModularLargeStandardBody()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            
            let timeString = dateFormatter.string(from: myDelegate.programs[0].from!)
            
            template.headerTextProvider = CLKSimpleTextProvider(text: myDelegate.programs[0].title!)
            
            template.body2TextProvider = CLKSimpleTextProvider(text: myDelegate.programs[0].speaker!)
            
            template.body2TextProvider = CLKSimpleTextProvider(text: timeString)
            
            let timelineEntry = CLKComplicationTimelineEntry(date: myDelegate.programs[0].from!, complicationTemplate: template)
            
            handler(timelineEntry)
            
        } else{
            handler(nil)
        }
        
    }
    
    func getList() -> [CLKComplicationTimelineEntry]{
        let myDelegate = WKExtension.shared().delegate as! ExtensionDelegate
        var timelineEntryArray = [CLKComplicationTimelineEntry]()
        var nextDate = Date(timeIntervalSinceNow: 60*60)
        
        for index in 1...(myDelegate.programs.count-1) {
            let template = CLKComplicationTemplateModularLargeStandardBody()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            
            let timeString = dateFormatter.string(from: myDelegate.programs[index].from!)
            
            template.headerTextProvider = CLKSimpleTextProvider(text: myDelegate.programs[index].title!)
            
            template.body2TextProvider = CLKSimpleTextProvider(text: myDelegate.programs[index].speaker!)
            
            template.body2TextProvider = CLKSimpleTextProvider(text: timeString)
            
            let timelineEntry = CLKComplicationTimelineEntry(date: myDelegate.programs[index].from!, complicationTemplate: template)
            timelineEntryArray.append(timelineEntry)
            nextDate = nextDate.addingTimeInterval(60*60)
        }
        return timelineEntryArray
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        
        if complication.family == .modularLarge{
            var timelineEntryArray = [CLKComplicationTimelineEntry]()
            timelineEntryArray = getList()
            handler(timelineEntryArray)
        }else {
            handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        if complication.family == .modularLarge{
            var timelineEntryArray = [CLKComplicationTimelineEntry]()
            timelineEntryArray = getList()
            handler(timelineEntryArray)
        }else {
            handler(nil)
        }
    }
    
    func getPlaceholderTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        let template = CLKComplicationTemplateModularLargeStandardBody()
        
        template.headerTextProvider = CLKSimpleTextProvider(text: "Header Message")
        template.body1TextProvider = CLKSimpleTextProvider(text: "Header Body 1")
        template.body2TextProvider = CLKSimpleTextProvider(text: "Header body 2")
        
        handler(template)
    }
    
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
    
}
