//
//  LocalizeHelper.h
//  DropBoxObject
//
//  Created by Quach Ngoc Tam on 11/3/15.
//  Copyright © 2015 Quach Ngoc Tam. All rights reserved.
//

#import <Foundation/Foundation.h>

// Use "LocalizedString(key)" the same way you would use "NSLocalizedString(key,comment)"
#define LocalizedString(key) [[LocalizeHelper sharedLocalSystem] localizedStringForKey:(key)]

// "language" can be (for american english): "en", "en-US", "english". Analogous for other languages.
#define LocalizationSetLanguage(language) [[LocalizeHelper sharedLocalSystem] setLanguage:(language)]

#define PUSH_NOTIFICATION_CHANGE_LANGUAGE @"pushNotificationChangeLanguage"
#define LANGUAGE_CURRENT_USE @"currentLanguageUse"

@interface LocalizeHelper : NSObject

// a singleton:
+ (LocalizeHelper*) sharedLocalSystem;

// this gets the string localized:
- (NSString*) localizedStringForKey:(NSString*) key;

//set a new language:
- (void) setLanguage:(NSString*) lang;

@end
