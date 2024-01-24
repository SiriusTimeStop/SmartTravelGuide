//
//  DataController.swift
//  MapRoutes
//
//  Created by jackychoi on 2/12/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject{
    let container = NSPersistentContainer(name:"attractionData")
    
    init(){
        container.loadPersistentStores{
            desc, error in
            if let error = error{
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data saved!")
        }catch{
            print("We could not save the data...")
        }
    }
    
    func addAttraction(level: String,attraction1: String , attraction2: String, attraction3: String, attraction4: String, cost: String ,context: NSManagedObjectContext){
        let attraction = Attraction(context: context)
        attraction.id = UUID()
        attraction.date = Date()
        attraction.level = level
        attraction.cost = cost
        attraction.attraction1 = attraction1
        attraction.attraction2 = attraction2
        attraction.attraction3 = attraction3
        attraction.attraction4 = attraction4
        
        save(context: context)
    }
 
    func editAttraction(attraction: Attraction,level: String,attraction1:String,attraction2:String,attraction3:String,attraction4:String, cost: String ,context: NSManagedObjectContext)
    {
        attraction.date = Date()
        attraction.level = level
        attraction.attraction1 = attraction1
        attraction.attraction2 = attraction2
        attraction.attraction3 = attraction3
        attraction.attraction4 = attraction4
        
        save(context: context)
    }
}
