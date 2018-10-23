//
//  GetBirdVehicles.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 9/13/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import Foundation
import CoreLocation
import AutoGraphQL

func getBirdVehicles(withinRange range: CLLocationDistance, ofLocation location: CLLocationCoordinate2D) -> [Vehicle] {
    // TODO: Bird Get Function
    // Set up the URL request
    var todoEndpoint: String = "https://api.bird.co/bird/nearby?latitude=" + String(location.latitude)
        todoEndpoint = todoEndpoint + "&longitude=" + String(location.longitude) + "&radius=" + String(range)
    guard let url = URL(string: todoEndpoint) else {
        print("Error: cannot create URL")
        let empty = [Vehicle]()
        return empty
    }
    let urlRequest = URLRequest(url: url)
    
    // set up the session
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    // make the request
    let task = session.dataTask(with: urlRequest) {
        (data, response, error) in
        // check for any errors
        guard error == nil else {
            print("error calling GET on /todos/1")
            print(error!)
            return
        }
        // make sure we got data
        guard let responseData = data else {
            print("Error: did not receive data")
            return
        }
        // parse the result as JSON, since that's what the API provides
        do {
            guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                as? [String: Any] else {
                    print("error trying to convert data to JSON")
                    return
            }
            // now we have the todo
            // let's just print it to prove we can access it
            print("The todo is: " + todo.description)
            
            // the todo object is a dictionary
            // so we just access the title using the "title" key
            // so check for a title and print it if we have one
            guard let todoTitle = todo["title"] as? String else {
                print("Could not get todo title from JSON")
                return
            }
            print("The title is: " + todoTitle)
        } catch  {
            print("error trying to convert data to JSON")
            return
        }
    }
    task.resume()

    struct vehicleList: Decodable {
        
        let vehicles: [multiVehicle]
    }
    struct multiVehicle: Decodable {
        let id: String
        let type: String
        let attributes: [String]
        let lat: Float
        let long: Float
        
    }
    let query = AutoGraphQL.Operation(type: .query, name: "GetBirdVehicles", fields:[
        Object(
            name: "vehicles",
            arguments: ["lat" : 38.645502, "lng" : -90.314853],
            fields: [
                "id",
                "type",
                "attributes",
                "lat",
                "lng",
                Object(name: "provider", fields: ["name"])
            ])
        ])
    return [Vehicle]()
}

