//
//  LibraryView.swift
//  Satsuma
//
//  Created by Stossy11 on 13/7/2024.
//

import SwiftUI

struct LibraryView: View {
    @Binding var core: Core
    @State var doesitexist = (false, false)
    var body: some View {
        NavigationStack {
            VStack {
                if doesitexist.0 && doesitexist.1 {
                    GameListView(core: core)
                } else {
                    let (doesKeyExist, doesProdExist) = doeskeysexist()
                    ScrollView {
                        Text("You Are Missing These Files:")
                            .font(.headline)
                            .foregroundColor(.red)
                        if doesKeyExist && !doesProdExist {
                            Text("Prod.keys")
                                .font(.subheadline)
                                .foregroundColor(.red)
                        }
                        if !doesKeyExist && !doesProdExist {
                            Text("Prod.keys and Title.keys")
                                .font(.subheadline)
                                .foregroundColor(.red)
                        }
                        if !doesKeyExist && doesProdExist {
                            Text("Title.keys")
                                .font(.subheadline)
                                .foregroundColor(.red)
                        }
                        Text("These goes into the Keys folder")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    .refreshable {
                        doesitexist = doeskeysexist()
                    }
                }
                
            }
            .onAppear() {
                doesitexist = doeskeysexist()
            }
        }
        
    }
    
    private func moveFileToAppropriateFolder(_ fileURL: URL) {
           let fileManager = FileManager.default
           let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
           
           let romsDirectory = documentsDirectory.appendingPathComponent("roms")
           let keysDirectory = documentsDirectory.appendingPathComponent("keys")
           
           let fileExtension = fileURL.pathExtension.lowercased()
           if ["nca", "nro", "nso", "nsp", "xci"].contains(fileExtension) {
               do {
                   try fileManager.copyItem(at: fileURL, to: romsDirectory.appendingPathComponent(fileURL.lastPathComponent))
               } catch {
                   print("Error moving file to roms folder: \(error.localizedDescription)")
               }
           } else if fileExtension == "keys" {
               do {
                   try fileManager.copyItem(at: fileURL, to: keysDirectory.appendingPathComponent(fileURL.lastPathComponent))
               } catch {
                   print("Error moving file to keys folder: \(error.localizedDescription)")
               }
           }
       }
    
    
    func doeskeysexist() -> (Bool, Bool) {
        var doesprodexist = false
        var doestitleexist = false
        
        
        let title = core.root.appendingPathComponent("keys").appendingPathComponent("title.keys")
        let prod = core.root.appendingPathComponent("keys").appendingPathComponent("prod.keys")
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        if fileManager.fileExists(atPath: prod.path) {
            doesprodexist = true
        } else {
            print("File does not exist")
        }
        
        if fileManager.fileExists(atPath: title.path) {
            doestitleexist = true
        } else {
            print("File does not exist")
        }
        
        return (doestitleexist, doesprodexist)
    }
}

