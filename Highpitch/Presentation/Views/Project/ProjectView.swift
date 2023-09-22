//
//  ProjectView.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/20.
//

import SwiftUI

struct ProjectView: View {
    @StateObject var projectVM = ProjectVM()
    @Binding var navigationPath: [Route]
    
    var body: some View {
        RecordView(navigationPath: $navigationPath)
            .environmentObject(projectVM)
    }
}

//struct ProjectView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ProjectView()
//    }
//}
