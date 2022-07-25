//
//  ContentView.swift
//  HScroll
//
//  Created by Enzo Moyon on 24/07/2022.
//

import SwiftUI

struct SwipeModifier: ViewModifier {
    enum Directions: Int {
        case up, down, left, right
    }

    enum Trigger {
        case onChanged, onEnded
    }

    var trigger: Trigger
    var handler: ((Directions) -> Void)?

    func body(content: Content) -> some View {
        content.gesture(
            DragGesture(
                minimumDistance: 24,
                coordinateSpace: .local
            )
            .onChanged {
                if trigger == .onChanged {
                    handle($0)
                }
            }.onEnded {
                if trigger == .onEnded {
                    handle($0)
                }
            }
        )
    }

    private func handle(_ value: _ChangedGesture<DragGesture>.Value) {
        let hDelta = value.translation.width
        let vDelta = value.translation.height

        if abs(hDelta) > abs(vDelta) {
            handler?(hDelta < 0 ? .left : .right)
        } else {
            handler?(vDelta < 0 ? .up : .down)
        }
    }
}

extension View {
    func onSwiped(
        trigger: SwipeModifier.Trigger = .onChanged,
        action: @escaping (SwipeModifier.Directions) -> Void
    ) -> some View {
        let swipeModifier = SwipeModifier(trigger: trigger) {
            action($0)
        }
        return self.modifier(swipeModifier)
    }
    func onSwiped(
        _ direction: SwipeModifier.Directions,
        trigger: SwipeModifier.Trigger = .onChanged,
        action: @escaping () -> Void
    ) -> some View {
        let swipeModifier = SwipeModifier(trigger: trigger) {
            if direction == $0 {
                action()
            }
        }
        return self.modifier(swipeModifier)
    }
}

struct Pages: View {
    @Binding var currentPage: Int
    var pageArray: [AnyView]

    var body: AnyView {
        return pageArray[currentPage]
    }
}

struct ContentView: View {
    
    @State var currentPage: Int = 0
    @State var pageArray: [AnyView]

    var body: some View {
        
        var PageIndicator: some View {
            HStack {
                
                ForEach(0..<pageArray.count, id:\.self) { index in
                    if index == currentPage {
                        Circle()
                            .frame(width: 15,height: 15)
                            .foregroundColor(.black)
                    } else {
                        Circle()
                            .frame(width: 10,height: 10)
                            .foregroundColor(.secondary)
                    }
                }
                
            }
            .padding()
        }

        return Pages(currentPage: self.$currentPage, pageArray: pageArray)
            .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                .onEnded { value in
                    let direction = atan2(value.translation.width, value.translation.height)
                    switch direction {
                    case (Double.pi/4..<Double.pi*3/4): do {
                        // swipe right
                        if currentPage > 0 {
                            currentPage -= 1
                        }
                    }
                    case (-Double.pi*3/4..<(-Double.pi/4)): do {
                        // swipe left
                        if currentPage < pageArray.count-1 {
                            currentPage += 1
                        }
                    }
                    default:
                        print("")
                    }
                }
            )
            .overlay(PageIndicator, alignment: .bottom)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(pageArray: [])
    }
}
