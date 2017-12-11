//
//  ScoresManager.swift
//  Frogger
//
//  Created by Rodrigo Franzoi Scroferneker on 10/12/17.
//  Copyright © 2017 Rodrigo Franzoi Scroferneker. All rights reserved.
//

import Foundation

class ScoresManager  {
    
    class func addScore(_ score: Int) {
        var newScore = [String:String]()
        
        newScore["number"] = score.description
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        newScore["date"] = dateFormatter.string(from: NSDate() as Date)
        
        
        var scores = getScores()
        scores.append(newScore)
        
        let sortedArray = scores.sorted {Int($1["number"]!)! < Int($0["number"]!)!}
        
        self.saveScores(scores: sortedArray)
    }
    
    class func getScores(rankQnt numb: Int) -> [[String:String]]{
        let scores = self.getScores()
        if scores.count-1 > numb {
            return [[String:String]](scores.prefix(numb))
        }
        return scores
    }
    
    class func getScores(rankQnt numb: Int) -> String {
        
        let scores : [[String:String]] = self.getScores(rankQnt: numb)
        var str : String = "#N   DATE\t\t\t\tSCORE\n\n"
        let fakeRows =  numb - scores.count
        
        for (index, score) in scores.enumerated() {
            let scoreNumber : String = score["number"]!
            let scoreDate :String  = score["date"]!
            let number = "#" + String(format: "%02d", index+1) + " "
            str +=  number + " " + scoreDate + "\t" + scoreNumber + "\n"
        }
        
        if fakeRows > 0 {
            for index in scores.count...numb-1 {
                let number = "#" + String(format: "%02d", index+1) + " "
                str +=  number + " NULL\t\t\t\t" + "NULL" + "\n"
            }
        }
        
        return str
    }
    
    class func getScores() -> [[String:String]]{
        
        let file = "scores" + ".json"
        
        let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        
        let dir = dirs[0] as NSString
        let path = dir.appendingPathComponent(file);
        let jsonData = try? Data(contentsOf: Foundation.URL(fileURLWithPath: path))
        
        if(jsonData != nil){
            do{
                let MyData = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:String]]
                return MyData
            }catch _ {
                return []
            }
        }else{
            return []
        }
    }
    
    
    private class func saveScores(scores : [[String:String]]) {
        
        let file = "scores" + ".json"
        
        let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let dir = dirs[0] as NSString
        let path = dir.appendingPathComponent(file);
        
        do{
            let data = try JSONSerialization.data(withJSONObject: scores, options: JSONSerialization.WritingOptions())
            try? data.write(to: Foundation.URL(fileURLWithPath: path), options: [.atomic])
        }catch{
            return
        }
    }
}
