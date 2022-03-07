//
//  PieChartView.swift
//
//  Created by Nazar Ilamanov
//
//  See Reference: www.betterprogramming.pub/build-pie-charts-in-swiftui-822651fbf3f2

import SwiftUI

struct PieSliceView: View {
    var pieSliceData: PieSliceData
    
    var midRadians: Double {
        return Double.pi / 2.0 - (pieSliceData.startAngle + pieSliceData.endAngle).radians / 2.0
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let width: CGFloat = min(geometry.size.width, geometry.size.height)
                    let height = width
                    
                    let center = CGPoint(x: width * 0.5, y: height * 0.5)
                    
                    path.move(to: center)
                    
                    path.addArc(
                        center: center,
                        radius: width * 0.46,
                        startAngle: Angle(degrees: -90.0) + pieSliceData.startAngle,
                        endAngle: Angle(degrees: -90.0) + pieSliceData.endAngle,
                        clockwise: false)
                    
                }
                .fill(pieSliceData.color)
                
                AppText(text: pieSliceData.text, fontSize: FontSize.large, fontColor: .white)
                    .position(
                        x: geometry.size.width * 0.5 * CGFloat(1.0 + 0.78 * cos(self.midRadians)/1.5),
                        y: geometry.size.height * 0.5 * CGFloat(1.0 - 0.78 * sin(self.midRadians)/1.5)
                    )
                    .foregroundColor(Color.white)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct PieSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var text: String
    var color: Color
}

struct PieChartView: View {
    public var values: [Double]
    public var colors: [Color]
    
    public var backgroundColor: Color
    
    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), text: String(format: "%.0f%%", value * 100 / sum), color: self.colors[i]))
            endDeg += degrees
        }
        return tempSlices
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                if values.reduce(0, +) != 0 {
                    ForEach(0..<self.values.count){ i in
                        
                        // if the slice is "0%", do not include in the chart
                        if self.slices[i].text != "0%"{
                            PieSliceView(pieSliceData: self.slices[i])
                        }
                    }
                }else {
                    AppText(text: "No Data to show", fontSize: FontSize.large)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.width)
            .background(self.backgroundColor)
            .foregroundColor(Color.white)
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(values: [1300, 500, 300], colors: [Color.blue, Color.green, Color.orange], backgroundColor: Color.clear)
    }
}
