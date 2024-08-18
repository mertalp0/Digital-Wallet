import SwiftUI

struct SplashView: View {
    
    // Harf animasyonları için State
    @State private var titleOffset: [CGSize] = Array(repeating: CGSize(width: 0, height: UIScreen.main.bounds.height), count: "Digital Wallet".count)
    @State private var titleRotation: [Double] = Array(repeating: 0, count: "Digital Wallet".count)
    @State private var titleOpacity: [Double] = Array(repeating: 0, count: "Digital Wallet".count)
    @State private var titleScale: [Double] = Array(repeating: 1, count: "Digital Wallet".count)
    
    // Arka plan animasyonu için State
    @State private var backgroundColor: Color = Color.purple
    
    var onDisappear: (() -> Void)?
    
    private let title = "Digital Wallet"
    
    var body: some View {
        ZStack {
            // Arka Plan Renk Geçiş Animasyonu
            LinearGradient(gradient: Gradient(colors: [backgroundColor, backgroundColor.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    // Arka plan renk animasyonunu başlat
                    withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: true)) {
                        self.backgroundColor = Color.blue
                    }
                }
            
            // Harf Animasyonları
            HStack(spacing: 0) {
                ForEach(0..<title.count, id: \.self) { index in
                    Text(String(title[title.index(title.startIndex, offsetBy: index)]))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(titleOffset[index])
                        .rotationEffect(.degrees(titleRotation[index]))
                        .opacity(titleOpacity[index])
                        .scaleEffect(titleScale[index])
                        .animation(
                            Animation.easeInOut(duration: 0.5)
                                .delay(Double(index) * 0.1)
                                .repeatForever(autoreverses: true),
                            value: titleOffset[index]
                        )
                        .onAppear {
                            // Harf animasyonlarını başlat
                            titleOffset[index] = CGSize(width: 0, height: 0)
                            titleRotation[index] = Double.random(in: -10...10)
                            titleOpacity[index] = 1
                            titleScale[index] = 1.2
                        }
                }
            }
            .onAppear {
                // Animasyonların zamanlaması
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    withAnimation {
                        self.onDisappear?()
                    }
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
