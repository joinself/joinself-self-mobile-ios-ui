//
//  LivenessIntroductionView.swift
//  SelfUI
//
//  Created by Long Pham on 17/5/24.
//

import SwiftUI

struct LivenessIntroductionView: View {
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
        VStack(alignment: .leading, spacing: 0) {
          VStack(spacing: 10) {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 125, height: 40)
              .background(.black)
              .cornerRadius(20)
          }
          .padding(10)
          .frame(maxWidth: .infinity, minHeight: 59, maxHeight: 59)
          HStack(spacing: 0) {
            ZStack() {

            }
            .frame(width: 15, height: 15)
          }
          .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
          .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
        }
        .frame(height: 99)
        .background(.white)
        ZStack() {
          VStack(alignment: .leading, spacing: -10) {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 8, height: 10)
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
                .frame(width: 32, height: 32)
                .background(.white)
                .overlay(
                  Ellipse()
                    .inset(by: 1.50)
                    .stroke(Color(red: 0, green: 0.64, blue: 0.43), lineWidth: 1.50)
                )
              Text("1")
                .font(Font.custom("SF Pro", size: 12))
                .tracking(0.12)
                .lineSpacing(18)
                .foregroundColor(.black)
            }
            HStack(spacing: 10) {
              Ellipse()
                .foregroundColor(.clear)
                .frame(width: 24, height: 24)
                .background(Color(red: 0.88, green: 0.88, blue: 0.88))
              Text("2")
                .font(Font.custom("SF Pro", size: 12))
                .tracking(0.12)
                .lineSpacing(18)
                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
            }
            HStack(spacing: 10) {
              Ellipse()
                .foregroundColor(.clear)
                .frame(width: 24, height: 24)
                .background(Color(red: 0.88, green: 0.88, blue: 0.88))
              Text("3")
                .font(Font.custom("SF Pro", size: 12))
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
                .font(Font.custom("SF Pro", size: 12))
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
                .font(Font.custom("SF Pro", size: 12))
                .tracking(0.12)
                .lineSpacing(18)
                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
            }
          }
          .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
          .frame(width: 393)
          .offset(x: 0, y: 0)
        }
        .frame(width: 393, height: 50)
        VStack(alignment: .leading, spacing: 30) {
          Text("First take a Selfie. (nobody else will see it)")
            .font(Font.custom("Barlow", size: 36).weight(.bold))
            .foregroundColor(.black)
          Text("It’s not a photo. The Self app just needs to be able to recognise you as it’s owner. On the next screen keep your face in the box and follow the instructions.  ")
            .font(Font.custom("SF Pro", size: 17))
            .lineSpacing(24)
            .foregroundColor(.black)
        }
        .padding(EdgeInsets(top: 100, leading: 15, bottom: 10, trailing: 15))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        VStack(spacing: 0) {
          VStack(spacing: 15) {
            HStack(spacing: 10) {
              Text("start")
                .font(Font.custom("Barlow", size: 17).weight(.bold))
                .tracking(0.85)
                .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .background(Color(red: 0, green: 0.64, blue: 0.43))
            .cornerRadius(40)
            HStack(spacing: 10) {
              Text("Powered by")
                .font(Font.custom("Barlow", size: 15).weight(.medium))
                .lineSpacing(22)
                .foregroundColor(.black)
              ZStack() {
                ZStack() { }
                .frame(width: 17.94, height: 10.94)
                .offset(x: 0.04, y: 0.04)
              }
              .frame(width: 30, height: 30)
            }
          }
          .padding(EdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 15))
          .frame(height: 104)
          .background(.white)
          VStack(spacing: 10) {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 140, height: 5)
              .background(Color(red: 0.58, green: 0.58, blue: 0.58))
              .cornerRadius(20)
          }
          .padding(EdgeInsets(top: 0, leading: 10, bottom: 8, trailing: 10))
          .frame(width: 393, height: 34)
          .background(.white)
        }
        .frame(height: 138)
      }
      .frame(width: 393, height: 853);
    }
}

#Preview {
    LivenessIntroductionView()
}
