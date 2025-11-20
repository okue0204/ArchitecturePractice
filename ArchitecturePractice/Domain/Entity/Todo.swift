//
//  Todo.swift
//  ArchitecturePractice
//
//  Created by 奥江英隆 on 2025/11/21.
//

import Foundation
import SwiftUI

struct Todo: Identifiable, Equatable {
    let id: UUID
    let title: String
    let description: String
    let createdAt: Date
    let updatedAt: Date
    let isCompleted: Bool
}
