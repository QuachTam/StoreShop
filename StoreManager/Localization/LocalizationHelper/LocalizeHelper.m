//
//  LocalizeHelper.m
//  DropBoxObject
//
//  Created by Quach Ngoc Tam on 11/3/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import "LocalizeHelper.h"

static LocalizeHelper* SingleLocalSystem = nil;
static NSBundle* myBundle = nil;

@implementation LocalizeHelper

+ (LocalizeHelper*) sharedLocalSystem {
    // lazy instantiation
    if (SingleLocalSystem == nil) {
        SingleLocalSystem = [[LocalizeHelper alloc] init];
    }
    return SingleLocalSystem;
}

- (id) init {
    self = [super init];
    if (self) {
        myBundle = [NSBundle mainBundle];
    }
    return self;
}

- (NSString*) localizedStringForKey:(NSString*) key {
    return [myBundle localizedStringForKey:key value:@"" table:nil];
}
// LocalizationSetLanguage(@"German") or LocalizationSetLanguage(@"de");
- (void) setLanguage:(NSString*) lang {
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj" ];
    if (path == nil) {
        myBundle = [NSBundle mainBundle];
    } else {
        myBundle = [NSBundle bundleWithPath:path];
        if (myBundle == nil) {
            myBundle = [NSBundle mainBundle];
        }
    }
}

@end
