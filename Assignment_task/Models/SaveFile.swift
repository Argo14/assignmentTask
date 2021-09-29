//
//  SaveFile.swift
//  Assignment_task
//
//  Created by Arjun Gopakumar on 28/09/21.
//

import Foundation

class SaveFile : NSObject{
  
    class func save(_ model: Candidates, for filename: String) throws -> Bool{
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            let data = try JSONEncoder().encode(model)
            
            //Checking file is available or now
            guard fileManager.fileExists(atPath: fileURL.path) else {
                /// Create new file here
                return fileManager.createFile(atPath: fileURL.path,
                                            contents: data, attributes: nil)
            }
            try data.write(to: fileURL, options: [.atomicWrite])
            return true
        }
        return false
    }
    
   class func loadJSON(withFilename filename: String) throws -> Candidates? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory,
                                     in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            let data = try Data(contentsOf: fileURL)
            let jsonObject = try JSONDecoder().decode(Candidates.self,
                                                    from: data)
            return jsonObject
        }
        return nil
    }
    
}
