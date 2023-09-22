//
//  HomeVM.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/21.
//

import Foundation

class HomeVM: ObservableObject, ProjectServiceable {
    let projectService = ProjectService()
    @Published var projects: [HPProject] = []
}

extension HomeVM {
    func getProjects() -> [HPProject] {
        projectService.getProjects()
    }
    
    /**
     
     */
    public func updateProjects() {
        projects = getProjects()
    }
}
