#if SWIFT_PACKAGE
import SourceKit
#endif
#if os(Linux)
private let path = "libsourcekitdInProc.so"
#else
private let path = "sourcekitd.framework/Versions/A/sourcekitd"
#endif
private let library = toolchainLoader.load(path: path)
internal let sourcekitd_initialize: @convention(c) () -> () = library.load(symbol: "sourcekitd_initialize")
internal let sourcekitd_shutdown: @convention(c) () -> () = library.load(symbol: "sourcekitd_shutdown")
internal let sourcekitd_set_interrupted_connection_handler: @convention(c) (@escaping sourcekitd_interrupted_connection_handler_t) -> () = library.load(symbol: "sourcekitd_set_interrupted_connection_handler")
internal let sourcekitd_uid_get_from_cstr: @convention(c) (UnsafePointer<Int8>) -> (sourcekitd_uid_t?) = library.load(symbol: "sourcekitd_uid_get_from_cstr")
internal let sourcekitd_uid_get_from_buf: @convention(c) (UnsafePointer<Int8>, Int) -> (sourcekitd_uid_t?) = library.load(symbol: "sourcekitd_uid_get_from_buf")
internal let sourcekitd_uid_get_length: @convention(c) (sourcekitd_uid_t) -> (Int) = library.load(symbol: "sourcekitd_uid_get_length")
internal let sourcekitd_uid_get_string_ptr: @convention(c) (sourcekitd_uid_t) -> (UnsafePointer<Int8>?) = library.load(symbol: "sourcekitd_uid_get_string_ptr")
internal let sourcekitd_request_retain: @convention(c) (sourcekitd_object_t) -> (sourcekitd_object_t?) = library.load(symbol: "sourcekitd_request_retain")
internal let sourcekitd_request_release: @convention(c) (sourcekitd_object_t) -> () = library.load(symbol: "sourcekitd_request_release")
internal let sourcekitd_request_dictionary_create: @convention(c) (UnsafePointer<sourcekitd_uid_t?>?, UnsafePointer<sourcekitd_object_t?>?, Int) -> (sourcekitd_object_t?) = library.load(symbol: "sourcekitd_request_dictionary_create")
internal let sourcekitd_request_dictionary_set_value: @convention(c) (sourcekitd_object_t, sourcekitd_uid_t, sourcekitd_object_t) -> () = library.load(symbol: "sourcekitd_request_dictionary_set_value")
internal let sourcekitd_request_dictionary_set_string: @convention(c) (sourcekitd_object_t, sourcekitd_uid_t, UnsafePointer<Int8>) -> () = library.load(symbol: "sourcekitd_request_dictionary_set_string")
internal let sourcekitd_request_dictionary_set_stringbuf: @convention(c) (sourcekitd_object_t, sourcekitd_uid_t, UnsafePointer<Int8>, Int) -> () = library.load(symbol: "sourcekitd_request_dictionary_set_stringbuf")
internal let sourcekitd_request_dictionary_set_int64: @convention(c) (sourcekitd_object_t, sourcekitd_uid_t, Int64) -> () = library.load(symbol: "sourcekitd_request_dictionary_set_int64")
internal let sourcekitd_request_dictionary_set_uid: @convention(c) (sourcekitd_object_t, sourcekitd_uid_t, sourcekitd_uid_t) -> () = library.load(symbol: "sourcekitd_request_dictionary_set_uid")
internal let sourcekitd_request_array_create: @convention(c) (UnsafePointer<sourcekitd_object_t?>?, Int) -> (sourcekitd_object_t?) = library.load(symbol: "sourcekitd_request_array_create")
internal let sourcekitd_request_array_set_value: @convention(c) (sourcekitd_object_t, Int, sourcekitd_object_t) -> () = library.load(symbol: "sourcekitd_request_array_set_value")
internal let sourcekitd_request_array_set_string: @convention(c) (sourcekitd_object_t, Int, UnsafePointer<Int8>) -> () = library.load(symbol: "sourcekitd_request_array_set_string")
internal let sourcekitd_request_array_set_stringbuf: @convention(c) (sourcekitd_object_t, Int, UnsafePointer<Int8>, Int) -> () = library.load(symbol: "sourcekitd_request_array_set_stringbuf")
internal let sourcekitd_request_array_set_int64: @convention(c) (sourcekitd_object_t, Int, Int64) -> () = library.load(symbol: "sourcekitd_request_array_set_int64")
internal let sourcekitd_request_array_set_uid: @convention(c) (sourcekitd_object_t, Int, sourcekitd_uid_t) -> () = library.load(symbol: "sourcekitd_request_array_set_uid")
internal let sourcekitd_request_int64_create: @convention(c) (Int64) -> (sourcekitd_object_t?) = library.load(symbol: "sourcekitd_request_int64_create")
internal let sourcekitd_request_string_create: @convention(c) (UnsafePointer<Int8>) -> (sourcekitd_object_t?) = library.load(symbol: "sourcekitd_request_string_create")
internal let sourcekitd_request_uid_create: @convention(c) (sourcekitd_uid_t) -> (sourcekitd_object_t?) = library.load(symbol: "sourcekitd_request_uid_create")
internal let sourcekitd_request_create_from_yaml: @convention(c) (UnsafePointer<Int8>, UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>?) -> (sourcekitd_object_t?) = library.load(symbol: "sourcekitd_request_create_from_yaml")
internal let sourcekitd_request_description_dump: @convention(c) (sourcekitd_object_t) -> () = library.load(symbol: "sourcekitd_request_description_dump")
internal let sourcekitd_request_description_copy: @convention(c) (sourcekitd_object_t) -> (UnsafeMutablePointer<Int8>?) = library.load(symbol: "sourcekitd_request_description_copy")
internal let sourcekitd_response_dispose: @convention(c) (sourcekitd_response_t) -> () = library.load(symbol: "sourcekitd_response_dispose")
internal let sourcekitd_response_is_error: @convention(c) (sourcekitd_response_t) -> (Bool) = library.load(symbol: "sourcekitd_response_is_error")
internal let sourcekitd_response_error_get_kind: @convention(c) (sourcekitd_response_t) -> (sourcekitd_error_t) = library.load(symbol: "sourcekitd_response_error_get_kind")
internal let sourcekitd_response_error_get_description: @convention(c) (sourcekitd_response_t) -> (UnsafePointer<Int8>?) = library.load(symbol: "sourcekitd_response_error_get_description")
internal let sourcekitd_response_get_value: @convention(c) (sourcekitd_response_t) -> (sourcekitd_variant_t) = library.load(symbol: "sourcekitd_response_get_value")
internal let sourcekitd_variant_get_type: @convention(c) (sourcekitd_variant_t) -> (sourcekitd_variant_type_t) = library.load(symbol: "sourcekitd_variant_get_type")
internal let sourcekitd_variant_dictionary_get_value: @convention(c) (sourcekitd_variant_t, sourcekitd_uid_t) -> (sourcekitd_variant_t) = library.load(symbol: "sourcekitd_variant_dictionary_get_value")
internal let sourcekitd_variant_dictionary_get_string: @convention(c) (sourcekitd_variant_t, sourcekitd_uid_t) -> (UnsafePointer<Int8>?) = library.load(symbol: "sourcekitd_variant_dictionary_get_string")
internal let sourcekitd_variant_dictionary_get_int64: @convention(c) (sourcekitd_variant_t, sourcekitd_uid_t) -> (Int64) = library.load(symbol: "sourcekitd_variant_dictionary_get_int64")
internal let sourcekitd_variant_dictionary_get_bool: @convention(c) (sourcekitd_variant_t, sourcekitd_uid_t) -> (Bool) = library.load(symbol: "sourcekitd_variant_dictionary_get_bool")
internal let sourcekitd_variant_dictionary_get_uid: @convention(c) (sourcekitd_variant_t, sourcekitd_uid_t) -> (sourcekitd_uid_t?) = library.load(symbol: "sourcekitd_variant_dictionary_get_uid")
internal let sourcekitd_variant_dictionary_apply_f: @convention(c) (sourcekitd_variant_t, @escaping sourcekitd_variant_dictionary_applier_f_t, UnsafeMutableRawPointer?) -> (Bool) = library.load(symbol: "sourcekitd_variant_dictionary_apply_f")
internal let sourcekitd_variant_array_get_count: @convention(c) (sourcekitd_variant_t) -> (Int) = library.load(symbol: "sourcekitd_variant_array_get_count")
internal let sourcekitd_variant_array_get_value: @convention(c) (sourcekitd_variant_t, Int) -> (sourcekitd_variant_t) = library.load(symbol: "sourcekitd_variant_array_get_value")
internal let sourcekitd_variant_array_get_string: @convention(c) (sourcekitd_variant_t, Int) -> (UnsafePointer<Int8>?) = library.load(symbol: "sourcekitd_variant_array_get_string")
internal let sourcekitd_variant_array_get_int64: @convention(c) (sourcekitd_variant_t, Int) -> (Int64) = library.load(symbol: "sourcekitd_variant_array_get_int64")
internal let sourcekitd_variant_array_get_bool: @convention(c) (sourcekitd_variant_t, Int) -> (Bool) = library.load(symbol: "sourcekitd_variant_array_get_bool")
internal let sourcekitd_variant_array_get_uid: @convention(c) (sourcekitd_variant_t, Int) -> (sourcekitd_uid_t?) = library.load(symbol: "sourcekitd_variant_array_get_uid")
internal let sourcekitd_variant_array_apply_f: @convention(c) (sourcekitd_variant_t, @escaping sourcekitd_variant_array_applier_f_t, UnsafeMutableRawPointer?) -> (Bool) = library.load(symbol: "sourcekitd_variant_array_apply_f")
internal let sourcekitd_variant_int64_get_value: @convention(c) (sourcekitd_variant_t) -> (Int64) = library.load(symbol: "sourcekitd_variant_int64_get_value")
internal let sourcekitd_variant_bool_get_value: @convention(c) (sourcekitd_variant_t) -> (Bool) = library.load(symbol: "sourcekitd_variant_bool_get_value")
internal let sourcekitd_variant_string_get_length: @convention(c) (sourcekitd_variant_t) -> (Int) = library.load(symbol: "sourcekitd_variant_string_get_length")
internal let sourcekitd_variant_string_get_ptr: @convention(c) (sourcekitd_variant_t) -> (UnsafePointer<Int8>?) = library.load(symbol: "sourcekitd_variant_string_get_ptr")
internal let sourcekitd_variant_data_get_size: @convention(c) (sourcekitd_variant_t) -> (Int) = library.load(symbol: "sourcekitd_variant_data_get_size")
internal let sourcekitd_variant_data_get_ptr: @convention(c) (sourcekitd_variant_t) -> (UnsafeRawPointer?) = library.load(symbol: "sourcekitd_variant_data_get_ptr")
internal let sourcekitd_variant_uid_get_value: @convention(c) (sourcekitd_variant_t) -> (sourcekitd_uid_t?) = library.load(symbol: "sourcekitd_variant_uid_get_value")
internal let sourcekitd_response_description_dump: @convention(c) (sourcekitd_response_t) -> () = library.load(symbol: "sourcekitd_response_description_dump")
internal let sourcekitd_response_description_dump_filedesc: @convention(c) (sourcekitd_response_t, Int32) -> () = library.load(symbol: "sourcekitd_response_description_dump_filedesc")
internal let sourcekitd_response_description_copy: @convention(c) (sourcekitd_response_t) -> (UnsafeMutablePointer<Int8>?) = library.load(symbol: "sourcekitd_response_description_copy")
internal let sourcekitd_variant_description_dump: @convention(c) (sourcekitd_variant_t) -> () = library.load(symbol: "sourcekitd_variant_description_dump")
internal let sourcekitd_variant_description_dump_filedesc: @convention(c) (sourcekitd_variant_t, Int32) -> () = library.load(symbol: "sourcekitd_variant_description_dump_filedesc")
internal let sourcekitd_variant_description_copy: @convention(c) (sourcekitd_variant_t) -> (UnsafeMutablePointer<Int8>?) = library.load(symbol: "sourcekitd_variant_description_copy")
internal let sourcekitd_variant_json_description_copy: @convention(c) (sourcekitd_variant_t) -> (UnsafeMutablePointer<Int8>?) = library.load(symbol: "sourcekitd_variant_json_description_copy")
internal let sourcekitd_send_request_sync: @convention(c) (sourcekitd_object_t) -> (sourcekitd_response_t?) = library.load(symbol: "sourcekitd_send_request_sync")
internal let sourcekitd_send_request: @convention(c) (sourcekitd_object_t, UnsafeMutablePointer<sourcekitd_request_handle_t?>?, sourcekitd_response_receiver_t?) -> () = library.load(symbol: "sourcekitd_send_request")
internal let sourcekitd_cancel_request: @convention(c) (sourcekitd_request_handle_t?) -> () = library.load(symbol: "sourcekitd_cancel_request")
internal let sourcekitd_set_notification_handler: @convention(c) (sourcekitd_response_receiver_t?) -> () = library.load(symbol: "sourcekitd_set_notification_handler")
internal let sourcekitd_set_uid_handler: @convention(c) (sourcekitd_uid_handler_t?) -> () = library.load(symbol: "sourcekitd_set_uid_handler")
internal let sourcekitd_set_uid_handlers: @convention(c) (sourcekitd_uid_from_str_handler_t?, sourcekitd_str_from_uid_handler_t?) -> () = library.load(symbol: "sourcekitd_set_uid_handlers")
