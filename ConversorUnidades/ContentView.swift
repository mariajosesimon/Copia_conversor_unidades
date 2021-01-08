//
//  ContentView.swift
//  ConversorUnidades
//
//  Created by Ion Jaureguialzo Sarasola on 18/12/20.
//

import SwiftUI

enum UnidadesES: String, CaseIterable, Identifiable {

    case cm
    case m
    case km

    var id: String { self.rawValue }
}
enum UnidadesUK: String, CaseIterable, Identifiable {

    case pies
    case yardas
    case millas

    var id: String { self.rawValue }
}

func calculo (unidadES: String, unidad: Double, unidadUK: String) -> Double {
    var resultado: Double

    //calculos realizados sobre cm
    switch unidadUK {
    case "pies":
        resultado = unidad / 30.48
    case "yardas":
        resultado = unidad / 91.44
    case "millas":
        resultado = unidad / 160934
    default:
        resultado = 0.0
    }

    if unidadES == "m" {
        resultado = resultado / 100

    } else if unidadES == "km" {
        resultado = resultado / 100000
    }

    return resultado

}

struct ContentView: View {
    
    @State private var selectedES = UnidadesES.cm
    @State private var selectedUK = UnidadesUK.pies
    @State private var unidad = 51.0
    @State private var isEditing = false
    
    var body: some View {
        
        VStack {

            Picker("UnidadesES", selection: $selectedES) {
                Text("cm").tag(UnidadesES.cm)
                Text("m").tag(UnidadesES.m)
                Text("km").tag(UnidadesES.km)
            } //fin picker unidadesES
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 30)
                .padding(.vertical, 20)

            
            Slider(
                value: $unidad,
                in: 1...100,
                onEditingChanged:{
                    editing in isEditing = editing
                }, //fin onEditing
                minimumValueLabel: Text("0"),
                maximumValueLabel: Text("100")
            ) {
                Text("unidades")
            }

                .padding(.horizontal, 40)
            Text(String(format: "%.2d", unidad))
                .foregroundColor(isEditing ? .red : .blue)
                
                

            Picker("UnidadesUK", selection: $selectedUK) {
                Text("pies").tag(UnidadesUK.pies)
                Text("yardas").tag(UnidadesUK.yardas)
                Text("millas").tag(UnidadesUK.millas)

            }//fin picker unidadesUK
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 30)
                .padding(.vertical, 20)

        }//fin VStack
        
      
        
        
        CirculoTexto(unES: Binding<UnidadesES.RawValue>,
                     unUK: Binding<UnidadesUK.RawValue>,
                     cantidad: Binding<Double>,
                     isEdit: Binding<Bool>)
        
           
            .padding(.vertical, 80)
            
   
       

    }//fin del body


}// fin content view

struct CirculoTexto: View{
    
    @Binding var unES: UnidadesES.RawValue
    @Binding var unUK: UnidadesUK.RawValue
    @Binding var cantidad: Double
    @Binding var isEdit: Bool
    
    var body: some View{
    //llamar a la funcion, pasar los 3 datos para el calculo
   
        let resul: Double = calculo(unidadES: unES.rawValue,
                        unidad: Double(cantidad),
                        unidadUK: unUK.rawValue)

        ZStack {
           
            Circle()
                .foregroundColor(.purple)
                .frame(width: 250, height: 250)
                
            VStack {
                Text("\(unidad) \(unES.rawValue) son")
                Text("\(resul)")
                    .font(.system(size: 54))
                Text("\(unUK.rawValue)")
            }
                .foregroundColor(.white)


        } //fin ZStack
        
    }//fin circulotexto
}
    





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
