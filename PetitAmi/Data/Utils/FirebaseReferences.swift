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

    static func exerciseReference(unit: Int, exercise: Int) -> DocumentReference {
        Firestore.firestore().collection("unit\(unit)").document("e\(exercise)")
    }

    static func unitReference(unit: Int) -> DocumentReference {
        Firestore.firestore().collection("unit\(unit)").document("info")
    }

    static func storageUnitReference(number: Int) -> StorageReference {
        Storage.storage().reference(withPath: "cover/capa\(number).png")
    }

    static func storagePdfReference(number: Int) -> StorageReference {
        Storage.storage().reference(withPath: "pdfs/livro_\(number).pdf")
    }

    static func storageImageReference(unit: Int, exercise: Int) -> StorageReference {
        Storage.storage().reference(withPath: "exercises/unit\(unit)/images/\(exercise).png")
    }

    static func storageSoundReference(unit: Int, exercise: Int) -> StorageReference {
        Storage.storage().reference(withPath: "exercises/unit\(unit)/audios/\(exercise).mp3")
    }
}
