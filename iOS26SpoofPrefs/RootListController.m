
#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>

@interface RootListController : PSListController
@end

@implementation RootListController

- (NSArray *)specifiers {
    if (!_specifiers) {
        NSMutableArray *items = [NSMutableArray new];

        PSSpecifier *header =
        [PSSpecifier preferenceSpecifierNamed:@"iOS26Spoof"
        target:nil set:nil get:nil detail:nil
        cell:PSGroupCell edit:nil];
        [items addObject:header];

        PSSpecifier *enabled =
        [PSSpecifier preferenceSpecifierNamed:@"Enable Spoof"
        target:self set:@selector(setPreference:specifier:)
        get:@selector(getPreference:)
        detail:nil cell:PSSwitchCell edit:nil];

        [enabled setProperty:@"Enabled" forKey:@"key"];
        [enabled setProperty:@YES forKey:@"default"];
        [items addObject:enabled];

        PSSpecifier *version =
        [PSSpecifier preferenceSpecifierNamed:@"iOS Version"
        target:self set:@selector(setPreference:specifier:)
        get:@selector(getPreference:)
        detail:nil cell:PSEditTextCell edit:nil];

        [version setProperty:@"Version" forKey:@"key"];
        [version setProperty:@"26.1" forKey:@"default"];
        [items addObject:version];

        PSSpecifier *model =
        [PSSpecifier preferenceSpecifierNamed:@"Device Model"
        target:self set:@selector(setPreference:specifier:)
        get:@selector(getPreference:)
        detail:nil cell:PSEditTextCell edit:nil];

        [model setProperty:@"Model" forKey:@"key"];
        [model setProperty:@"iPhone14,6" forKey:@"default"];
        [items addObject:model];

        _specifiers = items;
    }
    return _specifiers;
}

- (id)getPreference:(PSSpecifier *)specifier {
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:
    @"/var/jb/var/mobile/Library/Preferences/com.ios26spoof.plist"];
    return prefs[specifier.properties[@"key"]] ?:
    specifier.properties[@"default"];
}

- (void)setPreference:(id)value specifier:(PSSpecifier *)specifier {
    NSString *path =
    @"/var/jb/var/mobile/Library/Preferences/com.ios26spoof.plist";

    NSMutableDictionary *prefs =
    [NSMutableDictionary dictionaryWithContentsOfFile:path] ?:
    [NSMutableDictionary new];

    prefs[specifier.properties[@"key"]] = value;
    [prefs writeToFile:path atomically:YES];
}

@end
