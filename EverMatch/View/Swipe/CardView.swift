//
//  CardView.swift
//  EverMatch
//
//  Created by Kazuki Omori on 2024/08/29.
//

import SwiftUI

struct CardView: View {
    
    @State private var offset: CGSize = .zero
    let user: User
    let adjustIndex: (Bool) -> Void
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // background
            Color.black
            
            // image
            imageLayer
            
            // gradient
            LinearGradient(colors: [.clear, .black], startPoint: .center, endPoint: .bottom)
            
            // information
            informationLayer
            
            // Like or Nope
            LikeAndNope
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .offset(offset)
        .gesture(gesture)
        .scaleEffect(scale)
        .rotationEffect(.degrees(angle))
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("NOPEACTION"), object: nil), perform: { data in
            guard let info = data.userInfo,
                  let id = info["id"] as? String else { return }
            
            if id == user.id {
                removeCard(isLiked: false)
            }
            print("タップされました")
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("LIKEACTION"), object: nil), perform: { data in
            guard let info = data.userInfo,
                  let id = info["id"] as? String else { return }
            
            if id == user.id {
                removeCard(isLiked: true)
            }
            print("タップされました")
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("REDOACTION"), object: nil), perform: { data in
            guard let info = data.userInfo,
                  let id = info["id"] as? String else { return }
            
            if id == user.id {
                resetCard()
            }
            print("タップされました")
        })
        
    }
}

#Preview {
    ListView()
}

// MARK: -UI
extension CardView {
    private var imageLayer: some View {
        Image(user.photoUrl ?? "avatar")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100)
    }
    
    private var informationLayer: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(user.name)
                    .font(.largeTitle.bold())
                
                Text(String(user.age))
                    .font(.title2)
                
                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(.white, .blue)
                    .font(.title2)
            }
            if let message = user.message {
                Text(message)
            }
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private var LikeAndNope: some View {
        HStack {
            // Like
            Text("LIKE")
                .tracking(4)
                .foregroundStyle(.green)
                .font(.system(size: 50))
                .fontWeight(.heavy)
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.green, lineWidth: 5)
                )
                .rotationEffect(Angle(degrees: -15))
                .offset(x: 16, y: 30)
                .opacity(opacity)
            
            // Nope
            Text("NOPE")
                .tracking(4)
                .foregroundStyle(.red)
                .font(.system(size: 50))
                .fontWeight(.heavy)
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.red, lineWidth: 5)
                )
                .rotationEffect(Angle(degrees: 15))
                .offset(x: -16, y: 36)
                .opacity(-opacity)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

// MARK: -Action
extension CardView {
    
    private var screenWidth: CGFloat {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 0.0 }
        return window.screen.bounds.width
    }
    
    private var scale: CGFloat {
        return max((1.0 - abs(offset.width) / screenWidth), 0.75)
    }
    
    private var angle: Double {
        return (offset.width / screenWidth) * 10.0
    }
    
    private var opacity: Double {
        return (offset.width / screenWidth) * 4.0
    }
    
    private func removeCard(isLiked: Bool, height: CGFloat = 0.0) {
        withAnimation(.smooth) {
            offset = CGSize(width: isLiked ? screenWidth * 1.5: -screenWidth * 1.5, height: height)
        }
        
        adjustIndex(false)
    }
    
    private func resetCard() {
        withAnimation(.smooth) {
            offset = .zero
        }
        
        adjustIndex(true)
    }
    
    private var gesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let width = value.translation.width
                let height = value.translation.height
                
                let limitedHeight = height > 0 ? min(height, 100) : max(height, -100)
                offset = CGSize(width: width, height: limitedHeight)
            }
            .onEnded { value in
                let width = value.translation.width
                let height = value.translation.height
                
                
                if abs(width) > screenWidth / 4 {
                    removeCard(isLiked: width > 0, height: height)
                } else {
                    resetCard()
                }
            }
    }
}
