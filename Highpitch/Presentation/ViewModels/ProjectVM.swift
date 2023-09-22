//
//  ProjectVM.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/21.
//

import Foundation

class ProjectVM: ObservableObject {
    let service = ProjectService()
    @Published var projects: [HPProject] = []
    
}

extension ProjectVM {
    func getProjects() -> [HPProject] {
        service.getProjects()
    }
    
    /**
     
     */
    public func updateProjects() {
        projects = getProjects()
    }
}
