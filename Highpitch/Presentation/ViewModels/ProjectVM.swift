//
//  ProjectVM.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/21.
//

import Foundation

class ProjectVM: ObservableObject {
    let service = ProjectService()
}

extension ProjectVM {
    func getProject() {
        service.getProject()
    }
}
