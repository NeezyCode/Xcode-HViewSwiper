//
//  ContentView.swift
//  HScroll
//
//  Created by Enzo Moyon on 25/07/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HViewSwiper(pageArray: [AnyView(
            NavigationView {
                VStack {
                    Rectangle()
                        .foregroundColor(.red)
                        .ignoresSafeArea()
                    .navigationBarTitle(Text("A First Page"), displayMode: .inline)
                }
                .background(Color.red)
            }
        ), AnyView(
            NavigationView {
                VStack {
                    Rectangle()
                        .foregroundColor(.yellow)
                        .ignoresSafeArea()
                    .navigationBarTitle(Text("A Second Page"), displayMode: .inline)
                }
                .background(Color.orange)
            }
        ), AnyView(
            NavigationView {
                VStack {
                    Rectangle()
                        .foregroundColor(.green)
                        .ignoresSafeArea()
                    .navigationBarTitle(Text("A Third Page"), displayMode: .inline)
                }
                .background(Color.yellow)
            }
                
        ), AnyView(
            NavigationView {
                VStack {
                    Rectangle()
                        .foregroundColor(.blue)
                        .ignoresSafeArea()
                    .navigationBarTitle(Text("A Fourth Page"), displayMode: .inline)
                }
                .background(Color.green)
            }
        )], indicatorColor: .black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
