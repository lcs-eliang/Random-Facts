//
//  ContentView.swift
//  Random Facts
//
//  Created by Emily Liang on 2020-11-30.
//

import SwiftUI

struct ContentView: View {
    
    @State private var fact: RandomFact = RandomFact()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow.edgesIgnoringSafeArea(.all)
                VStack {
                    Button(action: {
                        //Get a new fact
                        fetchRandomFacts()
                    }, label: {
                        Text("New fun random fact, please!")
                        
                    })
                    
                    Text(fact.text)
                    
                    Image("BeHappy")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    Spacer()
                }
                .navigationTitle("Random Useless Facts")
                .padding(.horizontal)
                .background(Color.yellow)
            }
            
        }
        
    }
    
    // getting a random fact
    func fetchRandomFacts() {
        
        // 1. Prepare a URLRequest to send our encoded data as JSON
        let url = URL(string: "https://uselessfacts.jsph.pl/random.json?language=en")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        // 2. Run the request and process the response
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // handle the result here – attempt to unwrap optional data provided by task
            guard let randomData = data else {
                
                // Show the error message
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
            
            // It seems to have worked? Let's see what we have
            print(String(data: randomData, encoding: .utf8)!)
            
            // Now decode from JSON into an array of Swift native data types
            if let randomFactData = try? JSONDecoder().decode(RandomFact.self, from: randomData) {
                
                print("Random data decoded from JSON successfully")
                print("Text is: \(randomFactData.text)")
            
                // Update the UI on the main thread
                DispatchQueue.main.async {
                    fact = randomFactData
                }

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
