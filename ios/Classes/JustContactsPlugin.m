#import "JustContactsPlugin.h"
#if __has_include(<just_contacts/just_contacts-Swift.h>)
#import <just_contacts/just_contacts-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "just_contacts-Swift.h"
#endif

@implementation JustContactsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftJustContactsPlugin registerWithRegistrar:registrar];
}
@end
