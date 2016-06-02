//
//  SessionModel.swift
//  iOS-Project
//
//  Created by SABai on 2/06/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SessionModel{
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    //Create a new session
    func CreateCollec(name: String, day: String, detail: String, i: Int, img: String, img2: String, my: Bool, num: String, time: String, start: String, topic: String) -> Session {
        let newSession: Session = NSEntityDescription.insertNewObjectForEntityForName("Session", inManagedObjectContext: context) as! Session
        newSession.day = day
        newSession.detail = detail
        newSession.i = i
        newSession.img = img
        newSession.img2 = img2
        newSession.my = my
        newSession.name = name
        newSession.num = num
        newSession.start = start
        newSession.time = time
        newSession.topic = topic
        
        do{
            try context.save()
        }
        catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
        return newSession
    }
    func favoriate(session: Session)
    {
        print(session.my)
        
        if (session.my == true)
        {
            session.my = false
        }
        else
        {
            session.my = true
        }
        print(session.my)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    func getMySchedule() -> [Session]
    {
        let fetch = NSFetchRequest(entityName: "Session")
        var temp = [Session]()
        do{
            temp = try context.executeFetchRequest(fetch) as! [Session]
        }catch let error as NSError{
            print("Fetch error: \(error), \(error.userInfo)")
        }
        var final = [Session]()
        for one in temp
        {
            if  one.my == true
            {
                print("cnmcnmcnmcnmcnmcnmcncm")
                print(one.topic)
                final.append(one)
            }
        }
        return final
    }
    
    func getByDay(day: String!) -> [Session]
    {
        let fetch = NSFetchRequest(entityName: "Session")
        var temp = [Session]()
        do{
            temp = try context.executeFetchRequest(fetch) as! [Session]
        }catch let error as NSError{
            print("Fetch error: \(error), \(error.userInfo)")
        }
        var final = [Session]()
        for one in temp
        {
            let a: String! = one.day!
            print(a)
            print(day)
            if  a == day
            {
                final.append(one)
            }
        }
        print("!!!!!!!!!!")
        print(final.count)
        return final
    }
    
    //Get all sessions
    func GetSessions() -> [Session] {
        let fetch = NSFetchRequest(entityName: "Session")
        var temp = [Session]()
        do{
            temp = try context.executeFetchRequest(fetch) as! [Session]
        }catch let error as NSError{
            print("Fetch error: \(error), \(error.userInfo)")
        }
        return temp
    }
    
    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.deleteObject(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
}