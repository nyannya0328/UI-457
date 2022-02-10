//
//  OffsetPageTabView.swift
//  UI-313 (iOS)
//
//  Created by nyannyan0328 on 2021/09/21.
//

import SwiftUI

struct OffsetPageTabView<Content : View>: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return OffsetPageTabView.Coordinator.init(parent: self)
    }
    
    var content : Content
    @Binding var offset : CGFloat
    
    init(offset : Binding<CGFloat>,@ViewBuilder content : @escaping()->Content) {
        self._offset = offset
        self.content = content()
        
    }
    
    let scroll = UIScrollView()
    

    
    
    func makeUIView(context: Context) -> UIScrollView {
        
      
        setUp(scroll: scroll)
        scroll.delegate = context.coordinator
        
        
        return scroll
        
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
        
        let currentOffset = uiView.contentOffset.x
        
        if offset != currentOffset{
            uiView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)//x -> Binding offset set
        }
        
    }
    func setUp(scroll : UIScrollView){
        
        scroll.isPagingEnabled = true
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        
        let hostView = UIHostingController(rootView: content)
        
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        hostView.view.backgroundColor = .clear//hostview = content
        
        let contains = [
        
            hostView.view.topAnchor.constraint(equalTo: scroll.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            hostView.view.heightAnchor.constraint(equalTo: scroll.heightAnchor),
        
            
        
        ]
        scroll.addConstraints(contains)
        scroll.addSubview(hostView.view)
    
        
        
    }
    
    class Coordinator : NSObject,UIScrollViewDelegate{
        
        var parent : OffsetPageTabView
        
        init(parent : OffsetPageTabView) {
            self.parent = parent
        }
        
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
            let offset = scrollView.contentOffset.x
            parent.offset = offset
        }
        
        
    }
}

struct OffsetPageTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

