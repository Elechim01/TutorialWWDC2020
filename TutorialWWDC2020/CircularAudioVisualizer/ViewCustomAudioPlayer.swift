//
//  ViewCustomAudioPlayer.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 18/10/21.
//


import SwiftUI
import AVKit

struct ViewCustomAudioPlayer: View {
    
    @State var audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
//    Timer To Find Current Time of Audio...
    @State var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
//    Details of Song...
    @StateObject var album = album_Data()
    
    @State var animatiedValue: CGFloat = 55
    
    @State var maxWidth = UIScreen.main.bounds.width / 2.2
    
    @State var time : Float = 0
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                HStack{
                    VStack(alignment: .leading, spacing: 8) {
                        Text(album.title)
                            .fontWeight(.semibold)
                        
                        HStack(spacing: 10){
                            Text(album.artist)
                                .font(.caption)
                            Text(album.type)
                                .font(.caption)
                        }
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "suit.heart.fill")
                            .foregroundColor(.red)
                            .frame(width: 45, height: 45)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "bookmark.fill")
                            .foregroundColor(.black)
                            .frame(width: 45, height: 45)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    .padding(.leading,10)
                    

                }
                .padding()
                
                Spacer(minLength: 0)
                
                if album.artwork.count != 0{
                    Image(uiImage: UIImage(data: album.artwork)!)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(15)
                }
                
                ZStack{
                    ZStack{
                        Circle()
                            .fill(Color.white.opacity(0.05))
                        Circle()
                            .fill(Color.white.opacity(0.08))
                            .frame(width: animatiedValue / 2, height: animatiedValue / 2)
                    }
                    .frame(width: animatiedValue, height: animatiedValue)
                    
                    Button {
                        play()
                    } label: {
                        Image(systemName: album.isPlayng ? "pause.fill" : "play.fill")
                            .foregroundColor(.black)
                            .frame(width: 55, height: 55)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }
                .frame(width: maxWidth, height: maxWidth)
                .padding(.top,30)
                
//                Audio Tracking...
                Slider(value: Binding(get: {time}, set: { newValue in
                    time = newValue
//                    updating player..
                    audioPlayer.currentTime = Double(time) * audioPlayer.duration
                    audioPlayer.play() 
                }))
                    .padding()
                
                Spacer(minLength: 0 )
            }
            .onReceive(timer) {  _ in
                if audioPlayer.isPlaying{
                    
                    audioPlayer.updateMeters()
                    album.isPlayng = true
//                    updating slider....
                    time = Float(audioPlayer.currentTime / audioPlayer.duration)
//                   getting animations...
                    startAnmation()
                }else{
                    album.isPlayng = false
                }
            }
            .onAppear(perform: getAudioData)
            .navigationTitle("")
            .navigationBarHidden(true)
            .preferredColorScheme(.dark)
        }
    }
    
    func play(){
        if audioPlayer.isPlaying{
            audioPlayer.pause()
        }else{
            audioPlayer.play()
        }
    }
    
    func getAudioData(){
        
        audioPlayer.isMeteringEnabled = true
        
//        extracting audio data...
        let asset = AVAsset(url: audioPlayer.url!)
        asset.metadata.forEach { meta  in
            switch(meta.commonKey?.rawValue){
            case "artwork": album.artwork = meta.value == nil ? UIImage(named: "any sample pic...")!.pngData()!
                : meta.value as! Data
            case "artist": album.artist = meta.value == nil ? "" : meta.value as! String
            case "type": album.type = meta.value == nil ? "" : meta.value as! String
            case "title": album.title = meta.value == nil ? "" : meta.value as! String
            default : ()
            }
        }
    }
    
    func startAnmation(){
//        getting levels...
        var power  : Float = 0
        for i in 0..<audioPlayer.numberOfChannels {
            power += audioPlayer.averagePower(forChannel: i)
        }
//        calculation to get positive number...
        let value = max(0, power + 55)
//        you can also use if st to find positive number...
        let animated =  CGFloat(value) * (maxWidth / 55)
        
        withAnimation(Animation.linear(duration: 0.01)){
            self.animatiedValue = animated + 55
        }
    }
    
}

struct ViewCustomAudioPlayer_Previews: PreviewProvider {
    static var previews: some View {
        ViewCustomAudioPlayer()
    }
}

let url = Bundle.main.path(forResource: "audio", ofType: "mp3")
class album_Data: ObservableObject {
    @Published var isPlayng = false
    @Published var title = ""
    @Published var artist = ""
    @Published var artwork = Data(count: 0)
    @Published var type = ""
}
