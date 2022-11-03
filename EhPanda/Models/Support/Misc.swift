//
//  Misc.swift
//  EhPanda
//
//  Created by 荒木辰造 on R 3/01/15.
//

import Foundation
import SwiftyBeaver

typealias Logger = SwiftyBeaver
typealias FavoritesSortOrder = EhSetting.FavoritesSortOrder

protocol DateFormattable {
    var originalDate: Date { get }
}
extension DateFormattable {
    var formattedDateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.locale = Locale.current
        formatter.calendar = Calendar.current
        return formatter.string(from: originalDate)
    }
}

struct PageNumber: Equatable {
    var current = 0
    var maximum = 0
    var isNextButtonEnabled = true

    var isSinglePage: Bool {
        current == 0 && maximum == 0
    }
    var hasNextPage: Bool {
        AppUtil.galleryHost == .ehentai
        ? current < maximum
        : isNextButtonEnabled
    }
    mutating func resetPages() {
        self = Self()
    }
}

struct QuickSearchWord: Codable, Equatable, Identifiable {
    static var empty: Self { .init(name: "", content: "") }

    var id: UUID = .init()
    var name: String
    var content: String
}

enum LoadingState: Equatable, Hashable {
    case idle
    case loading
    case failed(AppError)
}
