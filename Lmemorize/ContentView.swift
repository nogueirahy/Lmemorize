//
//  ContentView.swift
//  Lmemorize
//
//  Created by Leonardo Henrique Nogueira on 12/09/21.
//

import SwiftUI

struct ContentView: View {
    var emojis = [
        "🚗", "🚕", "🚙", "🚌", "🚎",
        "🏎", "🚓", "🚑", "🚒", "🚐",
        "🛻", "🚚", "🚛", "🚜", "🛺",
        "✈️", "⛴", "🚁", "🛵", "🚲",
    ]
    
    @State var emojiCount = 20
    
    func emojiCountPressed(value: Int) {
        let nextState = emojiCount + value
        let limit = nextState > 20 || nextState < 0
        if(limit) {
           return
        }
        emojiCount += value
      }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            FooterView(emojiCountPressed: emojiCountPressed)
            }
        .padding(.horizontal)

    }
}

    
struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true

    var body: some View {
        ZStack {
            let shape =  RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth:4)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
        
    }
}


struct FooterView: View {
    var emojiCountPressed: (Int) -> ()
    var body: some View {
        HStack {
            add
            Spacer()
            remove

        }
        .font(.largeTitle)
        .padding(.horizontal)
    }
    var add : some View {
        Button {
            emojiCountPressed(1)
        } label: {
            Image(systemName: "plus.circle")
        }
    }
    var remove: some View {
        Button {
            emojiCountPressed(-1)
            
        } label: {
            Image(systemName: "minus.circle")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 12")
    }
}
