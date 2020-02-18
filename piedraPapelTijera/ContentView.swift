//
//  ContentView.swift
//  piedraPapelTijera
//
//  Created by Francisco Misael Landero Ychante on 07/12/19.
//  Copyright © 2019 Francisco Misael Landero Ychante. All rights reserved.
//

import SwiftUI

struct gameButton: View {
    var text : String
    var body: some View {
        Text(text)
        .font(.system(size: 100))
        .shadow(color: .black, radius: 3)
        .background(Color.orange)
        .clipShape(Circle())
    }
}

struct ContentView: View {
    var gameOptionsEmoji = ["✊🏻", "✋🏻", "✌🏻"]
    var PapelWin = [true, false, false]
    var RocaWin = [false, false, true]
    var TijerasWin = [false, true, false]
    var gameOptionsText = ["Roca", "Papel", "Tijeras"]
    @State private var winORlosse = Bool.random()
    @State private var siriMove =  Int.random(in: 0 ... 3 )
    @State private var shots = 0
    @State private var score = 0
    @State private var  showFinalScore = false
    
    var gameState : String {
        if winORlosse == true {
            return "ganar"
        } else{
            return "perder"
        }
    }
    
 
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.orange, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all).blur(radius: 5)
            VStack(spacing: 10) {
                    Text("Siri tiró \(gameOptionsText[siriMove]) \(gameOptionsEmoji[siriMove]) ")
                         .foregroundColor(.white)
                         .font(.largeTitle)
                         .fontWeight(.black)
                    
                Text("Elige una opción para \(gameState) ")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                
                
                 ForEach(0 ..< 3){ number in
                                       
                    if number != self.siriMove{
                            Button(action:{
                                let result = self.userChose(self.gameOptionsText[number],self.siriMove)
                                if result == self.winORlosse {
                                    self.score += 1
                                }else{
                                    self.score -= 1
                                }
                                if self.shots == 10 {
                                    self.showFinalScore = true
                                    
                                }
                                self.winORlosse = Bool.random()
                                self.siriMove =  Int.random(in: 0 ... 2 )
                            }){
                                gameButton(text: "\(self.gameOptionsEmoji[number])")
                             }
                        }
                                        
                    }
                Text("Tu puntaje es \(self.score)")
                .foregroundColor(.white)
                .font(.largeTitle)
                
                
                 }
        }
     .alert(isPresented: $showFinalScore){
                  Alert(title: Text("Puntaje final"), message: Text("hiciste \(score)"), dismissButton:.default(Text("Ok")){
                        self.shots = 0
                        self.score = 0
                      })
              }
        
    }
    
  
    
    func userChose(_ userChose : String, _ siriChose : Int) -> Bool {
        self.shots += 1
        switch userChose {
            case "Roca":
                    return RocaWin[siriChose]
            case "Papel":
                    return PapelWin[siriChose]
            case "Tijeras":
                    return TijerasWin[siriChose]
            default:
            return false
            
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
