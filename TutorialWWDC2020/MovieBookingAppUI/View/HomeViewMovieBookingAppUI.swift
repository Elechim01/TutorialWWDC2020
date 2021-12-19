//
//  HomeViewMovieBookingAppUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 19/12/21.
//

import SwiftUI

struct HomeViewMovieBookingAppUI: View {
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 15, pinnedViews: [.sectionFooters]) {
                
                Section {
                    HStack{
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "bookmark")
                                .font(.title2)
                        }

                        
                    }
                    .overlay(
                        
                        Text("Detail Movie")
                            .font(.title2)
                            .fontWeight(.semibold)
                    )
                    .padding()
                    .foregroundColor(.white)
                    
                    ZStack{
                        
    //                    Bottom Shadow...
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.2))
                            .padding(.horizontal)
                            .offset(y:12)
                        
                        
                        Image("p1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(15)
                    }
                    .frame(width: getRectMovieBookingAppUI().width / 1.5, height: getRectMovieBookingAppUI().height / 2)
                    .padding(.top,20)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
    //                    For JOKE 3020...
                            Text("No Time To Die 3020")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                        Text("Directory: Cary Joji Fukunaga | 4")
                            .foregroundColor(.white)
                            .overlay(
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .offset(x: 35, y: -2)
                                
                                ,alignment: .trailing
                            )
                        
    //                    Generes....
                        
    //                    Creating Simple Chips View...
    //                    Adaptive will place how many views can possible into a row given minimum space...
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], alignment: .leading) {
                            
                            ForEach(genreMovieBookingAppUI,id:\.self){ genereText in
                                
                                Text(genereText)
                                    .font(.caption)
                                    .padding(.vertical,10)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .background(Color.white.opacity(0.08))
                                    .clipShape(Capsule())
                            }
                        }
                            .padding(.top,20)
                        
                        Text("Synopsis")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                        
                        Text(synopsisMovieBookingAppUI)
                            .foregroundColor(.white)
                        
                    }
                    .padding(.top,55)
                    .padding(.horizontal)
                    .padding(.leading,10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                } footer: {
                    FooterViewMovieBookingAppUI()
                }

            }
        }
        .background(Color.black.ignoresSafeArea())
    }
}

struct HomeViewMovieBookingAppUI_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewMovieBookingAppUI()
    }
}

// Footer Button...

struct FooterViewMovieBookingAppUI: View {
    
    var body: some View{
        NavigationLink {
            BookingViewMovieBookingAppUI()
        } label: {
            
            Text("Buy Ticket")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.vertical)
                .frame(width: getRectMovieBookingAppUI().width / 2)
                .background(Color.blue)
                .cornerRadius(15)
        }
        .shadow(color: Color.white.opacity(0.15), radius: 5, x: 5, y: 5)
        .shadow(color: Color.white.opacity(0.15), radius: 5, x: -5, y: -5)

    }
}


// extending view to get RECT...

extension View{
    
    func getRectMovieBookingAppUI() -> CGRect {
        
        return UIScreen.main.bounds
    }
}
