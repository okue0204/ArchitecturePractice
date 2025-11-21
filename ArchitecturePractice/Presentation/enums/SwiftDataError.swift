
import Foundation

enum SwiftDataError {
    case saveFailed
    case insertFailed
    case fetchFailed
    case updateFailed
    case deleteFailed
    
    var message: String {
        switch self {
        case .saveFailed:
            "データの保存に失敗しました。"
        case .insertFailed:
            "データの追加に失敗しました。"
        case .fetchFailed:
            "データの取得に失敗しました。"
        case .updateFailed:
            "データの更新に失敗しました。"
        case .deleteFailed:
            "データの削除に失敗しました。"
        }
    }
}
