@_implementationOnly import CNFD

public enum NFD {
    /// Single file open dialog
    public static func OpenDialog(filterList: String? = nil, defaultPath: String? = nil) -> Result<String>  {
        var pOutPath : UnsafeMutablePointer<nfdchar_t>? = nil
        let nfdResult = NFD_OpenDialog(filterList, defaultPath, &pOutPath)
        switch nfdResult {
        case NFD_OKAY:
            let outPath: String = String(cString: pOutPath!)
            defer {
                pOutPath?.deinitialize(count: 1)
                pOutPath?.deallocate()
            }
            return .success(.ok(outPath))
        case NFD_CANCEL:
            return .success(.cancel)
        case NFD_ERROR:
            return .failure(NFD.Error())
        default:
            return .failure(NFD.Error())
        }
    }
    
    /// Multiple file open dialog
    public static func OpenDialogMultiple(filterList: String? = nil, defaultPath: String? = nil) -> Result<[String]> {
        var pathSet = nfdpathset_t()
        let nfdResult = NFD_OpenDialogMultiple(filterList, defaultPath, &pathSet)
        switch nfdResult {
        case NFD_OKAY:
            let count = NFD_PathSet_GetCount(&pathSet)
            var paths = [String]()
            paths.reserveCapacity(count)
            for idx in 0..<count {
                paths.append(String(cString: NFD_PathSet_GetPath(&pathSet, idx)))
            }
            NFD_PathSet_Free(&pathSet)
            return .success(.ok(paths))
        case NFD_CANCEL:
            return .success(.cancel)
        case NFD_ERROR:
            return .failure(NFD.Error())
        default:
            return .failure(NFD.Error())
        }
    }
    
    /// Save dialog
    public static func SaveDialog(filterList: String? = nil, defaultPath: String? = nil) -> Result<String> {
        var pOutPath : UnsafeMutablePointer<nfdchar_t>? = nil
        
        let nfdResult = NFD_SaveDialog(filterList, defaultPath, &pOutPath)
        switch nfdResult {
        case NFD_OKAY:
            let outPath: String = String(cString: pOutPath!)
            defer {
                pOutPath?.deinitialize(count: 1)
                pOutPath?.deallocate()
            }
            return .success(.ok(outPath))
        case NFD_CANCEL:
            return .success(.cancel)
        case NFD_ERROR:
            return .failure(NFD.Error())
        default:
            return .failure(NFD.Error())
        }
    }
    
    /// Select folder dialog
    public static func PickFolder(defaultPath: String? = nil) -> Result<String> {
        var pOutPath : UnsafeMutablePointer<nfdchar_t>? = nil
        let nfdResult = NFD_PickFolder(defaultPath, &pOutPath)
        switch nfdResult {
        case NFD_OKAY:
            let outPath: String = String(cString: pOutPath!)
            defer {
                pOutPath?.deinitialize(count: 1)
                pOutPath?.deallocate()
            }
            return .success(.ok(outPath))
        case NFD_CANCEL:
            return .success(.cancel)
        case NFD_ERROR:
            return .failure(NFD.Error())
        default:
            return .failure(NFD.Error())
        }
    }
    
    public struct Error: Swift.Error {
        public let message: String
        
        init() {
            if let pError = NFD_GetError() {
                 message = String(cString: pError)
            } else {
                message = "unknown"
            }
        }
    }
    
    public enum Success<Value> {
        case ok(Value)
        case cancel
    }
    
    public typealias Result<Value> = Swift.Result<Success<Value>, NFD.Error>
    
}

extension NFD.Result: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .success(success):
            return "success(\(success))"
        case let .failure(error):
            return "error(\(error))"
        }
    }
}
