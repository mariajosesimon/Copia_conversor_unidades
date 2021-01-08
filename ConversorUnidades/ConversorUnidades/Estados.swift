//
//  Estados.swift
//  ConversorUnidades
//
//  Created by  on 18/12/2020.
//

import SwiftUI

class Estados: ObservableObject{
    @State private var selectedES = UnidadesES.cm
    @State private var selectedUK = UnidadesUK.pies
    @State private var unidad = 50.0
    @State private var isEditing = false
}
