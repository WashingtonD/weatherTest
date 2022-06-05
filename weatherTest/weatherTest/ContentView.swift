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
    @State var imgs = Data()
    @State var forecastDescr = "Clear"
    @State var getTemp = false
    @State var presure = 0
    @State var feelsLike = 0
    @State var weatherCode = 125
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
    
    var defaultUrl = "http://api.weatherstack.com/current?access_key=c44ccd5231093d11c36e5e302329beb7&query="
    
    
    var body: some View {
        TabView(selection: $selectedTab){
        VStack{
                Text("\(city)")
                    .font(.system(size: 40))
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Text("\(description)")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 30))
                    .padding(.bottom,20)
            AnimatedImage(url: URL(string: currentIcon)).resizable()
                .frame(width: 75, height: 75)
                .clipShape(Circle())
                .shadow(radius: 15)
                Text("\(self.temp)°")
                    .foregroundColor(.blue)
                    .font(.system(size: 65))
                Text("Feels like: \(self.feelsLike)°")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 30))
                
            
        }.tabItem{
            Image(systemName: "circle.fill")
           // background(Color.green)
        }.tag(1)
            VStack{
                    Text("\(city)")
                        .font(.system(size: 40))
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text("\(description)")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 30))
                        .padding(.bottom,20)
                AnimatedImage(url: URL(string: currentIcon)).resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .shadow(radius: 15)
                    Text("\(self.temp)°")
                        .foregroundColor(.blue)
                        .font(.system(size: 65))
                    Text("Feels like: \(self.feelsLike)°")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 30))
                    
                
            }.tabItem{
                Image(systemName: "circle.fill")
            }.tag(2)
            VStack{
                    Text("\(city)")
                        .font(.system(size: 40))
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text("\(description)")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 30))
                        .padding(.bottom,20)
                AnimatedImage(url: URL(string: currentIcon)).resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .shadow(radius: 15)
                    Text("\(self.temp)°")
                        .foregroundColor(.blue)
                        .font(.system(size: 65))
                    Text("Feels like: \(self.feelsLike)°")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 30))
                    
                
            }.tabItem{
                Image(systemName: "circle.fill")
            }.tag(3)
        }.onChange(of: selectedTab, perform: { item in
            self.getForecastData(city: cityAndTab[item]!)
            if(isDay){
               background(Color.white)
            }else{
                background(Color.gray
                            .grayscale(1/3))
            }
        })
        .onAppear(){
            self.getForecastData(city: "Paris")
        }

    }


    func getForecastData(city: String){
        
        let url = defaultUrl + city
         var temp = 0
         var windSpeed = 0
         var humidity = 0
         var weatherDescription = ""
         var feelsLike = 0
         var isDay = true
         var pressure = 0
         var date = ""
         var code = 123
         var icon = ""
        
        
        var newCity = city.replacingOccurrences(of: "%20", with: " ")
        self.city = newCity
        
        AF.request(url).responseData{ (data) in
            
            let json = try! JSON(data: data.data!)
            
            if json["success"].stringValue != "false"{
                
            let current = json["current"]
                
                
                temp = current["temperature"].intValue
                self.temp = temp
                weatherDescription = current["weather_descriptions"][0].stringValue
                date = json["location"]["localtime"].stringValue
            
                windSpeed = current["wind_speed"].intValue
                humidity = current["humidity"].intValue
                feelsLike = current["feelslike"].intValue
                pressure = current["pressure"].intValue
                code = current["weather_code"].intValue
                icon = current["weather_icons"][0].stringValue
                
                
                
                if current["is_day"] == "yes"{
                    isDay = true
                }
                else{
                isDay = false
                }
                
                self.description = weatherDescription
                self.presure = pressure
                self.feelsLike = feelsLike
                self.weatherCode = code
                self.date = date
                self.currentIcon = icon
                self.isDay = isDay
            }
            else
            {
                print("FAALSE")
            }
        }
     
        
      
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct WeatherModel {
    
    var query: String
    var temp: Int
    var windSpeed: Int
    var humidity: Int
    var icon: String
    var weatherDescription: String
    var feelsLike: Int
    var isDay: Bool
    var pressure: Int
    var date: String
    
}

