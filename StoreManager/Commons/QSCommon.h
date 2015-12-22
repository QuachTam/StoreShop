//
//  DISCommon.h
//  iOSUtility
//
//  Created by QuangPC on 2/19/14.
//  Copyright (c) 2014 DIS. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *kNewLineString;
extern NSString *kEmptyString;

extern NSString *MonthDayYearDisplayedFormat;
extern NSString *MonthDayDisplayedFormat;
extern NSString *MonthYearDisplayedFormat;

extern NSString *YearMonthDayDBLocalFormat;
extern NSString *YearMonthDBLocalFormat;
extern NSString *MonthDayDBLocalFormat;

@interface QSCommon : NSObject
+ (NSString *)genRandStringLength:(int)len;

+ (NSString *)genFixedRandStringLength:(int)len;

+ (int)genRandIntWithMax:(int)max;

+ (NSDate *)genRandDate;

+ (BOOL)genRandBOOL;

+ (id)randomValueFromArray:(NSArray *)array;

+ (NSAttributedString *)attributeStringFromString:(NSString *)string
                                        boldRange:(NSRange)boldRange
                                         boldFont:(UIFont *)boldFont;

+ (void)setBoldForTextInLabel:(UILabel *)label
                    withRange:(NSRange)range
                  andBoldFont:(UIFont *)boldFont;

+ (UIBarButtonItem *)barButtonItemFromImage:(NSString *)imageName
                                 withTarget:(id)target
                                  andAction:(SEL)action;

+ (NSDate *)dateObjectFromUTCString:(NSString *)UTCString;
+ (NSDate *)dateObjectFromLocalTimeString:(NSString *)localTimeString
                               withFormat:(NSString *)dateFormat;

+ (NSString *)convertToUTCTimeZone:(NSString *)localTime
                   withLocalFormat:(NSString *)localTimeFormat
                      andUTCFormat:(NSString *)UTCTimeFormat;

+ (NSString *)convertToLocalTimeZone:(NSString *)UTCTime
                       withUTCFormat:(NSString *)timeFormat
                      andLocalFormat:(NSString *)localTimeFormat;

+ (NSString *)convertToLocalTimeZoneFromUTCDateTime:(NSDate *)UTCDateTime
                                    withLocalFormat:(NSString *)localTimeFormat;

+ (NSString *)localDateStringFromDateObject:(NSDate *)dateObject
                                 withFormat:(NSString *)formatString;

+ (NSString *)UTCDateStringFromDateObject:(NSDate *)dateObject;

+ (CGFloat )radiansToDegrees:(CGFloat )radians;

+ (CGFloat)degreesToRadians:(CGFloat )degrees;

+ (double)getDistanceBetweenTwoPoints:(CGPoint )p1
                             andPoint:(CGPoint )p2;

+ (BOOL)pointIsInCircle:(CGPoint)pointForCheck
            centerPoint:(CGPoint)center
              andRadius:(double)radius;

+ (CGPoint )calculateDerivedPosition:(CGPoint)point
                           withRange:(double)range
                          andBearing:(double)bearing;

+ (NSAttributedString *)keyValueStyleWithKey:(NSString *)key
                                       value:(NSString *)value;

+ (NSAttributedString *)keyValueStyleWithKey:(NSString *)key
                                       value:(NSString *)value
                                       color:(UIColor *)color
                                        font:(UIFont *)font;

+ (NSString *)localizedCurrenctyForValue:(double)value;

+ (NSString *)localizeCurrencyValue:(NSDecimalNumber *)value;

+ (NSString *)localizedCurrenctyForValueWithoutDollar:(double)value;

+ (NSString *)localizedCurrenctyValueWithoutDollar:(NSDecimalNumber *)value;

+ (NSString *)locationSignedDegreesFormatFromLat:(float)latitude
                                          andLon:(float)longitude;

+ (double)floatFromStringNumber:(NSString *)number;

+ (double)floatFromCurrencyString:(NSString *)currencyString;

+ (NSDecimalNumber *)decimalNumberFromCurrencyString:(NSString *)currencyString;

+ (NSInteger)integerFromIngegerString:(NSString *)integerString;

+ (UIAlertView *)showErrorAlertViewWithMessage:(NSString *)message;

+ (UIAlertView *)showErrorAlertViewWithMessage:(NSString *)message
                                      delegate:(id)delegate;

+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              cancelButton:(NSString *)cancelButton
            andOtherButton:(NSString *)otherButton;

+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              cancelButton:(NSString *)cancelButton
            andOtherButton:(NSString *)otherButton
                   withTag:(NSInteger)tag
                  delegate:(id)delegate;

+ (NSDictionary *)dictionaryFromPlistNamed:(NSString *)plistName;

+ (NSDateComponents *)dateComponentsFromDate:(NSString *)dateInStr
                           withComponentUnit:(NSCalendarUnit)flagUnit;

+ (NSDateComponents *)dateComponentsFromDateObject:(NSDate *)date
                                 withComponentUnit:(NSCalendarUnit)flagUnit;

+ (NSInteger)dayInStockFromDate:(NSString *)dateInStr;

+ (NSInteger)monthsInStockFromDate:(NSString *)dateInStr;

+ (NSInteger)yearsInStockFromDate:(NSString *)dateInStr;

+ (UILabel *)titleLabelWithString:(NSString *)title;

+ (NSString*)dateStringFromLongTime:(double)longTime
                         withFormat:(NSString*)formatString;

+ (NSAttributedString *)highlightOfString:(NSString *)highlightStr
                                 inString:(NSString *)inString;

+ (CGFloat)keyboardHeightFromNotification:(NSNotification *)notification;

+ (void)mz_presentFormSheetController:(UIViewController*)selfController
                       pushController:(UIViewController*)pushController;

+ (double)getLongTimesLocal;

+ (NSString *)stringValueWithDefaultBlank:(NSString *)inputString;

+(void)callPhoneNumberwithPhone:(NSString *)phoneNumber;
+ (NSAttributedString *)markRequiredFieldWithString:(NSString *)field;
+ (BOOL)shouldShowMessage:(NSString *)message;
+ (NSString *)adjustMessageError:(NSString *)message;
+ (NSString *)imageToNSString:(UIImage *)image;
+ (UIImage *)stringToUIImage:(NSString *)string;
@end
