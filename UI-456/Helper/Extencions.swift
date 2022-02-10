//
//  Extencions.swift
//  UI-456
//
//  Created by nyannyan0328 on 2022/02/10.
//

import SwiftUI

extension View{
    
    func spotlight(enabled : Bool,text : String = "") -> some View{
        
        
        return self
            .overlay {
                
                if enabled{
                    GeometryReader{proxy in
                        
                        let size = proxy.frame(in: .global)
                        
                        
                        spotLightView(rect: size, text: text) {
                            
                            
                            self
                            
                        }
                        
                    }
                }
                
            }
    }
    
    func getRootView()->UIViewController{
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            
            return .init()
        }
        guard let rootView = screen.windows.first?.rootViewController  else{
            
            return .init()
        }
        
        return rootView
    }
    
    
    
    
}


struct onBoading_Offset_Previews: PreviewProvider {
    static var previews: some View {
        onBoading()
    }
}

struct spotLightView<Content : View> : View{
    
    var content : Content
    var text : String
    var rect : CGRect
    
    
    init(rect : CGRect,text : String,@ViewBuilder content : @escaping()->Content) {
        
        self.content = content()
        self.text = text
        self.rect = rect
        
    }
    
    @State var tag : Int = 1009
    @Environment(\.colorScheme) var scheme
    
    var body: some View{
        
        Rectangle()
            .fill(.clear)
            .onAppear {
                addOveralyView()
            }
            .onDisappear {

                removeOveralay()


            }
        
     
        
   
        
        
    }
    func removeOveralay(){
        
        
        getRootView().view.subviews.forEach { view in
            
            
            if view.tag == self.tag{
                
                view.removeFromSuperview()
            }
        }
        
    }
    
    func addOveralyView(){
        
        let hostiongController = UIHostingController(rootView: overalySwiftUIView())
        
        
        hostiongController.view.frame = getScreenBounds()
        hostiongController.view.backgroundColor = .clear
        
        if self.tag == 1009{
            
            self.tag = generateRandom()
            
        }
        hostiongController.view.tag = self.tag
        
        getRootView().view.subviews.forEach { view in
            if view.tag == self.tag{
                
                return
                
            }
            
            
            getRootView().view.addSubview(hostiongController.view)
        }
        
        
    }
    
    @ViewBuilder
    
    func overalySwiftUIView()->some View{
        
        ZStack{
            
            
            Rectangle()
                .fill(Color("Spotlight").opacity(scheme == .dark ? 0.9 : 0.8))
                .mask({
                    
                    let radius = (rect.height / rect.width) > 0.7 ? rect.width : 6
                    
                    
                    Rectangle()
                        .overlay {
                            
                            content
                                .frame(width: rect.width, height: rect.height)
                           .padding(10)
                         
                           .background(.white,in: RoundedRectangle(cornerRadius: radius))
                       
                           .position()
                           .offset(x: rect.midX, y: rect.midY)
                           
                           .blendMode(.destinationOut)
                        }
                    

                    
                })
            
            if text != ""{
                
                Text(text)
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .position()
                    .offset(x: getScreenBounds().midX, y: rect.maxY > (getScreenBounds().height - 150) ? (rect.minY - 150) : (rect.maxY + 150))
                    .padding()
                    .lineLimit(2)
                
                
                
            }
        }
            .frame(width: getScreenBounds().width,height: getScreenBounds().height)
            .ignoresSafeArea()
        
        
        
            
        
    }
    
    func generateRandom()->Int{
        
        
        let random = Int(UUID().uuid.0)
        let subViews = getRootView().view.subviews
        
        for index in subViews.indices{
            
            
            if subViews[index].tag == random{
                
                return generateRandom()
            }
            
            
        }
        
        return random
        
    }
    
    
    
    
}
