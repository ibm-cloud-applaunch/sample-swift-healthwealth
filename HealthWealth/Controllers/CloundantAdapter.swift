//
//  CloundantAdapter.swift
//  HealthWealth
//
//  Created by Vittal Pai on 1/18/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import Foundation
import SwiftCloudant


internal class CloudantAdapter {
    internal static var sharedInstance = CloudantAdapter()
    internal var client:CouchDBClient
    internal var dbName:String
    internal var cloudantusername:String?
    internal var cloudantpassword:String?
    internal var cloudantURL:String?
    internal var cloudantName:String?
    
    var images:[UIImage] = [UIImage]()
    
    init() {
        if let contents = Bundle.main.path(forResource:"ICCredentials", ofType: "plist"), let dictionary = NSDictionary(contentsOfFile: contents) {
            self.cloudantusername = dictionary["cloudantUserID"] as? String
            self.cloudantpassword = dictionary["cloundantPassword"] as? String
            self.cloudantURL = dictionary["cloundantURL"] as? String
            self.cloudantName = (dictionary["dbName"] as? String)!
            
        }
        self.dbName = cloudantName!
        self.client = CouchDBClient(url: URL(string: cloudantURL!)!, username: cloudantusername, password: cloudantpassword)
    }
   
  
    
    internal func createDocument(_ documentID: String,_ completionHandler:@escaping ((Bool) -> Void)) {
        let create = PutDocumentOperation(id: documentID, revision: nil, body: [:], databaseName: dbName) {(response, httpInfo, error) in
            if let error = error {
                print("Encountered an error while creating a document. Error:\(error)")
                self.getRevisionID(documentID, completionHandler: { (revisionid) in
                    if (!revisionid.isEmpty) {
                        completionHandler(true)
                    } else {
                        self.createDocument(documentID, completionHandler)
                    }
                })
            } else {
                print("Created document \(String(describing: response?["id"])) with revision id \(String(describing: response?["rev"]))")
                completionHandler(true)
            }
        }
        client.add(operation:create)
    }
    
    internal func addImage(_ documentID: String,_ image: Data,_  completionHandler:@escaping ((Bool) -> Void)) {
        getRevisionID(documentID) { (RevisionID) in
            if (!RevisionID.isEmpty) {
                let putAttachment = PutAttachmentOperation(name: "image",
                                                           contentType:"text/plain",
                                                           data: image,
                                                           documentID: documentID,
                                                           revision: RevisionID,
                                                           databaseName: self.dbName) { (response, info, error) in
                                                            if let error = error {
                                                                print("Encountered an error while creating an attachment. Error:\(error)")
                                                                completionHandler(false)
                                                            } else {
                                                                print("Created attachment \(String(describing: response?["id"])) with revision id \(response?["rev"])")
                                                                completionHandler(true)
                                                            }
                }
                self.client.add(operation: putAttachment)
            }
        }
        
    }
    
    internal func deleteDocument(_ documentID: String,_ completionHandler:@escaping ((Bool) -> Void)) {
        // Delete a document
        getRevisionID(documentID) { (revisionID) in
            if (revisionID != "") {
                let delete = DeleteDocumentOperation(id: documentID,
                                                     revision: revisionID,
                                                     databaseName: self.dbName) { (response, httpInfo, error) in
                                                        if let error = error {
                                                            print("Encountered an error while deleting a document. Error: \(error)")
                                                            completionHandler(false)
                                                        } else {
                                                            completionHandler(true)
                                                        }
                }
                self.client.add(operation:delete)
            } else {
                completionHandler(true)
            }
        }
        
    }
    
    
    internal func isDoctor(_ username: String,_ completionHandler:@escaping ((Bool) -> Void)) {
        let readID = GetDocumentOperation(id: "doctors", databaseName: dbName) { (response, httpInfo, error) in
            if let error = error {
                print("Encountered an error while deleting a document. Error: \(error)")
                completionHandler(false)
            } else {
                let resp:String = response?[username] != nil ?  response?[username] as! String : ""
                if (resp.lowercased() == "enable") {
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            }
        }
        client.add(operation:readID)
    }
    
    private func getRevisionID(_ documentID: String, completionHandler:@escaping ((String) -> Void)) {
        let readID = GetDocumentOperation(id: documentID, databaseName: dbName) { (response, httpInfo, error) in
            if let error = error {
                print("Encountered an error while deleting a document. Error: \(error)")
                completionHandler("")
            } else {
                completionHandler(response?["_rev"] as! String)
            }
        }
        client.add(operation:readID)
    }
    
    internal func getImages(_ completionHandler:@escaping ((Bool) -> Void)) {
        let view = QueryViewOperation(name: "all", designDocumentID: "getimages", databaseName: dbName, rowHandler: { (row) in
            let reteiveImage = ReadAttachmentOperation(name: "image", documentID: row["id"] as! String, databaseName: self.dbName){ (data, info, error) in
                if error != nil {
                    print("Error : Retreiving Image")
                } else {
                    let image = UIImage(data: data!)!
                    self.images.append(image)
                }
            }
            self.client.add(operation: reteiveImage)
        },completionHandler: { (response, status, error) in
            if (error != nil ){
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        })
        client.add(operation:view)
    }
    
    
}
