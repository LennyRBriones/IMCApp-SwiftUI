//
//  IMCView.swift
//  IMCApp
//
//  Created by Lenny R. Briones on 02/08/24.
//

import SwiftUI

struct IMCView: View {
    
    //    Another way to set the NavigationBar
    
    //    init(){
    //        UINavigationBar.appearance().titleTextAttributes =
    //        [.foregroundColor: Color.white]
    //    }
    
    @State var gender:Int = 0
    @State var height:Double = 120
    @State var age:Int = 15
    @State var weight:Int = 50
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    ToggleButton(text: "Male", imageName: "heart.fill", gender: 0, selectedGender: $gender )
                    ToggleButton(text: "Female", imageName: "star.fill", gender: 1, selectedGender: $gender)
                }
                HeightCalculator(selectedHeight: $height)
                HStack{
                    CounterButton(text: "Age", number: $age )
                    CounterButton(text: "Weight", number: $weight )
                }
                IMCCalculatorButton(userWeight: weight, userHeight: Int(height))
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.backgroundApp)
                .toolbar{
                    ToolbarItem(placement: .principal){
                        Text("IMC Calculator").bold().foregroundColor(.white)
                    }
                }
            
            //        Set the backbutton hidden
            
            //  .navigationBarBackButtonHidden()
            
            //       Default set of navigation title
            
            //  .navigationTitle("IMC Calculator")
        }
    }
}

struct ToggleButton:View{
    let text: String
    let imageName:String
    let gender:Int
    @Binding var selectedGender: Int
    
    var body: some View {
        
        let color = if(gender == selectedGender){
            Color.backgroundSelected
        }else{
            Color.backgroundComponent
        }
        
        Button(action: {
            selectedGender = gender
        }){
            VStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                InformationText(text: text)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(color)
        }
    }
}

struct InformationText:View {
    let text:String
    var body: some View {
        Text(text).font(.largeTitle).bold().foregroundColor(.white)
    }
}

struct TitleText:View {
    let text:String
    var body: some View {
        Text(text).font(.title2).foregroundColor(.gray)
    }
}

struct HeightCalculator:View {
    @Binding var selectedHeight:Double
    
    var body: some View {
        VStack{
            TitleText(text: "Height")
            InformationText(text: "\(Int(selectedHeight)) cm")
            Slider(value: $selectedHeight, in: 100...220, step: 1)
                .accentColor(.purple).padding(.horizontal, 16)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.backgroundComponent)
    }
}

struct CounterButton:View {
    let text:String
    @Binding var number:Int
    
    var body: some View {
        VStack{
            TitleText(text: text)
            InformationText(text: String(number))
            HStack{
                Button(action:{
                    if(number > 0){
                        number -= 1
                    }
                }){
                    ZStack{
                        Circle()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.purple)
                        Image(systemName: "minus")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                    }
                }
                Button(action:{
                    if(number < 150){
                        number += 1
                    }
                }){
                    ZStack{
                        Circle()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.purple)
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.backgroundSelected)
    }
}

struct IMCCalculatorButton:View {
    let userWeight:Int
    let userHeight:Int
    
    var body: some View {
        NavigationStack{
            NavigationLink(destination:{IMCResult(userWeight: userWeight, userHeight: userHeight)}){
                Text("Calculate").font(.title).bold().foregroundColor(.purple)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                    .background(.backgroundComponent)
            }
        }
    }
}

#Preview {
    IMCView()
}
