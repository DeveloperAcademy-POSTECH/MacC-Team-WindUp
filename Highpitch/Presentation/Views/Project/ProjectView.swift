//
//  ProjectView.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/20.
//

import SwiftUI

struct ProjectView: View {
    @StateObject var projectVM = ProjectVM()
    
    @Binding var sidebarStatus: Int
    var body: some View {
        if sidebarStatus == 0 {
            PresentationView(sidebarStatus: $sidebarStatus)
                .onAppear {
                    projectVM.getProject()
                }
        } else {
            RecordView(sidebarStatus: $sidebarStatus)
        }
    }
}

struct ProjectView_Previews: PreviewProvider {
    @State static var sidebarStatus = 0
    
    static var previews: some View {
        ProjectView(sidebarStatus: $sidebarStatus)
    }
}
