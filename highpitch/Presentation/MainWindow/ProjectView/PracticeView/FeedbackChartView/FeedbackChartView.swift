//
//  FeedbackChartView.swift
//  highpitch
//
//  Created by yuncoffee on 10/14/23.
//

import SwiftUI

struct FeedbackChartView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("피드백")
            ScrollView {
                UsagePercentChart()
                UsageTopTierChart()
                SpeedAverageChart()
            }
            .padding(.bottom, 64)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .border(.blue)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
}

#Preview {
    FeedbackChartView()
}
