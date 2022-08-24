//
//  FirebaseCollections.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 8/19/22.
//

import Firebase

class FirebaseReferences {
    static let userReference = Firestore.firestore()
        .collection("users")
        .document(Auth.auth().currentUser?.uid ?? "")
    
    static let storageUserReference = Storage.storage()
        .reference(withPath: "users/\(Auth.auth().currentUser?.uid ?? "")/perfil.png")

    static func storageUnitReference(number: Int) -> StorageReference {
        Storage.storage().reference(withPath: "cover/capa\(number).png")
    }

    static func storagePdfReference(number: Int) -> StorageReference {
        Storage.storage().reference(withPath: "pdfs/livro_\(number).pdf")
    }
}
