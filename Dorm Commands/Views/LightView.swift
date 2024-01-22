//
//  LightView.swift
//  Dorm Commands
//
//  Created by Gavin Payne on 1/17/24.
//

import SwiftUI

// Assuming you have a LightModel struct defined elsewhere
struct LightModel: Identifiable {
    let id: UUID = UUID()
    let name: String
    let isOn: Bool

    static var dummyData: [LightModel] = [
            LightModel(name: "Bedroom", isOn: true),
            LightModel(name: "Kitchen", isOn: false),
            LightModel(name: "Living", isOn: true),
            LightModel(name: "Desk", isOn: false),
            LightModel(name: "Bathroom", isOn: true),
            LightModel(name: "Hallway", isOn: false),
            LightModel(name: "Dining", isOn: true),
            LightModel(name: "Office", isOn: false),
            LightModel(name: "Reading", isOn: true),
            LightModel(name: "Nightstand", isOn: false),
            LightModel(name: "Accent", isOn: true),
            LightModel(name: "Closet", isOn: false),
            LightModel(name: "Plant", isOn: true),
            LightModel(name: "Mirror", isOn: false),
            LightModel(name: "Vanity", isOn: true),
            LightModel(name: "Shower", isOn: false),
            LightModel(name: "Entryway", isOn: true),
            LightModel(name: "Staircase", isOn: false),
            LightModel(name: "Exterior", isOn: true),
            LightModel(name: "Backyard", isOn: false),
        ]
}

struct LightDisplayView: View {
    var lightModel: LightModel

    var body: some View {
        VStack {
            Image(systemName: "lightbulb")  // Or use a custom image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .foregroundColor(lightModel.isOn ? .yellow : .gray)
                .padding()
            Text(lightModel.name)
                .font(.title2)
                .bold()
                .minimumScaleFactor(0.5)  // Allow shrinking down to 50%
                .lineLimit(1)             // Limit text to 2 lines
                .multilineTextAlignment(.center)  // Center multi-line text
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}


struct LightGridView: View {
    var lightModels: [LightModel]

    let itemWidth: CGFloat = 130  // Adjust this value as needed

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.fixed(itemWidth)), count: 3), spacing: 10) {
            ForEach(lightModels) { lightModel in
                LightDisplayView(lightModel: lightModel)
                    .frame(width: 90, height: 90, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
            }
        }
    }
}

struct LightView: View {
    var body: some View {
        ScrollView{
            LightGridView(lightModels: LightModel.dummyData)
        }
    }
}



#Preview {
    LightView()
}
