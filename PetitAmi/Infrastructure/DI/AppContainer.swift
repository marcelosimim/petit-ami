//
//  AppContainer.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import Swinject

class AppContainer {
    static let shared: Container = {
        let container = Container()
        
        container.register(FirstView.self) { _ in DefaultFirstView()}
        container.register(RegisterView.self) { _ in DefaultRegisterView()}

        return container
    }()
}
