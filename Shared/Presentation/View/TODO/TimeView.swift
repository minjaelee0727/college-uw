//
//  TimeView.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021/07/25.
//

import SwiftUI

struct TimeView: View {
    @State var subViewType: TimeTableSubViewType = .timetable
    
    func subView() -> AnyView {
         switch subViewType {
         case .timetable: return AnyView(TimeTableView())
         case .calendar: return AnyView(CalendarView())
         }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            TimetableHeader(subViewType: $subViewType)
            
            subView()
            
            Spacer()
        }
    }
}

struct TimetableHeader: View {
    @Binding var subViewType: TimeTableSubViewType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button(action: {
                    self.subViewType = .timetable
                }) {
                    VStack(spacing: 0) {
                        Text("Timetable")
                            .font(.title)
                            .fontWeight(self.subViewType == .timetable ? .bold : .regular)
                            .foregroundColor(self.subViewType == .timetable ? .primary : .secondary)
                        
                        Rectangle()
                            .foregroundColor(.primary)
                            .frame(height: 5)
                            .opacity(self.subViewType == .calendar ? 0 : 1)
                    }

                }

                Button(action: {
                    self.subViewType = .calendar
                }) {
                    VStack(spacing: 0) {
                        Text("Calendar")
                            .font(.title)
                            .fontWeight(self.subViewType == .calendar ? .bold : .regular)
                            .foregroundColor(self.subViewType == .calendar ? .primary : .secondary)
                        
                        Rectangle()
                            .foregroundColor(.primary)
                            .frame(height: 5)
                            .opacity(self.subViewType == .timetable ? 0 : 1)
                    }
                }
                
                Spacer()
            }
            .padding(.leading)

            Divider()
        }
    }
}

// MARK: TimeTable
struct TimeTableView: View {
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                
                Image(systemName: "plus.app")
                
            }
        }
    }
}

// MARK: Calendar
struct CalendarView: View {
    var body: some View {
        Text("asdf")
    }
}

struct TimetableView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(containedViewType: .time)
    }
}
