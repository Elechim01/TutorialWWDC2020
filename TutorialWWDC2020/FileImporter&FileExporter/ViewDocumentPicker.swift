//
//  ViewDocumentPicker.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 18/10/21.
//

import SwiftUI
import UniformTypeIdentifiers

struct ViewDocumentPicker: View {
    
    @State var fileName = ""
    @State var openfile = false
    @State var saveFile = false
    
    var body: some View {
        VStack(spacing: 25){
            Text(fileName)
                .fontWeight(.bold)
            Button {
                openfile.toggle()
            } label: {
                Text("Open")
            }
            Button {
                saveFile.toggle()
            } label: {
                Text("Save")
            }
            //            any file you want...
            .fileImporter(isPresented: $openfile, allowedContentTypes: [.pdf]) { rest in
                do {
                    
                    let fileUrl = try rest.get()
                    print(fileUrl)
                    
                    //                    getting fileName
                    self.fileName = fileUrl.lastPathComponent
                    
                } catch {
                    print("error reading docs")
                    print(error.localizedDescription)
                }
            }
        }
            //            to save file...
            .fileExporter(isPresented: $saveFile, document: Doc(url: Bundle.main.path(forResource: "audio", ofType: "mp3")!), contentType: .audio) { result in
                do {
                    let fileUlr = try result.get()
                    
                    print(fileUlr)
                    
                } catch{
                    print("cannot save doc")
                    
                    print(error.localizedDescription)
                }
            }
    }
}

struct ViewDocumentPicker_Previews: PreviewProvider {
    static var previews: some View {
        ViewDocumentPicker()
    }
}

struct Doc: FileDocument {
    
    var url : String
    static var readableContentTypes: [UTType]{[.audio]}
    
    init(url : String){
        self.url = url
    }
    
    init(configuration: ReadConfiguration) throws {
//        desetilize the content...
//        we dont need to read contents...
        url = ""
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
//            returning and saving file...
        let file =  try! FileWrapper(url: URL(fileURLWithPath: url), options: .immediate)
        
        return file
    }
}
