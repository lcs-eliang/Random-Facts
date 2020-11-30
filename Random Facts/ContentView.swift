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
    
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
