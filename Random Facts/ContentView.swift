//
//  ContentView.swift
//  Random Facts
//
//  Created by Emily Liang on 2020-11-30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    //Get a new fact
                    randomFacts()
                }, label: {
                    Text("New fun random fact, please!")
                })
                
                
            }
           
        
        }
        
       
    }
    
    // getting a random fact
    func fetchrandomfacts() {
        
        // 1. Prepare a URLRequest to send our encoded data as JSON
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        // 2. Run the request and process the response
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // handle the result here – attempt to unwrap optional data provided by task
            guard let doggieData = data else {
                
                // Show the error message
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
            
            // It seems to have worked? Let's see what we have
            print(String(data: doggieData, encoding: .utf8)!)
            
            // Now decode from JSON into an array of Swift native data types
            if let decodedDoggieData = try? JSONDecoder().decode(RandomDog.self, from: doggieData) {
                
                print("Doggie data decoded from JSON successfully")
                print("URL is: \(decodedDoggieData.message)")
                
                // Now fetch the image at the address we were given
                fetchImage(from: decodedDoggieData.message)
                
            } else {
                
                print("Invalid response from server.")
            }
            
        }.resume()
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
