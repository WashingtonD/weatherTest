//
//  weatherTestApp.swift
//  weatherTest
//
//  Created by Denys Shevchuk on 05/06/2022.
//

import SwiftUI

@main
struct weatherTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}



func getGradientWithDay(isDay: Bool) -> LinearGradient
{
    if(isDay)
    {
        return LinearGradient(gradient: Gradient(colors: [Color.blue,Color.orange]), startPoint: .top, endPoint: .bottom)
    }
    else{
        let customNightColor = Color("CustomNightColor")
        let customNightColorSecondary = Color("CustomNightColorSecondary")
        var gradient = Gradient(colors:[customNightColor,customNightColorSecondary])
        return LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
    }
    
}

   func getAdvancedGradient(isDay: Bool) -> CAGradientLayer{
       let gradient = CAGradientLayer()
       gradient.type = .axial
       if(isDay)
       {
           gradient.colors = [
               UIColor.red.cgColor,
               UIColor.purple.cgColor,
               UIColor.cyan.cgColor]
           gradient.locations = [0,0.25,1]
       }
       else{
           let color = UIColor(red: 0.00, green: 0.20, blue: 0.40,alpha: 1.00)
           let colorSecondary = UIColor(red: 0.18, green: 0.36, blue: 0.52, alpha: 0.90)
           gradient.colors = [
               color.cgColor,
               colorSecondary.cgColor
           ]
           gradient.locations = [0,1]
       }
       return gradient
   }
