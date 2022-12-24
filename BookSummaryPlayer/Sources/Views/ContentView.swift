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
            audioTextSwitchView
                .safeAreaInset(edge: .bottom) {
                    if let window = UIApplication.shared.windows.first,
                        window.safeAreaInsets.bottom <= 0 {
                        Spacer().frame(height: 12)
                    }
                }
        }
    }
    
    @ViewBuilder
    private var audioTextSwitchView: some View {
        let componentWidth =  0.4 * UIScreen.main.bounds.width
        let componentHeight: Double = 64
//        GeometryReader { geometry in
            HStack {
                Spacer()
                ZStack {
                    Capsule(style: .circular)
                        .frame(width: componentWidth)
                        .foregroundColor(.white)
                    HStack {
                        if isBookTextToggled {
                            Spacer()
                            Circle()
                                .foregroundColor(Color.init(red: 41 / 255, green: 99 / 255, blue: 247 / 255))
                                .frame(height: componentHeight - 10)
                                .padding(.leading, 10)
                        } else {
                            Circle()
                                .foregroundColor(Color.init(red: 41 / 255, green: 99 / 255, blue: 247 / 255))
                                .frame(height: componentHeight - 10)
                                .padding(.leading, 10)
                            Spacer()
                        }
                    }
                    HStack(alignment: .center) {
                        Image("headphones-button-96")
                            .resizable().scaledToFit()
                            .frame(width: 30)
                            .padding()
                        Spacer()
                        Image("multiline-text-button-96")
                            .resizable().scaledToFit()
                            .frame(width: 30)
                            .padding()
                    }
                }
                .frame(width: componentWidth, height: componentHeight)
                .overlay(
                    Capsule(style: .circular)
                        .strokeBorder(Color.init(red: 238 / 255, green: 235 / 255, blue: 233 / 255), lineWidth: 2)
                )
                .onTapGesture {
                    withAnimation {
                        isBookTextToggled.toggle()
                    }
                }
                Spacer()
            }
//        }
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
