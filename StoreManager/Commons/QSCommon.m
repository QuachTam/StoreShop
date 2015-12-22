//
//  QSCommon.m
//  iOSUtility
//
//  Created by QuangPC on 2/19/14.
//  Copyright (c) 2014 DIS. All rights reserved.
//

#import "QSCommon.h"

NSString *kNewLineString = @"\n";
NSString *kEmptyString = @"";

NSString *MonthDayYearDisplayedFormat = @"MM/dd/yyyy";
NSString *MonthDayDisplayedFormat = @"MM/dd";
NSString *MonthYearDisplayedFormat = @"MM/yyyy";

NSString *YearMonthDayDBLocalFormat = @"yyyy/MM/dd";
NSString *YearMonthDBLocalFormat = @"yyyy/MM";
NSString *MonthDayDBLocalFormat = @"MM/dd";

static NSDateFormatter *df_utc;
static NSDateFormatter *df_local;



@implementation QSCommon
+ (NSString *)genRandStringLength:(int)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    len = rand() % len;
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

+ (NSString *)genFixedRandStringLength:(int)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

+ (int)genRandIntWithMax:(int)max {
    return arc4random() % max;
}

+ (NSString *)imageToNSString:(UIImage *)image
{
    UIImage *imageResire = [self imageResize:image andResizeTo:CGSizeMake(20, 20)];
    NSData *data = UIImageJPEGRepresentation(imageResire, 0.5);
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

+ (UIImage *)stringToUIImage:(NSString *)string
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [UIImage imageWithData:data];
}

+(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSDate *)genRandDate {
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:today];
    NSRange days = [calendar rangeOfUnit:NSDayCalendarUnit
                                  inUnit:NSMonthCalendarUnit
                                 forDate:today];
    
    int r = arc4random() % days.length;
    [dateComponents setDay:r];
    return [calendar dateFromComponents:dateComponents];
}

+ (BOOL)genRandBOOL {
    int tmp = (arc4random() % 30)+1;
    if(tmp % 5 == 0)
        return YES;
    return NO;
}

+ (id)randomValueFromArray:(NSArray *)array {
    int index = arc4random() % (array.count - 1);
    return array[index];
}

+ (NSAttributedString *)attributeStringFromString:(NSString *)string boldRange:(NSRange)boldRange boldFont:(UIFont *)boldFont {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attributeStr addAttribute:NSFontAttributeName value:boldFont range:boldRange];
    
    return [attributeStr copy];
}

+ (void)setBoldForTextInLabel:(UILabel *)label withRange:(NSRange)range andBoldFont:(UIFont *)boldFont {
    if ([label respondsToSelector:@selector(setAttributedText:)])
    {
        // iOS6 and above : Use NSAttributedStrings
        // Create the attributes
        NSDictionary *attrs = @{NSFontAttributeName: label.font};
        NSDictionary *subAttrs = @{NSFontAttributeName: boldFont};
        
        // Create the attributed string (text + attributes)
        NSMutableAttributedString *attributedText =[[NSMutableAttributedString alloc] initWithString:label.text
                                                                                          attributes:attrs];
        [attributedText setAttributes:subAttrs range:range];
        
        // Set it in our UILabel and we are done!
        [label setAttributedText:attributedText];
    } else {
        // iOS5 and below
        // Here we have some options too. The first one is to do something
        // less fancy and show it just as plain text without attributes.
        // The second is to use CoreText and get similar results with a bit
        // more of code. Interested people please look down the old answer.
        
        // Now I am just being lazy so :p
    }
}

+(void)callPhoneNumberwithPhone:(NSString *)phoneNumber {
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phoneNumber]];
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView* calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}

+ (NSDate *)dateObjectFromLocalTimeString:(NSString *)localTimeString withFormat:(NSString *)dateFormat {
    if (localTimeString.length) {
        if (!df_local) {
            df_local = [[NSDateFormatter alloc] init];
            [df_local setTimeZone:[NSTimeZone localTimeZone]];
        }
        df_local.dateFormat = dateFormat;
        
        return [df_local dateFromString:localTimeString];
    } else {
        return nil;
    }
}

+ (NSString *)localDateStringFromDateObject:(NSDate *)dateObject withFormat:(NSString *)formatString {
    if (!df_local) {
        df_local = [[NSDateFormatter alloc] init];
        [df_local setTimeZone:[NSTimeZone localTimeZone]];
    }
    df_local.dateFormat = formatString;
    return [df_local stringFromDate:dateObject];
}


