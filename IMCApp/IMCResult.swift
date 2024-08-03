//
//  IMCResult.swift
//  IMCApp
//
//  Created by Lenny R. Briones on 03/08/24.
//

import SwiftUI

struct IMCResult: View {
    let userWeight:Double
    let userHeight:Double
    var body: some View {
        VStack{
            Text("Your result is:").font(.title).bold().foregroundStyle(.white)
            let result = calculateIMC(weight: userWeight, height: userHeight)
            InformationView(result:result)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.backgroundApp)
        
    }
}

func calculateIMC(weight:Double, height:Double) -> Double{
    let result = weight/((height/100)*(height/100))
    return result
    
}

struct InformationView: View {
    let result:Double
    var body: some View {
        
        let information = GetIMCResult(result: result)
        VStack{
            Spacer()
            Text(information.0).foregroundColor(information.2).font(.title).bold()
            Spacer()
            Text("\(result, specifier: "%.2f")").font(.system(size: 80)).bold().foregroundColor(.white)
            Spacer()
            Text(information.1).foregroundColor(.white).font(.title2).padding(.horizontal, 11)
            Spacer()
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.backgroundComponent).cornerRadius(16)
    }
}

func GetIMCResult(result:Double) -> (String, String, Color){
    let title:String
    let description:String
    let color:Color
    
    switch result{
    case 0.00...19.99:
        title = "Under Weight"
        description = "You're under your ideal weight according to IMC"
        color = Color.yellow
        
        
    case 20.00...24.99:
        title = "Normal Weight"
        description = "You're in your ideal weight according to IMC"
        color = Color.green
        
        
    case 25.00...29.99:
        title = "OverWeight"
        description = "You're over your ideal weight according to IMC "
        color = Color.orange
        
        
    case 30.00...100:
        title = "Obesity"
        description = "You're to over your ideal weight according IMC"
        color = Color.red
        
    default:
        title = "Error"
        description = "An Error has ocurred"
        color = Color.gray
        
    }
    return(title,description,color)
}


#Preview {
    IMCResult(userWeight: 80, userHeight: 167)
}
