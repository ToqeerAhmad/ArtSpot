//
//  ApplicationHelper.m
//  Gravel
//
//  Created by Salman Nasir on 02/10/2015.
//  Copyright © 2015 RAC Application. All rights reserved.
//

#import "ApplicationHelper.h"

@implementation ApplicationHelper
{
    UIActivityIndicatorView *indicator;
    UINavigationController  *customNavigationController;
}

/*** LocationManager Initiated Start ***/

+(void)InitiatedLocationManager{
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)
    {
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [locationManager requestWhenInUseAuthorization];
        }
    }
    
    locationManager.delegate  = (id)self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
//        
//    [ApplicationHelper setValueInUserDefault:Latitude andValue:[NSString stringWithFormat:@"%f",manager.location.coordinate.latitude]];
//    [ApplicationHelper setValueInUserDefault:Longitude andValue:[NSString stringWithFormat:@"%f",manager.location.coordinate.longitude]];
   
    //NSLog(@"Delegate Called Latitude is: %f" , manager.location.coordinate.latitude);
    //NSLog(@"Delegate Called Longitude is: %f" , manager.location.coordinate.longitude);
    [manager stopUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
    [manager stopUpdatingLocation];
}

/*** LocationManager Initiated End ***/

/*** Add the blank space in text field ***/

+(void)addBlankSpaceInTextView:(UITextField *)givenTextField{
    UIView *blankView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 72)];
    givenTextField.leftView = blankView;
    givenTextField.leftViewMode = UITextFieldViewModeAlways;
}

+(CGFloat)returnFontSizeWithDynamicSize:(CGFloat)labelSize{
    
    CGFloat fontSize;
//    if (SCREEN_WIDTH == 320) {
//          fontSize =  labelSize/1.5;
//    }
//    else {
//        fontSize = [UIScreen mainScreen].bounds.size.width/414 *labelSize;
//    }
    
    fontSize = [UIScreen mainScreen].bounds.size.width/375 * labelSize;

    
    return fontSize;
}

/*** Alert Popup ***/
+(void) showAlertView:(NSString*)heading andMessage:(NSString *)message
{
    UIAlertView *alertView=[[UIAlertView alloc]
                            initWithTitle:heading
                            message:message
                            delegate:nil
                            cancelButtonTitle:@"OK"
                            otherButtonTitles: nil];
    
    
    
    
    [alertView show];
}


/** Check Null Value as String ***/
+(NSString *) checkforNullvalue:(id) stringVal
{
    
    NSString *string = [NSString stringWithFormat:@"%@",stringVal];
    
    if ([string isEqualToString:@"<null>"]||[string  isEqualToString:@"(null)"] ||[string  isEqualToString:@"0000-00-00"] || [string  isEqualToString:@""] || string.length==0 ||
        string==nil ||[string isKindOfClass:[NSNull class]] || [string isEqualToString:@"Unknown"]) {
        string =@"";
    }
    return string ;
}

/*** Validate Null Value ***/
+(BOOL)ValidateNullValue:(NSString *)stringParm
{
    NSString *string = stringParm;
    if ([string isEqualToString:@"<null>"]||[string  isEqualToString:@"(null)"] ||[string  isEqualToString:@"0000-00-00"] || [string  isEqualToString:@""] || string.length==0 ||
        string==nil ||[string isKindOfClass:[NSNull class]]) {
        return false;
    }
    return true;
}


/*** Activity Indicator ***/
-(void)AddActivityIndicator :(UIView *)targetView{
    
    indicator= [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.center = targetView.center;
    [targetView addSubview:indicator];
    [indicator bringSubviewToFront:targetView];
}
-(void)startActivityIndicator{
    [indicator startAnimating];
}
-(void)stopActivityIndicator{
    [indicator stopAnimating];
}
-(void)removeActivityIndicator:(UIImage *)imageView{
    [indicator removeFromSuperview];
}
/*** validate Email Address ***/

+(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; 
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

/*** Set Value In Ns user Default ***/

+(void)setValueInUserDefault:(NSString*)key andValue:(id)value{
    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
    
}
/*** return value against Key ***/
+(id)returnUserDefaultValue:(NSString*)key{
    
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    return [self checkforNullvalue:[defaults objectForKey:key]];
}

+(void)addUnderLineToButton:(UIButton *)viewBtn andUnderLineStyle:(NSUnderlineStyle)style{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:viewBtn.titleLabel.text
                                                                             attributes:@{NSUnderlineStyleAttributeName: @(style)}]];
    [viewBtn.titleLabel setAttributedText:attributedString];
    
}

