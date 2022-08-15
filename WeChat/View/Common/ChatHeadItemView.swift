//
//  ChatHeadItemView.swift
//  WeChat
//
//  Created by kira on 19/07/2022.
//

import SwiftUI
import CachedAsyncImage

struct ChatHeadItemView: View {
    var shouldShowIndicator = true
    var isActive: Bool
    var size: Double = 50
    var avatar = "https://i.pravatar.cc/150?u=a042581f4e29026704d"
    
    var body: some View {
        ZStack {
            CachedAsyncImage(url: URL(string: avatar)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: size, height: size)
            .clipShape(Circle())
            
            Group {
                if shouldShowIndicator {
                    if isActive {
                        ActiveIndicatorView(size: size)
                    } else {
                        LastSeenView()
                    }
                }
            }
            .offset(x: size / 2.5, y: size / 2.5)
        }
    }
}

struct ChatHeadItemView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ChatHeadItemView(isActive: true, size: 100)
            ChatHeadItemView(isActive: false)
        }
    }
}

struct ActiveIndicatorView: View {
    var size: Double
    
    var body: some View {
        ZStack {
            Color.white
                .frame(width: size * 0.35)
            
            Color.green
                .frame(width: size * 0.2)
                .clipShape(Circle())
        }
        .clipShape(Circle())
    }
}

struct LastSeenView: View {
    var body: some View {
        Text("15 min")
            .font(.system(size: 9))
            .foregroundColor(.colorPrimary)
            .fontWeight(.medium)
            .padding(2)
            .background(Color.colorGray2)
    }
}
