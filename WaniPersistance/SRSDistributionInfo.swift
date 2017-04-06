//
//  SRSDistributionInfo.swift
//  WaniKani
//
//  Created by Andriy K. on 3/31/17.
//  Copyright © 2017 haawa. All rights reserved.
//

import Foundation
import WaniModel
import RealmSwift

class SRSDistributionInfo: Object {
  dynamic var apprentice: WaniPersistance.SRSLevelInfo!
  dynamic var guru: WaniPersistance.SRSLevelInfo!
  dynamic var master: WaniPersistance.SRSLevelInfo!
  dynamic var enlighten: WaniPersistance.SRSLevelInfo!
  dynamic var burned: WaniPersistance.SRSLevelInfo!
  dynamic var userId: String = ""

  override static func primaryKey() -> String? {
    return "userId"
  }

  convenience init(srsDistribution: WaniModel.SRSDistributionInfo, userId: String) {
    self.init()
    self.userId = userId
    self.apprentice = WaniPersistance.SRSLevelInfo(srs: srsDistribution.apprentice, label: "apprentice")
    self.guru = WaniPersistance.SRSLevelInfo(srs: srsDistribution.guru, label: "guru")
    self.master = WaniPersistance.SRSLevelInfo(srs: srsDistribution.master, label: "master")
    self.enlighten = WaniPersistance.SRSLevelInfo(srs: srsDistribution.enlighten, label: "enlighten")
    self.burned = WaniPersistance.SRSLevelInfo(srs: srsDistribution.burned, label: "burned")
  }

  var waniModelStruct: WaniModel.SRSDistributionInfo {
    return WaniModel.SRSDistributionInfo(realmObject: self)
  }
}

extension WaniModel.SRSDistributionInfo {

  init(realmObject: WaniPersistance.SRSDistributionInfo) {
    self.apprentice = realmObject.apprentice.waniModelStruct
    self.guru = realmObject.guru.waniModelStruct
    self.master = realmObject.master.waniModelStruct
    self.enlighten = realmObject.enlighten.waniModelStruct
    self.burned = realmObject.burned.waniModelStruct
  }

}