+(BOOL)validateStringContainsAlphabetsOnly:(NSString*)strng
{
    NSCharacterSet *strCharSet = [NSCharacterSet characterSetWithCharactersInString:@"@0123456789-+"];
    
    strCharSet = [strCharSet invertedSet];
    NSRange r = [strng rangeOfCharacterFromSet:strCharSet];
    if (r.location == NSNotFound) {
        return NO;
    }
    else
        return YES;
}

// Add Back / Menu Button

+(UIButton *)rightBarButtonItem:(NSString *)btnTitle andNavigationController:(UINavigationController *)navController andnavigationItem:(UINavigationItem *)navigationItem{
    
    UIButton *Btn;
    
    Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.frame = CGRectMake(5, 0, 60, 30);
    [Btn setTitle:btnTitle forState:UIControlStateNormal];
    [Btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    Btn.contentEdgeInsets = UIEdgeInsetsMake(-4, 0, 0, -3);
    [Btn.titleLabel setFont:[UIFont fontWithName:@"ProximaNova-Semibold" size:[ApplicationHelper returnFontSizeWithDynamicSize:14.35]]];
    [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *barButton  = [[UIBarButtonItem alloc] initWithCustomView:Btn];
    navigationItem.rightBarButtonItem = barButton;
    
    
    return Btn;
}

+(UIButton *)addTheMenuButton:(UINavigationController *)navController andnavigationItem:(UINavigationItem *)navigationItem {
   
    UIButton *Btn;
    
    Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (SCREEN_WIDTH == 320) {
        Btn.frame = CGRectMake(0, 0, 27, 20);
    }else{
        Btn.frame = CGRectMake(0, 0,35,25);
    }
    
    [Btn setImage:[UIImage imageNamed:@"main-Menu-Icon"] forState:UIControlStateNormal];
    UIBarButtonItem *barButton  = [[UIBarButtonItem alloc] initWithCustomView:Btn];
    navigationItem.leftBarButtonItem = barButton;


    [navController.navigationBar setBarTintColor:[UIColor blackColor]];

    return Btn;

}

+(UIButton *)updateNavigationBar:(NSString *)headerTitle andNavigationController:(UINavigationController *)navController andnavigationItem:(UINavigationItem *)navigationItem andLeftBtnType:(NSString *)btnType{
    
    UIButton *Btn;
    
    if ([btnType isEqualToString:@"backBtn"]) {
        
        Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        Btn.frame = CGRectMake(20, 12, 30, 19);
        [Btn setImage:[UIImage imageNamed:@"Back-Button"] forState:UIControlStateNormal];
        
        UIBarButtonItem *barButton  = [[UIBarButtonItem alloc] initWithCustomView:Btn];
        navigationItem.leftBarButtonItem = barButton;
    }else {
        
        Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (SCREEN_WIDTH == 320) {
            Btn.frame = CGRectMake(0, 0, 27, 20);
        }else{
            Btn.frame = CGRectMake(0, 0,35,25);
        }
        
        [Btn setImage:[UIImage imageNamed:@"main-Menu-Icon"] forState:UIControlStateNormal];
        UIBarButtonItem *barButton  = [[UIBarButtonItem alloc] initWithCustomView:Btn];
        navigationItem.leftBarButtonItem = barButton;
    }
    
    [navController.navigationBar setBarTintColor:[UIColor blackColor]];
    
    CGFloat screenSize = [[[UIApplication sharedApplication]delegate]window].frame.size.width;
    CGFloat size;
    
    if (screenSize == 320) {
        size = 23/1.5;
    }else if(screenSize == 375){
        size = 23/1.25;
    }else {
        size = 24;
    }
    
    UILabel *title = [[UILabel alloc]init];
    title.text = headerTitle;
    title.frame = CGRectMake(106.5, 7, 201, 30);
    navigationItem.title = [NSString stringWithFormat:@"%@",title.text];
    [navController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    navController.navigationBar.translucent = NO;
  
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary    dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,  [UIFont fontWithName:@"ProximaNova-Semibold" size:size], NSFontAttributeName, nil]];
    
    return Btn;
}

+(void)updateNavigationBarTitle:(NSString *)headerTitle andNavigationController:(UINavigationController *)navController andnavigationItem:(UINavigationItem *)navigationItem {
   
    
    [navController.navigationBar setBarTintColor:[UIColor blackColor]];
    
    CGFloat screenSize = [[[UIApplication sharedApplication]delegate]window].frame.size.width;
    CGFloat size;
    
    if (screenSize == 320) {
        size = 23/1.5;
    }else if(screenSize == 375){
        size = 23/1.25;
    }else {
        size = 24;
    }
    
    UILabel *title = [[UILabel alloc]init];
    title.text = headerTitle;
    navigationItem.title = [NSString stringWithFormat:@"%@",title.text];
    [navController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    navController.navigationBar.translucent = NO;
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary    dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,  [UIFont fontWithName:@"ProximaNova-Semibold" size:size], NSFontAttributeName, nil]];
    
    
}



