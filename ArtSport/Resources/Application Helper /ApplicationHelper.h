//
//  ApplicationHelper.h
//  Gravel
//
//  Created by Salman Nasir on 02/10/2015.
//  Copyright © 2015 RAC Application. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
@interface ApplicationHelper : NSObject

+ (NSDate *)parseDate:(NSString *)inStrDate format:(NSString *)inFormat;
+ (NSString *)parseDateToString:(NSDate *)date format:(NSString *)inFormat;
+ (NSString *)lastDateOfMonth;
+(void)InitiatedLocationManager;
+(void)setOrientation:(int)rotate;
+(void)addBlankSpaceInTextView:(UITextField *)givenTextField;
+(CGFloat)returnFontSizeWithDynamicSize:(CGFloat)labelSize;
+(void) showAlertView:(NSString*)heading andMessage:(NSString *)message;
+(NSString *) checkforNullvalue:(id) stringVal;
+(BOOL)ValidateNullValue:(NSString *)stringParm;
+(BOOL) NSStringIsValidEmail:(NSString *)checkString;
+(void)setValueInUserDefault:(NSString*)key andValue:(NSString *)value;
+(NSString *)returnUserDefaultValue:(NSString*)key;
+(BOOL) validateStringContainsAlphabetsOnly:(NSString*)strng;
+(UIButton *)updateNavigationBar:(NSString *)headerTitle andNavigationController:(UINavigationController *)navController andnavigationItem:(UINavigationItem *)navigationItem andLeftBtnType:(NSString *)btnType;
+(void)setLabelLineSpacing:(UILabel *)lbl andSapce:(float)spacing;
+(CGSize)getCellHeight:(int)originalHeight OriginalWidth:(int)originalWidth;
+(UIView *)setLabelInSection:(NSString *)labelText andTableView:(UITableView *)tableView andHeight:(CGFloat)height;
+(NSString *)getTheCurrentTimeIn24Format;
+(UIButton *)rightBarButtonItem:(NSString *)btnTitle andNavigationController:(UINavigationController *)navController andnavigationItem:(UINavigationItem *)navigationItem;
+(void) animateTextFieldUp:(BOOL)up viewToMove:(UIView *)view DistanceToMove:(int)distance AnimationDuration:(float) duration;
+(void)updateNavigationBarTitle:(NSString *)headerTitle andNavigationController:(UINavigationController *)navController andnavigationItem:(UINavigationItem *)navigationItem ;
+(void)addUnderLineToButton:(UIButton *)viewBtn andUnderLineStyle:(NSUnderlineStyle)style;
+(NSString *)getTheCurrentTime:(NSString *)dateFormat;
+(NSString *)getTheCurrentDay;
+(BOOL)changeBoolValue:(BOOL)dayValue;

+(CLLocationCoordinate2D) getLocationFromAddressString: (NSString*) addressStr;

+(NSString *)returnTheUserCurrentTimeZone;

+(NSString *)returnDateWithSpecificString;
+(UIButton *)addTheMenuButton:(UINavigationController *)navController andnavigationItem:(UINavigationItem *)navigationItem ;
+(NSString *)calculateTimeBetweenCoordinates:(CLLocationCoordinate2D)startPoint andEndPoint:(CLLocationCoordinate2D)endPoint andBool:(BOOL)isDistance;
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
