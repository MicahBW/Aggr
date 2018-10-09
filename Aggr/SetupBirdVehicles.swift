import UIKit

//
//  SetupBird.swift
//
//
//  Created by Noah Saffer on 10/1/18.
//

import Foundation

func setupPostRequest() -> String {
    var token : String = ""
    let todosEndpoint: String = "https://api.bird.co/user/login"
    guard let todosURL = URL(string: todosEndpoint) else {
        return "Error: cannot create URL"
    }
    var todosUrlRequest = URLRequest(url: todosURL)
    todosUrlRequest.httpMethod = "POST"
    let newTodo: [String: Any] = ["email": "testemail7@gmail.com"]
    todosUrlRequest.allHTTPHeaderFields = [ "Device-ID" : "GUID",
                                            "Platform" : "ios",
                                            "Content-type" : "application/json"
    ]
    
    let jsonTodo: Data
    do {
        jsonTodo = try JSONSerialization.data(withJSONObject: newTodo, options: [])
        todosUrlRequest.httpBody = jsonTodo
    } catch {
        return "Error: cannot create JSON from todo"
    }
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: todosUrlRequest) {
        (data, response, error) in
        guard error == nil else {
            print("error calling POST on /todos/1")
            print(error!)
            return
        }
        guard let responseData = data else {
            print("Error: did not receive data")
            return
        }
        
        // parse the result as JSON, since that's what the API provides
        do {
            guard let receivedTodo = try JSONSerialization.jsonObject(with: responseData,
                                                                      options: []) as? [String: Any] else {
                                                                        print("Could not get JSON from responseData as dictionary")
                                                                        return
            }
            //print("The todo is: " + receivedTodo.description)
            if (receivedTodo["token"] != nil){
                token = (receivedTodo["token"] as! Optional)!
                print(token)
            } else {
                token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJBVVRIIiwidXNlcl9pZCI6ImRhMDMzZGM4LWUyZjgtNDFlYy04ZDBkLTQ4YWZmNzc0ZGJkMCIsImRldmljZV9pZCI6IkdVSUQiLCJleHAiOjE1NzA1NTg4Mzd9.-1HEritI3Y7UrOem03Mo6fFucPqfqVaOqG-9CjiRLCg"
                print(token)
            }
            
        } catch  {
            print("Error parsing response from POST on /todos")
            return
        }
    }
    task.resume()
    print(token)
    return token
}
