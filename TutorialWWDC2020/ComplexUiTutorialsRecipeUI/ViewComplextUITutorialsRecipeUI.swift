//
//  ViewComplextUITutorialsRecipeUI.swift
//  TutorialWWDC2020
//
//  Created by Michele Manniello on 28/10/21.
//

import SwiftUI

struct ViewComplextUITutorialsRecipeUI: View {
    
    @State var search = ""
    @State var selectedTab = ""
    
    var body: some View {
        VStack{
            
            HStack{
                Button {
                    
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.black)
                }
                
                Spacer(minLength: 0)
                
                Button {
                    
                } label: {
                    Image("p1")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                }


            }
            .padding([.horizontal,.bottom])
            .padding(.top,10)
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField("Search Recipe", text: $search)
                        }
                        .padding()
                        .background(Color.black.opacity(0.06))
                        .cornerRadius(15)
                        
                        Button {
                        
                            
                        } label: {
                            Image("menu")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 30, height: 30)
                                .padding()
                                .background(Color("yellowRecipe").opacity(0.2))
                                .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal)
                    
                    HStack{
                        
                        Text("Top Recipes")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer(minLength: 0)
                    }
                    .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15){
                            ForEach(recipes,id: \.title){ recipe in
                                RecipeCard(recipe: recipe)
                            }
                        }
                        .padding(.horizontal)
                    }

                }
            }
            
            ScrollView(.horizontal,showsIndicators: false){
                HStack(spacing: 20){
                    ForEach(categories,id: \.self){ title in
                        CategoryCards(title: title)
                    }
                }
                .padding()
            }
            
            CustomTabBarRecipeApp(selectedTab: $selectedTab)
            
            Spacer(minLength: 0)
        }
        .background(Color.black.opacity(0.05).ignoresSafeArea(.all,edges: .all))
        .ignoresSafeArea(.all,edges: .bottom)
    }
}

struct ViewComplextUITutorialsRecipeUI_Previews: PreviewProvider {
    static var previews: some View {
        ViewComplextUITutorialsRecipeUI()
    }
}

struct RecipeCard: View {
    
    var recipe : Recipe
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 12) {
            HStack{
                
                Spacer(minLength: 0)
                
                Image(recipe.image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            .padding(.bottom)
            
            Text(recipe.title)
                .font(.title)
                .foregroundColor(.black)
                .lineLimit(3)
       
            
            HStack(spacing: 12){
                Label {
                    Text(recipe.rating)
                        .font(.caption)
                        .foregroundColor(.gray)
                } icon: {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(Color("orange"))
                }
                .padding(.vertical,5)
                .padding(.horizontal,10)
                .background(recipe.color.opacity(0.4))
                .cornerRadius(5)
                
                Text(recipe.type)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.vertical,5)
                    .padding(.horizontal,10)
                    .background(recipe.color.opacity(0.4))
                    .cornerRadius(5)
            }
            
            Text(recipe.detail)
                .foregroundColor(.gray)
            
            HStack(spacing: 0){
                ForEach(1...4,id: \.self){ i in
                    Image("g\(i)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .clipShape(Circle())
//                    Overlay Effect..
                        .offset(x: -CGFloat(i) * 8)
                }
                Text("25 + Likes")
                    .font(.caption)
                    .foregroundColor(.gray)
//                Moving Text And Giving Sapce...
                    .padding(.leading, -(4) * 6)
            }
            .padding(.bottom)
            
            HStack{
                
                Spacer(minLength: 0)
                
                Button {
                    
                } label: {
                    Label {
                        Text("Save")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                    } icon: {
                        Image(systemName: "suit.heart.fill")
                            .font(.body)
                            .foregroundColor(Color("orangeRecipe"))
                    }
                    .padding(.vertical,8)
                    .padding(.horizontal,10)
                    .background(Color.white)
                    .clipShape(Capsule())

                }

            }
          
        }
        .padding(.horizontal)
//        Max Width....
        .frame(width: UIScreen.main.bounds.width / 2)
        .background(
            recipe.color.opacity(0.2)
                .cornerRadius(25)
                .padding(.top,55)
                .padding(.bottom,15)
        )
    }
}

struct CategoryCards: View {
    var title : String
    var body: some View{
        
        VStack(spacing: 20){
            Image(title)
                .padding()
                .background(Color.white)
                .clipShape(Circle())
 
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(Color("orangeRecipe"))
        }
        .padding(.vertical)
        .padding(.horizontal,10)
        .background(Color("yellowRecipe").opacity(0.2))
        .clipShape(Capsule())
    }
}

struct CustomTabBarRecipeApp: View {
    
    @Binding var selectedTab : String
    
    var body: some View{
        HStack{
            
            TabButtonRecipeApp(title: "Home",selectedTab: $selectedTab)
            
            Spacer(minLength: 0)
            
            Button {
                
            } label: {
                Image(systemName: "plus")
                    .renderingMode(.original)
                    .padding(.vertical)
                    .padding(.horizontal,25)
                    .background(Color("orangeRecipe"))
                    .cornerRadius(15)
            }
            Spacer(minLength: 0)
            TabButtonRecipeApp(title: "Saved",selectedTab: $selectedTab)
        }
        .padding(.top)
        .padding(.horizontal,22)
        .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 :UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        .background(Color.white)
        .clipShape(CustomCorners(corners: [.topLeft,.topRight], size: 55))
        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: -5)
    }
}

struct TabButtonRecipeApp: View {
    
    var title : String
    @Binding var selectedTab: String
    
    var body: some View{
        Button {
            selectedTab = title
        } label: {
            HStack(spacing: 10){
                Image(title)
                    .renderingMode(.template)
                
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(selectedTab == title ? Color("yellowRecipe") : .gray)
            .padding(.vertical,10)
            .padding(.horizontal,15)
            .background(Color("yellowRecipe").opacity(selectedTab == title ? 0.15 : 0))
            .clipShape(Capsule())
        }

    }
}

struct CustomCornerRecipeApp :Shape {
    
    var corners : UIRectCorner
    var size : CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: size, height: size))
        return Path(path.cgPath)
    }
}
