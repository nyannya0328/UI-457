//
//  onBoading.swift
//  UI-313 (iOS)
//
//  Created by nyannyan0328 on 2021/09/21.
//

import SwiftUI

struct onBoading: View {
    @State var offset : CGFloat = 0
    @State var currentIndex  : Int = 0
    var body: some View {
        OffsetPageTabView(offset: $offset) {
            
            HStack(spacing:0){
                
                ForEach(bodingscrrens){screen in
                    
                    
                    VStack(spacing:15){
                        
                        
                        Image(screen.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)//648
                            .frame(width: getScreenBounds().width - 100, height: getScreenBounds().width - 100)
                            .scaleEffect(getScreenBounds().height < 750 ? 0.9 : 1)
                            .offset(y:getScreenBounds().height < 750 ? -100 :  -120)
                        
                        
                        VStack(alignment: .leading, spacing: 16) {
                            
                            Text(screen.title)
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                                .padding(.top,20)
                            
                            Text(screen.decription)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .offset(y: -70)
                        
                        
                    }
                    .padding()
                    .frame(width: getScreenBounds().width)
                    .frame(maxHeight: .infinity)
                   
                    
                }
                
                
            }
          
            
        }
        .background(
        
        
        RoundedRectangle(cornerRadius: 50)
            .fill(.white)
            .frame(width: getScreenBounds().width - 100, height: getScreenBounds().width - 100)
            .scaleEffect(2)
            .rotationEffect(.init(degrees: 25))
            .rotationEffect(.init(degrees: getRotation()))
            .offset(y: -getScreenBounds().width + 20)
        )
        .background(Color("screen\(getIndex() + 1)")
                        .animation(.easeInOut, value: getIndex())
                       
                        
        
        
        )
        .ignoresSafeArea(.container, edges: .all)//from ios 15
        .overlay(
        
        
            VStack{
                
                
                HStack(spacing:20){
                    
                    
                    
                    Button {
                        
                    } label: {
                        
                        Text("Login With Image")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.vertical,15)
                            .frame(maxWidth: .infinity)
                            .background(.white,in:RoundedRectangle(cornerRadius: 15))
                    }
                    .spotlight(enabled: currentIndex == 1, text: "Login")
                    
                    Button {
                        
                    } label: {
                        
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.vertical,15)
                            .frame(maxWidth: .infinity)
                            .background(.white,in:RoundedRectangle(cornerRadius: 15))
                    }
                    .spotlight(enabled: currentIndex == 2, text: "Sign up")

                }
                
                HStack{
                    
                    
                    Button {
                        
                    } label: {
                        
                        Text("Skip")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    
                    .spotlight(enabled: currentIndex == 3, text: "Skip")
                    
                    
                    HStack(spacing:8){
                        
                        ForEach(bodingscrrens.indices,id:\.self){index in
                            
                            
                            Circle()
                                .fill(.white)
                                .opacity(index == getIndex() ? 1 : 0.4)
                                .frame(width: 8, height: 8)
                                .scaleEffect(index == getIndex() ? 2 : 1)
                                .animation(.easeInOut, value: getIndex())
                                
                            
                            
                        }
                        
                    }
                    .spotlight(enabled: currentIndex == 4, text: "Indicators")
                    .frame(maxWidth: .infinity)
                    
                    
                    Button {
                        
                        offset = min(offset + getScreenBounds().width, getScreenBounds().width * 3)
                       
                    
                        

                        
                    } label: {
                        
                        Text("Next")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .spotlight(enabled: currentIndex == 5, text: "Next")

                    
                }
                .padding(.top,20)
                
                
            }
                .padding()
            
            
            ,alignment: .bottom
        
        
        )
        .onTapGesture {
            currentIndex += 1
        }
      
    }
    
    func getRotation()->Double{
        
        let progress = offset / (getScreenBounds().width * 4)
        
        let rotation = Double(progress) * 360//Doing one full rotation
        
        return rotation
        
        
    }
    func getIndex() -> Int{
        
        
        let progress = (offset / getScreenBounds().width).rounded()
        
        return Int(progress)
    }
}

struct onBoading_Previews: PreviewProvider {
    static var previews: some View {
        onBoading()
    }
}

extension View{
    
    func getScreenBounds()->CGRect{
        
        
        return UIScreen.main.bounds
    }
}
