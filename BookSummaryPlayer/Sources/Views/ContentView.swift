//
//  ContentView.swift
//  BookSummaryPlayer
//
//  Created by Nikita Khomitsevych on 21.12.2022.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 254 / 255, green: 248 / 255, blue: 247 / 255)
                .ignoresSafeArea(.all)
            containerView
        }
    }
    
    @State private var isPaused = false
    @State private var audioCurrentPlace: Double = 0
    @State private var isAudioPlaceChanged = false
    @State private var isBookTextToggled = false
    
    @ViewBuilder
    private var containerView: some View {
        ZStack {
            closeButtonContainer
            contentContainer
                .padding()
            audioTextSwitcherContainer
        }
    }
    
    @ViewBuilder
    private var closeButtonContainer: some View {
        VStack {
            HStack {
                closeButton
                    .padding(.leading, 24)
                Spacer()
            }
            .padding(.top, 12)
            Spacer()
        }
    }
    
    @ViewBuilder
    private var contentContainer: some View {
        VStack(spacing: 16) {
            bookCoverImage
            keyPointContentView
                .padding(.top, 8)
            audioSlider
                .padding(.top, 8)
            audioSpeedButton
            playerControlsView
                .padding(.top, 32)
            Spacer()
        }
    }
    
    @ViewBuilder
    private var closeButton: some View {
        Button {
            noop()
        } label: {
            Image("cross-button-48")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
        }
    }
    
    @ViewBuilder
    private var bookCoverImage: some View {
            Image("blood-sweat-and-pixels-bookcover")
                .resizable()
                .scaledToFit()
                .frame(height: UIScreen.main.bounds.height * 0.333)
    }
    
    @ViewBuilder
    private var keyPointContentView: some View {
            VStack(spacing: 12) {
                Text(Constant.keyPointTitleText(1, 7))
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 149 / 255, green: 142 / 255, blue: 140 / 255))
                Text(Constant.firstKeyPointText)
                    .font(.body)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
    }
    
    @ViewBuilder
    private var audioSlider: some View {
        Slider(value: $audioCurrentPlace, in: 0.0...2.16, step: 0.01) {
            Text("Current audio place")
        } minimumValueLabel: {
            Text("00:00")
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundColor(.gray)
        } maximumValueLabel: {
            Text("02:16")
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundColor(.gray)
        } onEditingChanged: { editing in
            isAudioPlaceChanged = editing
        }
    }
    
    @ViewBuilder
    private var audioSpeedButton: some View {
        Button {
            noop()
        } label: {
            Text("Speed 1x")
                .foregroundColor(.black)
                .font(.body)
                .fontWeight(.bold)
                .padding()
        }
        .frame(height: 40)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(red: 240 / 255, green: 236 / 255, blue: 234 / 255))
        )
    }
    
    @ViewBuilder
    private var playerControlsView: some View {
        HStack(alignment: .center, spacing: 28) {
            Button {
                noop()
            } label: {
                Image("playback-prev-button-50")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32)
                    .offset(x: 8)
            }.buttonStyle(SizeScalingButtonStyle())
            Button {
                noop()
            } label: {
                Image("replay-back-5-button-64")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44)
            }.buttonStyle(SizeScalingButtonStyle())
            Button {
                isPaused.toggle()
            } label: {
                !isPaused
                ? Image("play-button-100")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                : Image("pause-button-100")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
            }.buttonStyle(SizeScalingButtonStyle())
            Button {
                noop()
            } label: {
                Image("replay-next-10-button-64")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44)
            }.buttonStyle(SizeScalingButtonStyle())
            Button {
                noop()
            } label: {
                Image("playback-next-button-50")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .offset(x: -8)
            }.buttonStyle(SizeScalingButtonStyle())
        }
    }
    
    @ViewBuilder
    private var audioTextSwitcherContainer: some View {
        VStack {
            Spacer()
            audioTextSwitchContainer
                .safeAreaInset(edge: .bottom) {
                    if let window = UIApplication.shared.windows.first,
                        window.safeAreaInsets.bottom <= 0 {
                        Spacer().frame(height: 12)
                    }
                }
        }
    }
    
    @ViewBuilder
    private var audioTextSwitchContainer: some View {
        HStack {
            Spacer()
            audioTextSwitchView
            Spacer()
        }
    }
    
    @ViewBuilder
    private var audioTextSwitchView: some View {
        let componentWidth = 0.333 * UIScreen.main.bounds.width
        let componentHeight: CGFloat = 72
        let borderColor = Color(red: 238 / 255, green: 235 / 255, blue: 233 / 255)
        let capsuleOverlayBorderWidth: CGFloat = 2
        let capsuleOverlay = Capsule(style: .circular)
            .strokeBorder(borderColor, lineWidth: capsuleOverlayBorderWidth)
            .frame(width: componentWidth)
        
        ZStack {
            Capsule(style: .circular)
                .foregroundColor(.white)
                .frame(width: componentWidth)
            
            HStack {
                let foregroundColor = Color(red: 41 / 255, green: 99 / 255, blue: 247 / 255)
                /// Hardcoded value. Might be calculated somehow. Depends from screen size, as `componentWidth` is dynamic.
                let space: (x: CGFloat, y: CGFloat) = (x: 2, y: 4)
                /// Offset between the circle for selected option and bg capsule, including its border width.
                /// We double each value to cover both `.leading` and `.trailing` sides.
                let offset: (x: CGFloat, y: CGFloat) = (
                    2 * capsuleOverlayBorderWidth + 2 * space.x,
                    2 * capsuleOverlayBorderWidth + 2 * space.y
                )
                /// We guarantee that component `height` is always less than its `width`.
                /// In general case we have to calculate `min(width, height)`,
                /// using `space` and `offset` for according axis to calculate the radius correctly.
                let radius = (componentHeight - offset.y) / 2
                let selectedItemCircleView = Circle()
                    .foregroundColor(foregroundColor)
                    .frame(height: radius * 2)
                    .offset(x: !isBookTextToggled ? offset.x : -offset.x)
                if !isBookTextToggled {
                    selectedItemCircleView
                    Spacer()
                } else {
                    Spacer()
                    selectedItemCircleView
                }
            }
            
            HStack(alignment: .center, spacing: 32) {
                let xPadding: CGFloat = 10
                let headphonesImage = Image("headphones-button-96")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                    .padding(.leading, xPadding)
                let multilineTextImage = Image("multiline-text-button-96")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                    .padding(.trailing, xPadding)
                headphonesImage
                    .foregroundColor(!isBookTextToggled ? .white : .black)
                multilineTextImage
                    .foregroundColor(!isBookTextToggled ? .black : .white)
            }
        }
        .frame(width: componentWidth, height: componentHeight)
        .overlay(capsuleOverlay)
        .onTapGesture {
            withAnimation {
                isBookTextToggled.toggle()
            }
        }
    }
}

private let noop: () -> Void = { print("HANDLE ACTION") }

private enum Constant {
    static let keyPointTitleText: (Int, Int) -> String = { i, max in
        "key point \(i) of \(max)".uppercased()
    }
    static let firstKeyPointText = "The business of video game entertainment is a serious and booming endeavor"
}

struct SizeScalingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.75 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