/*** Dynamic Cells ***/

+(CGSize)getCellHeight:(int)originalHeight OriginalWidth:(int)originalWidth
{
    float height=(originalHeight*SCREEN_WIDTH)/originalWidth;
    CGSize size=CGSizeMake(SCREEN_WIDTH,height);
    return size;
}

+(UIView *)setLabelInSection:(NSString *)labelText andTableView:(UITableView *)tableView andHeight:(CGFloat)height
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,tableView.frame.size.width,height)];
    view.backgroundColor = [UIColor colorWithRed:248/255.0 green:247/255.0 blue:250/255.0 alpha:1.0];
    UILabel *label = [[UILabel alloc] init];
    if (SCREEN_WIDTH == 320) {
        label.frame = CGRectMake(16,13,200, 18);
    }else{
        label.frame = CGRectMake(16,24,200, 18);
    }
    label.text = labelText;
    label.textColor = [UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:147.0/255.0 alpha:1.0];
    label.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14.2];
    [view addSubview:label];
    return view;
}


//.........Avoid TextField


+(void) animateTextFieldUp:(BOOL)up viewToMove:(UIView *)view DistanceToMove:(int)distance AnimationDuration:(float) duration
{
    const int movementDistance = distance;
    const float movementDuration = duration;
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    view.frame = CGRectOffset(view.frame, 0, movement);
    [UIView commitAnimations];
}


