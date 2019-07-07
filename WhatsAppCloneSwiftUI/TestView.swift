//
//  TestView.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Atil Samancioglu on 7.07.2019.
//  Copyright © 2019 Atil Samancioglu. All rights reserved.
//

import SwiftUI

struct TestView : View {
    
    @State var x = true
    
    var body: some View {
        
        NavigationView{
        if x {
            
            VStack{
            Text("Hello SwiftUI!")
                Button(action: {
                    self.x = false
                }) {
                    Text("change screen")
                }
            }
            

        } else {
            
            Text("Hello world")
            
            }
        }
        
    }
}

#if DEBUG
struct TestView_Previews : PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
#endif
