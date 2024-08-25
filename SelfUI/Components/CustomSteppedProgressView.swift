import SwiftUI

struct CustomSteppedProgressView: View {
  var body: some View {
    ZStack() {
      VStack(alignment: .leading, spacing: -10) {
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 86, height: 10)
          .background(Color(red: 0, green: 0.64, blue: 0.43))
          .cornerRadius(20)
        Rectangle()
          .foregroundColor(.clear)
          .frame(maxWidth: .infinity, minHeight: 10, maxHeight: 10)
          .background(Color(red: 0.88, green: 0.88, blue: 0.88))
          .cornerRadius(20)
      }
      .padding(EdgeInsets(top: 0, leading: 27, bottom: 0, trailing: 27))
      .frame(width: 393, height: 52)
      .offset(x: 0, y: 0)
      HStack(spacing: -3) {
        HStack(spacing: 10) {
          Ellipse()
            .foregroundColor(.clear)
            .frame(width: 24, height: 24)
            .background(Color(red: 0, green: 0.64, blue: 0.43))
          ZStack() {

          }
          .frame(width: 12, height: 12)
        }
        HStack(spacing: 10) {
          Ellipse()
            .foregroundColor(.clear)
            .frame(width: 32, height: 32)
            .background(.white)
            .overlay(
              Ellipse()
                .inset(by: 1.50)
                .stroke(Color(red: 0, green: 0.64, blue: 0.43), lineWidth: 1.50)
            )
          Text("2")
                .font(Font.custom("SF Pro", size: 12).weight(.medium))
            .tracking(0.12)
            .lineSpacing(18)
            .foregroundColor(.black)
        }
        HStack(spacing: 10) {
          Ellipse()
            .foregroundColor(.clear)
            .frame(width: 24, height: 24)
            .background(Color(red: 0.88, green: 0.88, blue: 0.88))
          Text("3")
                .font(Font.custom("SF Pro", size: 12).weight(.medium))
            .tracking(0.12)
            .lineSpacing(18)
            .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
        }
        HStack(spacing: 10) {
          Ellipse()
            .foregroundColor(.clear)
            .frame(width: 24, height: 24)
            .background(Color(red: 0.88, green: 0.88, blue: 0.88))
          Text("4")
                .font(Font.custom("SF Pro", size: 12).weight(.medium))
            .tracking(0.12)
            .lineSpacing(18)
            .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
        }
        HStack(spacing: 10) {
          Ellipse()
            .foregroundColor(.clear)
            .frame(width: 24, height: 24)
            .background(Color(red: 0.88, green: 0.88, blue: 0.88))
          Text("5")
                .font(Font.custom("SF Pro", size: 12).weight(.medium))
            .tracking(0.12)
            .lineSpacing(18)
            .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
        }
      }
      .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
      .frame(width: 393)
      .offset(x: 0, y: 0)
    }
    .frame(width: 393, height: 50);
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      CustomSteppedProgressView()
  }
}
