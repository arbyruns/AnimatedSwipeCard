//
//  CardRowView.swift
//  SwipeAnimation
//
//  Created by robevans on 3/29/22.
//

import SwiftUI

/// Main card view

@available(iOS 14.0, *)

public struct CardRowView: View {


    /// Modifiers accepted
    /// - Parameters:
    ///   - animationShakeAmount: higher the number the more of an angle of the card. Defaults at 5.0
    ///   - swipeScale: Scales the card to 0.8 as the default
    ///   - titleText: Main text
    ///   - subText: subtext
    ///   - color: asset color as a string
    ///   - imageName: image name as a string
    ///   - showCardAlert: State to show alert
    ///   - bindingID: pass State to store ID
    ///   - bindingText: pass State to store text. This maybe the same as titleText
    ///   - bindingSubText: pass State to store text. This maybe the same as subText
    public init(animationShakeAmount: Double = 5.0,
                swipeScale: Double = 0.8,
                titleText: String,
                subText: String,
                cardID: String = "",
                color: String = "",
                imageName: String = "",
                showCardAlert: Binding<Bool>,
                bindingID: Binding<String>?,
                bindingText: Binding<String>?,
                bindingSubText: Binding<String>?
    ) {
        self.animationShakeAmount = animationShakeAmount
        self.swipeScale = swipeScale
        self.titleText = titleText
        self.subText = subText
        self.cardID = cardID
        self.color = color
        self.imageName = imageName
        self._showCardAlert = showCardAlert
        self._bindingID = bindingID ?? .constant("")
        self._bindingText = bindingText ?? .constant("")
        self._bindingSubText = bindingSubText ?? .constant("")
    }

    var titleText: String = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium"
    var subText: String = "Subtext"
    var animationShakeAmount = 5.0 // higher the number the more of an angle of the card
    var swipeScale = 0.8 // default is 0.8 to scale inward
    var color = "StatusCard"
    var imageName = "rocket_green"
    var cardID = ""

    @State var offset = CGSize.zero
    @State var rotate = 00.0
    @State var animateReminder = false
    @State var animateShake1 = false
    @State var animateShake2 = false

    @Binding var showCardAlert: Bool
    @Binding var bindingID: String
    @Binding var bindingText: String
    @Binding var bindingSubText: String


    public var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 13)
                .fill(Color(color))
                .padding(.horizontal)
                .shadow(radius: 2)
                .overlay(
                    VStack {
                        HStack {
                            if !imageName.isEmpty{
                                Image(imageName)
                                    .resizable()
                                    .frame(width: 50, height: 50, alignment: .center)
                            }
                            Text(titleText)
                                .fontWeight(.semibold)
                        }
                        .padding(.horizontal)
                        HStack {
                            Text(subText)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top)
                    }
                )
                .offset(x: offset.width)
                .scaleEffect(animateReminder ? swipeScale : 1.0)
                .rotationEffect(.degrees(animateShake1 ? animationShakeAmount : 0))
                .rotationEffect(.degrees(animateShake2 ? -animationShakeAmount : 0))
                .rotation3DEffect(.degrees(rotate / 2), axis: (x: 1, y: 0, z: 0))
                .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
                    .onChanged { gesture in
                        if gesture.translation.width < 0 {
                            withAnimation {
                                offset = gesture.translation
                                while rotate < 90.0 {
                                    rotate += 10.0
                                }
                            }
                        } else if gesture.translation.width > 0 {
                            withAnimation {
                                offset = gesture.translation
                                while rotate < 90.0 {
                                    rotate += 0.06
                                }
                            }
                        }
                    }.onEnded{ value in
                        print(value.translation.width)
                        if value.translation.width > 150 {
                            print(value.translation.width)
                            withAnimation(.spring()) {
                                offset = .zero
                                rotate = 1.0
                                playHaptic(style: "medium")
                                showCardAlert = true
                                animateReminder = true
                                animateShake1 = true
                                bindingID = cardID
                                bindingText = titleText
                                bindingSubText = subText
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    withAnimation {
                                        animateShake1 = false
                                        animateShake2 = true
                                    }
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                    withAnimation {
                                        animateShake2 = false
                                        animateReminder = false
                                    }
                                }
                            }
                        } else if value.translation.width < 50 {
                            print(value.translation.width)
                            withAnimation(.spring()) {
                                offset = .zero
                                rotate = 1.0
                                playHaptic(style: "medium")
                                showCardAlert = true
                                animateReminder = true
                                animateShake2 = true
                                bindingID = cardID
                                bindingText = titleText
                                bindingSubText = subText
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    withAnimation {
                                        animateShake2 = false
                                        animateShake1 = true
                                    }
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                    withAnimation {
                                        animateShake1 = false
                                        animateReminder = false
                                    }
                                }
                            }
                        }  else {
                            withAnimation(.spring()) {
                                offset = .zero
                                rotate = 1.0
                            }
                        }
                    })
        }
    }
}

@available(iOS 14.0, *)
struct CardRowView_Previews: PreviewProvider {
    static var previews: some View {
        CardRowView(animationShakeAmount: 5.0, titleText: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium", subText: "subtext", color: "StatusCard", showCardAlert: .constant(false), bindingID: .constant("42"), bindingText: .constant(""), bindingSubText: .constant(""))
    }
}
