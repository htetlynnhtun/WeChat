//
//  MomentItemViewModel.swift
//  WeChat
//
//  Created by kira on 16/08/2022.
//

import Foundation
import SwiftUI

class MomentItemViewModel: ObservableObject {
    var moment: MomentVO
    var currentUser: UserVO
    
    init(moment: MomentVO, user: UserVO) {
        self.moment = moment
        self.currentUser = user
    }
    
    var liked: Bool {
        moment.likes.contains { userVO in
            userVO.qrCode == currentUser.qrCode
        }
    }
    
    var bookmarked: Bool {
        moment.bookmarks.contains { userVO in
            userVO.qrCode == currentUser.qrCode
        }
    }
    
    var heartImage: String {
        liked ? "heart.fill" : "heart"
    }
    
    var heartColor: Color {
        liked ? .red : .colorPrimaryVariant
    }
    
    var bookmarkImage: String {
        bookmarked ? "bookmark.fill" : "bookmark"
    }
    
    var bookmarkColor: Color {
        bookmarked ? .red : .colorPrimaryVariant
    }
    
    private let model: MomentModel = MomentModelImpl.shared
    
    func onTapLike() {
        if liked {
            model.unlikeMoment(moment: moment, user: currentUser)
        } else {
            model.likeMoment(moment: moment, user: currentUser)
        }
    }
    
    func onTapBookmark() {
        if bookmarked {
            model.unbookmarkMoment(moment: moment, user: currentUser)
        } else {
            model.bookmarkMoment(moment: moment, user: currentUser)
        }
    }
}
