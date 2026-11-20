#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <sys/sysctl.h>
#import <string.h>

static NSDictionary *GetPrefs(void) {
    return [NSDictionary dictionaryWithContentsOfFile:
    @"/var/mobile/Library/Preferences/com.ios26spoof.plist"];
}

static BOOL IsSpoofEnabled(void) {
    return [GetPrefs()[@"Enabled"] boolValue];
}

%hook UIDevice

- (NSString *)systemVersion {
    if (IsSpoofEnabled()) {
        NSString *version = GetPrefs()[@"Version"];
        if (version.length > 0)
            return version;
    }
    return %orig;
}

%end

%hookf(int, uname, struct utsname *buf) {
    int result = %orig;
    
    if (result == 0 && buf && IsSpoofEnabled()) {
        NSString *model = GetPrefs()[@"Model"];
        if (model.length > 0) {
            const char *machine = model.UTF8String;
            strlcpy(buf->machine, machine, sizeof(buf->machine));
        }
    }
    return result;
}

%ctor {
    @autoreleasepool {
        %init;
    }
}
