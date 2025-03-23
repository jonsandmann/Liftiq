import SwiftUI

struct VolumeComparisonView: View {
    let title: String
    @Binding var currentValue: Double
    @Binding var previousValue: Double
    
    private var percentageChange: Double {
        guard previousValue > 0 else { return 0 }
        return ((currentValue - previousValue) / previousValue) * 100
    }
    
    private var isPositiveChange: Bool {
        percentageChange >= 0
    }
    
    private func formatVolume(_ volumeLbs: Double) -> String {
        return NumberFormatter.volumeFormatter.string(from: NSNumber(value: volumeLbs)) ?? "0"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack(alignment: .firstTextBaseline) {
                Text("\(formatVolume(currentValue)) lbs")
                    .font(.headline)
                
                if previousValue > 0 {
                    Text(String(format: "%+.0f%%", percentageChange))
                        .font(.subheadline)
                        .foregroundColor(isPositiveChange ? .green : .red)
                }
            }
            
            if previousValue > 0 {
                Text("Previous: \(formatVolume(previousValue)) lbs")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
} 