+(void)setOrientation:(int)rotate{
    
    NSNumber *value = [NSNumber numberWithInt:rotate];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

+(NSString *)getTheCurrentTime:(NSString *)dateFormat{

    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat ;
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    return [dateFormatter stringFromDate:now];
}

+(NSString *)getTheCurrentTimeIn24Format{
    
    NSDate *today = [NSDate date];
    NSLocale *twelveHourLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = twelveHourLocale;
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    return  [dateFormatter stringFromDate:today];
}

+(NSString *)getTheCurrentDay{
    
    NSDateFormatter* day = [[NSDateFormatter alloc] init];
    [day setDateFormat:@"EEEE"];
    NSString *currentDay = [NSString stringWithFormat:@"%@",[day stringFromDate:[NSDate date]]];
       
    
    return  currentDay;
}

+(BOOL)changeBoolValue:(BOOL)dayValue;
{
    dayValue =! dayValue;
    return dayValue;
}
/*** Function to get the lat and long from address ***/

+(CLLocationCoordinate2D) getLocationFromAddressString: (NSString*) addressStr {
    
    double latitude = 0, longitude = 0;
    
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
//    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
//    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
    
    
    return center;
    
}

/** Funtion To Return The Current Time Zone ***/

+(NSString *)returnTheUserCurrentTimeZone {
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    NSString *tzName = [timeZone name];
    
    return tzName;
    
}

// Get date with

+(NSString *)returnDateWithSpecificString{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *prefixDateFormatter = [[NSDateFormatter alloc] init];
    [prefixDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [prefixDateFormatter setDateFormat:@"MMMM"];
    NSString *prefixDateString = [prefixDateFormatter stringFromDate:date];
    NSDateFormatter *monthDayFormatter = [[NSDateFormatter alloc] init];
    [monthDayFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [monthDayFormatter setDateFormat:@"d"];
    int date_day = [[monthDayFormatter stringFromDate:date] intValue];
    NSString *suffix_string = @"|st|nd|rd|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|st|nd|rd|th|th|th|th|th|th|th|st";
    NSArray *suffixes = [suffix_string componentsSeparatedByString: @"|"];
    NSString *suffix = [suffixes objectAtIndex:date_day];
    NSString *dateString = [prefixDateString stringByAppendingString:suffix];
    NSLog(@"%@", dateString);

    return dateString;
}

//Set Label Lines Spacing

+(void)setLabelLineSpacing:(UILabel *)lbl andSapce:(float)spacing
{
    NSString *str = lbl.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:spacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:style
                             range:NSMakeRange(0, str.length)];
    lbl.attributedText = attributedString;
    lbl.textAlignment = NSTextAlignmentCenter;
}

+ (NSString *)lastDateOfMonth {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                   fromDate:[NSDate date]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    
    components.day = numberOfDaysInMonth;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents: components];
    NSString *fisrtDateOfMonth = [self parseDateToString:date format:@"dd"];
    return fisrtDateOfMonth;
}

+ (NSDate *)parseDate:(NSString *)inStrDate format:(NSString *)inFormat {
    
    NSDateFormatter* dtFormatter = [[NSDateFormatter alloc] init];
    [dtFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dtFormatter setDateFormat:inFormat];
    NSDate* dateOutput = [dtFormatter dateFromString:inStrDate];
    return dateOutput;
}

+ (NSString *)parseDateToString:(NSDate *)date format:(NSString *)inFormat {
    
    NSDateFormatter* dtFormatter = [[NSDateFormatter alloc] init];
    [dtFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dtFormatter setDateFormat:inFormat];
    NSString *returnDate = [dtFormatter stringFromDate:date];
    return returnDate;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(NSString *)calculateTimeBetweenCoordinates:(CLLocationCoordinate2D)startPoint andEndPoint:(CLLocationCoordinate2D)endPoint andBool:(BOOL)isDistance {
    
    NSString *strUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=false&mode=%@", startPoint.latitude, startPoint.longitude, endPoint.latitude, endPoint.longitude, @"DRIVING"];
    NSURL *url = [NSURL URLWithString:[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    if(jsonData != nil)
    {
        
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        NSMutableArray *arrDistance=[result objectForKey:@"routes"];
        if ([arrDistance count]==0) {
            NSLog(@"N.A.");
           
        }else {
            
            NSMutableArray *arrLeg=[[arrDistance objectAtIndex:0]objectForKey:@"legs"];
            NSMutableDictionary *dictleg1 = [arrLeg objectAtIndex:0];
            NSLog(@"%@",[NSString stringWithFormat:@"Estimated Time %@",[[dictleg1   objectForKey:@"duration"] objectForKey:@"text"]]);
            NSString *time = [NSString stringWithFormat:@"%@",[[dictleg1   objectForKey:@"duration"] objectForKey:@"text"]];
            NSString *distance = [NSString stringWithFormat:@"%@",[[dictleg1   objectForKey:@"distance"] objectForKey:@"text"]];
            
            if (isDistance) {
                return distance;
            }
             return time;
        }
        
    }else {
        NSLog(@"N.A.");
        return @"N.A.";
    }
    return @"";
}


@end
