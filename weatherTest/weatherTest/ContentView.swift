//
//  ContentView.swift
//  weatherTest
//
//  Created by Denys Shevchuk on 05/06/2022.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import SDWebImage
import SDWebImageSwiftUI


struct ContentView: View {
    @State var city = "New York"
    @State var temp = 0
    @State var description = ""
    @State var humidity = 0
    @State var forecastDescr = "Clear"
    @State var getTemp = false
    @State var feelsLike = 0
    @State var currentIcon = ""
    @State var date = ""
    @State var selectedTab = 1
    @State var lastTab = 1
    @State var isDay = true
    let cityAndTab = [
        1: "Paris",
        2: "New%20York",
        3: "Lodz"
    ]
    @State var gradient = LinearGradient(gradient: Gradient(colors: [Color.white]), startPoint: .top, endPoint: .bottom)
    @State var dayColor = Color.white
    
    var defaultUrl = "http://api.weatherstack.com/current?access_key=c44ccd5231093d11c36e5e302329beb7&query="
    
    
    var body: some View {
        TabView(selection: $selectedTab){
            ZStack
            {
             gradient
             VStack{
                Text("\(city)")
                    .font(.system(size: 40))
                    .foregroundColor(dayColor)
                Text("\(date)")
                    .font(.system(size: 30))
                    .foregroundColor(dayColor)
                Text("\(description)")
                    .foregroundColor(dayColor)
                    .font(.system(size: 30))
                    .padding(.bottom,20)
            AnimatedImage(url: URL(string: currentIcon)).resizable()
                .frame(width: 75, height: 75)
                .clipShape(Circle())
                .shadow(radius: 15)
                Label("\(self.temp)°",systemImage: "thermometer")
                    .foregroundColor(dayColor)
                    .font(.system(size: 65))
                Text("Feels like: \(self.feelsLike)°")
                    .foregroundColor(dayColor)
                    .font(.system(size: 30))
                Text("Humidity: \(self.humidity)%")
                    .foregroundColor(dayColor)
                    .font(.system(size: 30))
                
        }
        }.tabItem{
            Image(systemName: "circle.fill")
        }.tag(1)
            ZStack{
                gradient
            VStack{
                    Text("\(city)")
                        .font(.system(size: 40))
                        .foregroundColor(dayColor)
                    Text("\(date)")
                        .font(.system(size: 30))
                        .foregroundColor(dayColor)
                    Text("\(description)")
                        .foregroundColor(dayColor)
                        .font(.system(size: 30))
                        .padding(.bottom,20)
                AnimatedImage(url: URL(string: currentIcon)).resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .shadow(radius: 15)
                Label("\(self.temp)°",systemImage: "thermometer")
                    .foregroundColor(dayColor)
                    .font(.system(size: 65))
                    Text("Feels like: \(self.feelsLike)°")
                        .foregroundColor(dayColor)
                        .font(.system(size: 30))
                Text("Humidity: \(self.humidity)%")
                    .foregroundColor(dayColor)
                    .font(.system(size: 30))
            }
                
            }.tabItem{
                Image(systemName: "circle.fill")
            }.tag(2)
            
            ZStack{
            gradient
            VStack{
                    Text("\(city)")
                        .font(.system(size: 40))
                        .foregroundColor(dayColor)
                Text("\(date)")
                    .font(.system(size: 30))
                    .foregroundColor(dayColor)
                    Text("\(description)")
                        .foregroundColor(dayColor)
                        .font(.system(size: 30))
                        .padding(.bottom,20)
                AnimatedImage(url: URL(string: currentIcon)).resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .shadow(radius: 15)
                Label("\(self.temp)°",systemImage: "thermometer")
                    .foregroundColor(dayColor)
                    .font(.system(size: 65))
                    Text("Feels like: \(self.feelsLike)°")
                        .foregroundColor(dayColor)
                        .font(.system(size: 30))
                Text("Humidity: \(self.humidity)%")
                    .foregroundColor(dayColor)
                    .font(.system(size: 30))
                    
            }
            }.tabItem{
                Image(systemName: "circle.fill")
            }.tag(3)
        }.onChange(of: selectedTab, perform: { item in
            self.getForecastData(city: cityAndTab[item]!)
            
        })
        .onAppear(){
            self.getForecastData(city: "Paris")
        }
        

    }

    func getForecastData(city: String){
        
        let url = defaultUrl + city
         var temp = 0
         var humidity = 0
         var weatherDescription = ""
         var feelsLike = 0
         var isDay = true
         var date = ""
         var icon = ""
        
        
        let newCity = city.replacingOccurrences(of: "%20", with: " ")
        self.city = newCity
        
        AF.request(url).responseData{ (data) in
            
            let json = try! JSON(data: data.data!)
            
            if json["success"].stringValue != "false"{
                
            let current = json["current"]
                
                
                temp = current["temperature"].intValue
                self.temp = temp
                weatherDescription = current["weather_descriptions"][0].stringValue
                let adate = json["location"]["localtime"].stringValue
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE, MMM d"
                let dateForm = dateFormatter.date(from: adate) ?? Date()
                date = dateFormatter.string(from: dateForm)
                
                
                humidity = current["humidity"].intValue
                feelsLike = current["feelslike"].intValue
                icon = current["weather_icons"][0].stringValue
                
                
                
                if current["is_day"] == "yes"{
                    isDay = true
                }
                else{
                isDay = false
                }
                
                self.description = weatherDescription
                self.feelsLike = feelsLike
                self.date = date
                self.currentIcon = icon
                self.isDay = isDay
                self.gradient = getGradientWithDay(isDay: isDay)
                self.dayColor = isDay == true ? Color.white : Color.blue
                self.humidity = humidity
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




