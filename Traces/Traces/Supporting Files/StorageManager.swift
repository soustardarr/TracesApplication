//
//  StorageManager.swift
//  Traces
//
//  Created by Ruslan Kozlov on 19.03.2024.
//

import Foundation
import FirebaseStorage

public enum StorageErorrs: Error {
    case failedToUpload
    case failedToGetDownloadURL
}

class StorageManager {

    static let shared = StorageManager()

    private let storage = Storage.storage().reference()

    func uploadAvatarImage(with data: Data, fileName: String, completion: @escaping (Result<String, Error>) -> ()) {

        storage.child("images/\(fileName)").putData(data, metadata: nil) { metadata, error in
            guard error == nil else {
                completion(.failure(StorageErorrs.failedToUpload))
                return
            }

            self.storage.child("images/\(fileName)").downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(StorageErorrs.failedToGetDownloadURL))
                    return
                }
                let urlString = url.absoluteString
                completion(.success(urlString))
            }
        }

    }

    func getDownloadUrl(for path: String, completion: @escaping (Result<URL, Error>) -> ()){
        let reference = storage.child(path)

        reference.downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageErorrs.failedToGetDownloadURL))
                return
            }
            completion(.success(url))
        }
    }


}
