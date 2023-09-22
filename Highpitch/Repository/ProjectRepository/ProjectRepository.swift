//
//  ProjectRepository.swift
//  Highpitch
//
//  Created by Yun Dongbeom on 2023/09/21.
//

import Foundation

protocol ProjectRepository {
    func getProjects() -> [HPProject]
}
