//
//  MapLoader.swift
//  TowerDefense
//
//  Created by Rodrigo Franzoi Scroferneker on 27/11/17.
//  Copyright © 2017 gatosDeSchnorrdinger. All rights reserved.
//

import Foundation
import SpriteKit

protocol MapDelegate {
    func nodeForMatrix(mapHeight: Int, mapWidth: Int, index: Int, objCode: Int, spriteSize: CGSize, position: CGPoint, layerName: String)
    func setSize(size: CGSize)
}

class MapManager {
    
    var delegate : MapDelegate?
    
    var mapName : String
    
    init(mapName: String) {
        self.mapName = mapName
    }
    
    
    public func loadMap() {
        if let gamePhase = loadGame(named: mapName) {
            
            let tileHeight = gamePhase["tileheight"] as? Int ?? 32
            let tileWidth  = gamePhase["tilewidth"] as? Int ?? 32
            
            let mapHeight = gamePhase["height"] as? Int ?? 20
            let mapWidth  = gamePhase["width"] as? Int ?? 15
            
            self.delegate?.setSize(size: CGSize(width: mapWidth * tileWidth, height: mapHeight * tileHeight))
            
            if let layers = gamePhase["layers"] as? [[String:Any?]]{
                for layer in layers {
                    let name = layer["name"] as? String ?? "Error"
                    if let data = layer["data"] as? [Int] {
                        
                        for (index, obj) in data.reversed().enumerated() {
                            
                            let spriteSize = CGSize(width: tileWidth, height: tileHeight)
                            
                            let yPosition = spriteSize.height * CGFloat(Int(index/mapWidth))
                            let xPosition = spriteSize.width * CGFloat(index % mapWidth)
                            let position =  CGPoint(x: xPosition, y: yPosition)
                            
                            self.delegate?.nodeForMatrix(mapHeight: mapHeight, mapWidth: mapWidth, index: index, objCode: obj, spriteSize: spriteSize, position: position, layerName: name)
                            
                        }
                    }
                }
            }
        }
    }
    
    private func loadGame(named levelName:String) -> [String:Any?]?{
        if let path : String = Bundle.main.path(forResource: levelName, ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                do{
                    let data = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any?]
                    return data
                }catch{
                    return nil
                }
            }
        }
        return nil
    }
    
}

