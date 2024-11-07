import SwiftUI

struct ContentView: View {
    //states
    @State private var useGreyBackground = false
    
    //views as properties
    private let title = TitleText(text: "Project 3")
    private let subTitle = TitleText(text: "Views and Modifiers")
    
    //views as computed properties
    @ViewBuilder private var titles: some View {
        title
            .foregroundStyle(.indigo)
        subTitle
            .foregroundStyle(.primary)
    }
    
    private var changeButton: some View {
        Button("Change") {
            useGreyBackground.toggle()
        }
        .buttonStyle()
        .frame(width: 200, height: 200)
        .background(useGreyBackground ? .secondary : .primary)
        .watermarked(with: "swift", and: .orange)
        .clipShape(.rect(cornerRadius: 20))
    }
    
    //body view
    var body: some View {
        VStack {
            titles
            changeButton
        }
    }
}

//custom views
struct TitleText: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.title2.weight(.bold))
    }
}

//custom view modifiers
struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.borderedProminent)
            .tint(.indigo)
            .foregroundStyle(.white)
            .font(.callout)
            .clipShape(.capsule)

    }
}
struct Watermark: ViewModifier {
    var icon: String
    var color: Color
    func body(content: Content) -> some View {
        return ZStack(
            alignment: .bottomTrailing
        ) {
            content
            Image(systemName: icon)
                .foregroundStyle(color)
                .padding(20)
        }
    }
}

//custom modifier extensions on views
extension View {
    func buttonStyle() -> some View {
        modifier(ButtonStyle())
    }
    func watermarked(with icon: String, and color: Color) -> some View {
        modifier(Watermark(icon: icon, color: color))
    }
}

//preview
#Preview {
    ContentView()
}
