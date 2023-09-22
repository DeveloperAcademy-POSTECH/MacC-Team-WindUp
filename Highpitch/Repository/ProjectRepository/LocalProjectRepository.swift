//
//  LocalProjectRepository.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/21.
//

import Foundation

class LocalProjectRepository: ProjectRepository {
    func getProjects() -> [HPProject] {
        [
            HPProject(
                projectName: "Sample-Local",
                createAt: Date(),
                presentationPath: Bundle.main.url(forResource: .samplePPT, withExtension: "pdf")!)
        ]
    }
    
    func getProject() {
        print("hello")
    }
    
}
