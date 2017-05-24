//
//  Persistance+Fetch.swift
//  WaniKani
//
//  Created by Andriy K. on 4/6/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel

public extension Persistance {

  var levelProgression: WaniModel.LevelProgressionInfo? {
    return user.levelProgression?.waniModelStruct
  }

  var studyQueue: WaniModel.StudyQueueInfo? {
    return user.studyQueue?.waniModelStruct
  }

  var srs: WaniModel.SRSDistributionInfo? {
    return user.srs?.waniModelStruct
  }

  var criticalItems: [WaniModel.ReviewItemInfo]? {
    return user.criticalItems?.waniModelStruct
  }

  var recentsItems: [WaniModel.ReviewItemInfo]? {
    return user.recentsItems?.waniModelStruct
  }
  
  func radicalsForLevel(level: Int) -> [WaniModel.RadicalInfo] {
    let predicate = NSPredicate(format: "level == \(level)")
    return realm.objects(WaniPersistance.RadicalInfo.self).filter(predicate).map { $0.waniModelStruct }
  }

  func kanjiForLevel(level: Int) -> [WaniModel.KanjiInfo] {
    let predicate = NSPredicate(format: "level == \(level)")
    return realm.objects(WaniPersistance.KanjiInfo.self).filter(predicate).map { $0.waniModelStruct }
  }

  func wordsForLevel(level: Int) -> [WaniModel.WordInfo] {
    let predicate = NSPredicate(format: "level == \(level)")
    return realm.objects(WaniPersistance.WordInfo.self).filter(predicate).map { $0.waniModelStruct }
  }
    
    func searchResults(text: String) -> ([WaniModel.RadicalInfo], [WaniModel.KanjiInfo], [WaniModel.WordInfo]) {
        
        let levelPredicatString: String
        if let number = Int(text) {
            levelPredicatString = "OR (level == \(number))"
        } else {
            levelPredicatString = ""
        }
        
        let radicalPredicate = NSPredicate(format: "(character contains[c] '\(text)') OR (meaning contains[c] '\(text)')\(levelPredicatString)")
        let radicals = realm.objects(WaniPersistance.RadicalInfo).filter(radicalPredicate)
        
        let kanjiPredicate = NSPredicate(format: "(character contains[c] '\(text)') OR (meaning contains[c] '\(text)')\(levelPredicatString)")
        let kanji = realm.objects(WaniPersistance.KanjiInfo).filter(kanjiPredicate)
        
        
        let wordsPredicate = NSPredicate(format: "(character contains[c] '\(text)') OR (meaning contains[c] '\(text)')\(levelPredicatString)")
        let words = realm.objects(WaniPersistance.WordInfo).filter(wordsPredicate)
        
        return (radicals.map { $0.waniModelStruct }, kanji.map { $0.waniModelStruct }, words.map { $0.waniModelStruct })
    }
}

extension Persistance {
  var allKanji: [WaniModel.KanjiInfo] {
    return realm.objects(WaniPersistance.KanjiInfo.self).map { $0.waniModelStruct }
  }
  var allRadicals: [WaniModel.RadicalInfo] {
    return realm.objects(WaniPersistance.RadicalInfo.self).map { $0.waniModelStruct }
  }
  var allWords: [WaniModel.WordInfo] {
    return realm.objects(WaniPersistance.WordInfo.self).map { $0.waniModelStruct }
  }
}
