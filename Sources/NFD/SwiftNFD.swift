@_implementationOnly import CNFD

/// Native File Dialog
public enum NFD {
    public typealias Result<Value> = Swift.Result<Value?, NFD.Error> where Value: Hashable

    /// Single file open dialog
    ///
    /// - Parameters:
    ///   - filter: An array of filename extensions or UTIs that represent the allowed file types for the dialog.
    ///   - defaultPath: The current directory shown in the dialog.
    /// - Returns: On success selected file path or nil if user did cancel; On failure the error;
    public static func OpenDialog(filter: [String]? = nil, defaultPath: String? = nil) -> Result<String?> {
        let filterList: String? = filter?.joined(separator: ";")
        var pOutPath: UnsafeMutablePointer<nfdchar_t>?
        let nfdResult = NFD_OpenDialog(filterList, defaultPath, &pOutPath)
        switch nfdResult {
        case NFD_OKAY:
            let outPath = String(cString: pOutPath!)
            defer {
                pOutPath?.deinitialize(count: 1)
                pOutPath?.deallocate()
            }
            return .success(outPath)
        case NFD_CANCEL:
            return .success(nil)
        case NFD_ERROR:
            return .failure(NFD.Error())
        default:
            return .failure(NFD.Error())
        }
    }

    /// Multiple file open dialog
    ///
    /// - Parameters:
    ///   - filter: An array of filename extensions or UTIs that represent the allowed file types for the dialog.
    ///   - defaultPath: The current directory shown in the dialog.
    /// - Returns: On success selected file paths or nil if user did cancel; On failure the error;
    public static func OpenDialogMultiple(filter: [String]? = nil, defaultPath: String? = nil) -> Result<[String]> {
        let filterList: String? = filter?.joined(separator: ";")
        var pathSet = nfdpathset_t()
        let nfdResult = NFD_OpenDialogMultiple(filterList, defaultPath, &pathSet)
        switch nfdResult {
        case NFD_OKAY:
            let count = NFD_PathSet_GetCount(&pathSet)
            var paths = [String]()
            paths.reserveCapacity(count)
            for idx in 0 ..< count {
                paths.append(String(cString: NFD_PathSet_GetPath(&pathSet, idx)))
            }
            NFD_PathSet_Free(&pathSet)
            return .success(paths)
        case NFD_CANCEL:
            return .success(nil)
        case NFD_ERROR:
            return .failure(NFD.Error())
        default:
            return .failure(NFD.Error())
        }
    }

    /// Save dialog
    /// - Parameters:
    ///   - filter: An array of filename extensions or UTIs that represent the allowed file types for the dialog.
    ///   - defaultPath: The current directory shown in the dialog.
    /// - Returns: On success saved file path or nil if user did cancel; On failure the error;
    public static func SaveDialog(filter: [String]? = nil, defaultPath: String? = nil) -> Result<String?> {
        let filterList: String? = filter?.joined(separator: ";")
        var pOutPath: UnsafeMutablePointer<nfdchar_t>?
        let nfdResult = NFD_SaveDialog(filterList, defaultPath, &pOutPath)
        switch nfdResult {
        case NFD_OKAY:
            let outPath = String(cString: pOutPath!)
            defer {
                pOutPath?.deinitialize(count: 1)
                pOutPath?.deallocate()
            }
            return .success(outPath)
        case NFD_CANCEL:
            return .success(nil)
        case NFD_ERROR:
            return .failure(NFD.Error())
        default:
            return .failure(NFD.Error())
        }
    }

    /// Select folder dialog
    /// - Parameter defaultPath: The current directory shown in the dialog.
    /// - Returns: On success selected directory path or nil if user did cancel; On failure the error;
    public static func PickFolder(defaultPath: String? = nil) -> Result<String?> {
        var pOutPath: UnsafeMutablePointer<nfdchar_t>?
        let nfdResult = NFD_PickFolder(defaultPath, &pOutPath)
        switch nfdResult {
        case NFD_OKAY:
            let outPath = String(cString: pOutPath!)
            defer {
                pOutPath?.deinitialize(count: 1)
                pOutPath?.deallocate()
            }
            return .success(outPath)
        case NFD_CANCEL:
            return .success(nil)
        case NFD_ERROR:
            return .failure(NFD.Error())
        default:
            return .failure(NFD.Error())
        }
    }
}

extension NFD {
    /// NFD Error
    public struct Error: Swift.Error {
        /// A message with information about the error.
        public let message: String

        init() {
            if let pError = NFD_GetError() {
                message = String(cString: pError)
            } else {
                message = "unknown"
            }
        }
    }
}
