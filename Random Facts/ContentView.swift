//
//  ContentView.swift
//  Random Facts
//
//  Created by Emily Liang on 2020-11-30.
//

import SwiftUI

struct ContentView: View {
    
    @State private var fact: RandomFact = RandomFact()
    @State private var facts: [RandomFact] = []
    
    var body: some View {

        NavigationView {

            ZStack {
                Color.yellow.edgesIgnoringSafeArea(.all)


                VStack {
                    Button(action: {
                        //Get a new fact
                        fetchRandomFacts()

                    }, label: {
                        Text("New fun random fact")
                            .fontWeight(.semibold)
                            .font(.title3)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.vertical)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(40)

})
                    
                    Button {
                        //save a fact
                        saveFact()
                    } label: {
                        Text("Save this fact")
                            .fontWeight(.semibold)
                            .font(.title3)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.vertical)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(40)

                    }



                    GeometryReader { geometry in
                        Text(fact.text)
//                            .frame(width: geometry.size.width)
                        //                            .background(Color.white)
                            .font(.title2)

                    }
                    
                    List {
         //               facts.map(trans);
                        ForEach(facts){ (index) in
                            Text(index.text)
                            
                        }
                    }



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
    func trans(fact:RandomFact)->Text{
        return Text(fact.text)
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
    
    //Save the fact
    func saveFact() {
        // Gain access to user defaults
                   let defaults = UserDefaults.standard
                    

                   // Save the array of favourite colours to user defaults using the specified key
                   //defaults.set(fact, forKey: "randomFavorite")
                   //print(defaults.object(forKey: "randomFavorite"))
                    
        facts.append(fact)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
