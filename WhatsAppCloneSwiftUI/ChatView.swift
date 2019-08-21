//
//  ChatView.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Atil Samancioglu on 7.07.2019.
//  Copyright © 2019 Atil Samancioglu. All rights reserved.
//

import SwiftUI
import Firebase

struct ChatView : View {
    
    let db = Firestore.firestore()
    var userToChat : UserModel
    @State var messageToSend = ""
    
    @ObservedObject var chatStore = ChatStore()
    
    var body: some View {
        VStack{
            
            ScrollView{
                
                ForEach(chatStore.chatArray) { chats in
                     ChatRow(chatMessage: chats, userToChatFromChatView: self.userToChat)
                    
                }

                
            }
            
            
            HStack{
                TextField("Message here ...",text: $messageToSend).frame(minHeight: 30).padding()
                //TextField($messageToSend, placeholder: Text("Message to send..."))
                Button(action: sendMessageToFirebase) {
                    Text("Send")
                }.frame(minHeight:50).padding()
                
            }
            
        }
    }
    
    func sendMessageToFirebase() {
        var ref: DocumentReference? = nil
        
        let myChatDictionary : [String : Any] = ["chatUserFrom" : Auth.auth().currentUser!.uid,"chatUserTo":userToChat.uidFromFirebase,"date":generateDate(),"message":self.messageToSend]
        
        ref = self.db.collection("Chats").addDocument(data: myChatDictionary, completion: { (error) in
            if error != nil {
                
            } else {
                self.messageToSend = ""
            }
        })
    }
    
    func generateDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return (formatter.string(from: Date()) as NSString) as String
    }
}

#if DEBUG
struct ChatView_Previews : PreviewProvider {
    static var previews: some View {
        ChatView(userToChat: UserModel(id: 0, name: "James", uidFromFirebase: "l343423l"))
    }
}
#endif
