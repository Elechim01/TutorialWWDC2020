//
//  ViewLoading3DObjects.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 06/10/21.
//

import SwiftUI
import SceneKit

struct ViewLoading3DObjects: View {
    @State var  models = [
        Model(id: 0, name: "Earth", modelName: "Earth.usdz", details: "meedcmdlksmcklsmdcaòsmdòacsl"),
        Model(id: 1, name: "Mars", modelName: "Mars.usdz", details: "meedcmdlksmcklsmdcaòsmdòacsl"),
        Model(id: 2, name: "Jupiter", modelName: "Jupiter.usdz", details: "meedcmdlksmcklsmdcaòsmdòacsl"),
        Model(id: 3, name: "Pluto", modelName: "Pluto.usdz", details: "meedcmdlksmcklsmdcaòsmdòacsl"),
        Model(id: 4, name: "Venus", modelName: "Venus.usdz", details: "meedcmdlksmcklsmdcaòsmdòacsl"),
    ]
    @State var index = 0
    var body: some View {
        VStack{
//            Going to use Scene Kit..
//            default is first object ie: Earth
//            Scene View Has a default Camera view..
//            if you need custom menas add three...
            
            SceneView(scene: SCNScene(named: models[index].modelName),options: [.autoenablesDefaultLighting,.allowsCameraControl])
//            For user action...
//            setting custom frame...
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
            ZStack{
                HStack{
//                    Forward and backward buttons..
                    Button {
                        withAnimation {
                            if index > 0{
                                index -= 1
                            }
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 35, weight: .bold))
                            .opacity(index == 0 ? 0.3 : 1)
                    }
                    .disabled(index == 0 ? true : false)
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        withAnimation {
                            if index < models.count{
                                index += 1
                            }
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 35, weight: .bold))
                            .opacity(index == models.count - 1 ? 0.3 : 1)
                    }
                    .disabled(index == models.count - 1 ? true : false)
                }
                
                Text(models[index].name)
                    .font(.system(size: 45, weight: .bold))
            }
            .foregroundColor(.black)
            .padding(.horizontal)
            .padding(.vertical,30)
//            Details...
            VStack(alignment: .leading, spacing: 15) {
                Text("About")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(models[index].details)
            }
            .padding(.horizontal)
            
            Spacer(minLength: 0)
        }
    }
}

struct ViewLoading3DObjects_Previews: PreviewProvider {
    static var previews: some View {
        ViewLoading3DObjects()
    }
}
//Data Model...
struct Model : Identifiable {
    var id: Int
    var name: String
    var modelName: String
    var details : String
}
// Sample Data...