+ (NSString *)convertToUTCTimeZone:(NSString *)localTime withLocalFormat:(NSString *)localTimeFormat andUTCFormat:(NSString *)UTCTimeFormat
{
    // time server format yyyy-MM-dd'T'HH:mm:ss'Z'
    NSString * UTCTime = @"";
    if (!df_utc) {
        df_utc = [[NSDateFormatter alloc] init];
        [df_utc setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    }
    [df_utc setDateFormat:UTCTimeFormat];
    
    if (!df_local) {
        df_local = [[NSDateFormatter alloc] init];
        [df_local setTimeZone:[NSTimeZone localTimeZone]];
    }
    [df_local setDateFormat:localTimeFormat];
    
    NSDate * localDate = [df_local dateFromString:localTime];
    UTCTime = [df_utc stringFromDate:localDate];
	
	return [UTCTime copy];
}

+ (NSString *)convertToLocalTimeZone:(NSString *)UTCTime withUTCFormat:(NSString *)timeFormat andLocalFormat:(NSString *)localTimeFormat
{
	NSString * localTime = @"";
    
    if (!df_utc) {
        df_utc = [[NSDateFormatter alloc] init];
        [df_utc setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    }
    [df_utc setDateFormat:timeFormat];
	
	if (!df_local) {
        df_local = [[NSDateFormatter alloc] init];
        [df_local setTimeZone:[NSTimeZone localTimeZone]];
    }
    [df_local setDateFormat:localTimeFormat];
	
	NSDate * utcDate = [df_utc dateFromString:UTCTime];
	localTime = [df_local stringFromDate:utcDate];
	
	return [localTime copy];
}

+ (NSString *)convertToLocalTimeZoneFromUTCDateTime:(NSDate *)UTCDateTime withLocalFormat:(NSString *)localTimeFormat {
    NSString * localTime = @"";
    
    if (!df_local) {
        df_local = [[NSDateFormatter alloc] init];
        [df_local setTimeZone:[NSTimeZone localTimeZone]];
    }
    [df_local setDateFormat:localTimeFormat];
    
    localTime = [df_local stringFromDate:UTCDateTime];
    
    return [localTime copy];
}

#pragma mark - Degrees
+ (CGFloat )radiansToDegrees:(CGFloat )radians
{
    return radians * 180 / M_PI;
};

+ (CGFloat)degreesToRadians:(CGFloat )degrees
{
    return degrees * M_PI / 180;
};

+ (double)getDistanceBetweenTwoPoints:(CGPoint )p1 andPoint:(CGPoint )p2 {
    double R = 6371000; // m
    double dLat = [QSCommon degreesToRadians:(p2.x - p1.x)];
    double dLon = [QSCommon degreesToRadians:(p2.y - p1.y)];
    double lat1 = [QSCommon degreesToRadians:(p1.x)];
    double lat2 = [QSCommon degreesToRadians:(p2.x)];
    
    double a = sin(dLat / 2) * sin(dLat / 2) + sin(dLon / 2)
    * sin(dLon / 2) * cos(lat1) * cos(lat2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double d = R * c;
    
    return d;
}

+ (BOOL)pointIsInCircle:(CGPoint )pointForCheck centerPoint:(CGPoint )center andRadius:(double )radius {
    if ([QSCommon getDistanceBetweenTwoPoints:pointForCheck andPoint:center] <= radius)
        return true;
    else
        return false;
}

+ (double)getLongTimesLocal{
    NSDate *date = [NSDate date];
    NSTimeInterval times = [date timeIntervalSince1970];
    return times;
}

+ (CGPoint )calculateDerivedPosition:(CGPoint )point withRange:(double )range andBearing:(double )bearing {
    double EarthRadius = 6371000; // m
    
    double latA = [QSCommon degreesToRadians:point.x];
    double lonA = [QSCommon degreesToRadians:point.y];
    double angularDistance = range / EarthRadius;
    double trueCourse = [QSCommon degreesToRadians:bearing];;
    
    double lat = asin(sin(latA) * cos(angularDistance)
                      + cos(latA) * sin(angularDistance)
                      * cos(trueCourse));
    
    double dlon = atan2(sin(trueCourse) * sin(angularDistance)
                        * cos(latA),
                        cos(angularDistance) - sin(latA) * sin(lat));
    
    double lon = fmod(lonA + dlon + M_PI, M_PI * 2) - M_PI;
    
    lat = [QSCommon radiansToDegrees:lat];
    lon = [QSCommon radiansToDegrees:lon];
    
    CGPoint newPoint = CGPointMake((float) lat, (float) lon);
    return newPoint;
}

+ (NSAttributedString *)keyValueStyleWithKey:(NSString *)key value:(NSString *)value color:(UIColor *)color font:(UIFont *)font{
    NSMutableAttributedString *result = nil;
    NSMutableArray *joinArray = [NSMutableArray array];
    if (key) {
        [joinArray addObject:key];
    }
    
    if (value) {
        [joinArray addObject:value];
    }
    
    result = [[NSMutableAttributedString alloc] initWithString:[[joinArray componentsJoinedByString:@": "] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    if (key) {
        [result addAttribute:NSForegroundColorAttributeName
                       value:color
                       range:NSMakeRange(0, key.length + 1)];
        [result addAttribute:NSFontAttributeName
                       value:font
                       range:NSMakeRange(0, key.length + 1)];
    }
    
    return [result copy];
}


+ (NSString *)decimalValue:(NSNumber*)number fractionDigits:(NSInteger)fractionDigits{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    numberFormatter.usesGroupingSeparator = NO;
    [numberFormatter setMaximumFractionDigits:fractionDigits];
    [numberFormatter setMinimumFractionDigits:0];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:number];
    return formattedNumberString;
}

+ (NSString *)localizedCurrenctyForValue:(double)value{
    NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setCurrencyCode:@"USD"];
    [numberFormatter setNegativeFormat:@"(-)¤#,##0.00"];
    [numberFormatter setMinimumFractionDigits:2];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    NSString *mString = [NSString stringWithFormat:@"%f", value];
    return [numberFormatter stringFromNumber:[[NSDecimalNumber alloc] initWithString:mString]];
}

+ (NSString *)localizeCurrencyValue:(NSDecimalNumber *)value {
    if (value) {
        NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setCurrencyCode:@"USD"];
        [numberFormatter setNegativeFormat:@"(-)¤#,##0.00"];
        [numberFormatter setMinimumFractionDigits:2];
        [numberFormatter setMaximumFractionDigits:2];
        [numberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
        NSString *mString = [value stringValue];
        return [numberFormatter stringFromNumber:[NSDecimalNumber decimalNumberWithString:mString]];
    } else {
        return nil;
    }
}

+ (NSString *)localizedCurrenctyForValueWithoutDollar:(double)value{
    NSString *valueConverted = [self localizedCurrenctyForValue:value];
    NSString *symbol = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
    return [valueConverted stringByReplacingOccurrencesOfString:symbol withString:@""];
}

+ (NSString *)localizedCurrenctyValueWithoutDollar:(NSDecimalNumber *)value{
    NSString *valueConverted = [self localizeCurrencyValue:value];
    NSString *symbol = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
    return [valueConverted stringByReplacingOccurrencesOfString:symbol withString:@""];
}

+ (double)floatFromStringNumber:(NSString *)number {
    double value;
    if (number.length) {
        value = [number doubleValue];
    } else {
        value = 0.f;
    }
    
    return value;
}

+ (double)floatFromCurrencyString:(NSString *)currencyString {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    [numberFormatter setCurrencyCode:@"USD"];
    [numberFormatter setNegativeFormat:@"(-)¤#,##0.00"];
    [numberFormatter setMinimumFractionDigits:2];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    double value = [[numberFormatter numberFromString:currencyString] doubleValue];
    return value;
}



+ (NSString *)numberRoundedFromFloat:(float)number withFractionDigits:(NSInteger)digits {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    [numberFormatter setMinimumFractionDigits:0];
    [numberFormatter setMaximumFractionDigits:digits];
    [numberFormatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    NSString *str = [numberFormatter stringFromNumber:@(number)];
    return str;
}

+ (NSInteger)integerFromIngegerString:(NSString *)integerString {
    if (integerString.length) {
        return [integerString integerValue];
    } else {
        return 0;
    }
}

+ (bool) contains: (NSString*) subString inString:(NSString *) currentString{
    NSRange range = [currentString rangeOfString:subString];
    return range.location != NSNotFound;
}

+ (NSString *)locationSignedDegreesFormatFromLat:(float)latitude andLon:(float)longitude {
    NSString *location = @"";
    int latSeconds = (int)round(ABS(latitude * 3600));
    int latDegrees = latSeconds / 3600;
    latSeconds = latSeconds % 3600;
    int latMinutes = latSeconds / 60;
    latSeconds %= 60;
    
    int longSeconds = (int)round(ABS(longitude * 3600));
    int longDegrees = longSeconds / 3600;
    longSeconds = longSeconds % 3600;
    int longMinutes = longSeconds / 60;
    longSeconds %= 60;
    
    char latDirection = (latitude > 0) ? 'N' : 'S';
    char longDirection = (longitude > 0) ? 'E' : 'W';
    
    location = [NSString stringWithFormat:@"%i°%i'%i\"%c, %i°%i'%i\"%c", longDegrees, longMinutes, longSeconds, longDirection, latDegrees, latMinutes, latSeconds, latDirection];
    return location;
}


+ (NSString *)adjustMessageError:(NSString *)message
{
    static NSArray * specialCharacter;
    if (message.length) {
        if (!specialCharacter) {
            specialCharacter = @[@".", @"!", @",", @"?"];
        }
        BOOL found = NO;
        for (NSString * object in specialCharacter) {
            if ([message hasSuffix:object]) {
                found = YES;
                break;
            }
        }
        if (!found) {
            message = [message stringByAppendingString:@"."].copy;
        }
    }
    return message;
}

+ (UIAlertView *)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton andOtherButton:(NSString *)otherButton {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButton otherButtonTitles:otherButton, nil];
    if ([self shouldShowMessage:message]) {
        [alert show];
    }
    return alert;
}

+ (UIAlertView *)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButton:(NSString *)cancelButton andOtherButton:(NSString *)otherButton withTag:(NSInteger)tag delegate:(id)delegate {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButton otherButtonTitles:otherButton, nil];
    alert.tag = tag;
    if ([self shouldShowMessage:message]) {
        [alert show];
    }
    return alert;    
}

+ (NSDictionary *)dictionaryFromPlistNamed:(NSString *)plistName {
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    return data;
}

+ (NSDateComponents *)dateComponentsFromDate:(NSString *)dateInStr withComponentUnit:(NSCalendarUnit)flagUnit{
    NSDate *date = [QSCommon dateObjectFromUTCString:dateInStr];
    NSDate *currentDate = [NSDate date];
    
    static NSCalendar *gregorianCalendar = nil;
    if (!gregorianCalendar) {
        gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    
    NSDateComponents *components = [gregorianCalendar components:flagUnit
                                                        fromDate:date
                                                          toDate:currentDate
                                                         options:0];
    return components;
}

+ (NSDateComponents *)dateComponentsFromDateObject:(NSDate *)date withComponentUnit:(NSCalendarUnit)flagUnit {
    NSDate *currentDate = [NSDate date];
    
    static NSCalendar *gregorianCalendar = nil;
    if (!gregorianCalendar) {
        gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    
    NSDateComponents *components = [gregorianCalendar components:flagUnit
                                                        fromDate:date
                                                          toDate:currentDate
                                                         options:0];
    return components;
}

+ (NSInteger)monthsInStockFromDate:(NSString *)dateInStr {
    NSDateComponents *components = [self dateComponentsFromDate:dateInStr withComponentUnit:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit];
    NSInteger months = components.month + components.year * 12;
    
    return months;
}

+ (NSInteger)dayInStockFromDate:(NSString *)dateInStr {
    NSDateComponents *components = [self dateComponentsFromDate:dateInStr withComponentUnit:NSDayCalendarUnit];
    NSInteger days = components.day;
    return days;
}

+ (NSInteger)yearsInStockFromDate:(NSString *)dateInStr {
    NSDateComponents *components = [self dateComponentsFromDate:dateInStr withComponentUnit:NSYearCalendarUnit];
    NSInteger years = components.year;
    return years;
}


+ (NSString*)dateStringFromLongTime:(double)longTime withFormat:(NSString*)formatString{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:longTime/1000];
    NSDateFormatter *format;
    if (!format) {
        format = [[NSDateFormatter alloc] init];
    }
    [format setDateFormat:formatString];
    NSString *dateString = [format stringFromDate:date];
    return dateString;
}

+ (CGFloat)keyboardHeightFromNotification:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue *keyboardFrameValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = keyboardFrameValue.CGRectValue;
    return keyboardFrame.size.height;
}

#pragma mark - return blank if nil
+ (NSString *)stringValueWithDefaultBlank:(NSString *)inputString
{
    return (inputString && inputString.length > 0) ? inputString : @"";
}

+ (NSAttributedString *)markRequiredFieldWithString:(NSString *)field{
    NSMutableAttributedString *result = nil;
    NSMutableArray *joinArray = [NSMutableArray array];
    if (field) {
        [joinArray addObject:field];
        
        result = [[NSMutableAttributedString alloc] initWithString:[[joinArray componentsJoinedByString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    }
    if (field) {
        [result addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:214.0 green:9.0/255 blue:9.0/255 alpha:1.0] range:NSMakeRange(field.length-2, 1)];
    }
    return [result copy];
}
@end
