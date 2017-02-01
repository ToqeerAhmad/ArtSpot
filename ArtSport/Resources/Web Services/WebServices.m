    //
//  WebServices.m
//
//  Copyright (c) 2014 Rac. All rights reserved.
//


#import "WebServices.h"
#import "AFNetworking.h"
#import "JSONParser.h"

@implementation WebServices

-(void)SendRequestForData:(NSMutableDictionary *)paramsDict andServiceURL:(NSString *)serviceURL andServiceReturnType:(NSString *)returnType
{
    
   
    
    ModelLocator *model = [ModelLocator getInstance];
    NSString* url = [NSString stringWithFormat:@"%@%@", model.url, serviceURL];

    NSLog(@"%@",paramsDict);
    NSLog(@"%@",url);
    
    [self.delegate webServiceStart];
    
    AFHTTPRequestOperationManager *operation = [[AFHTTPRequestOperationManager alloc] init];
    operation.securityPolicy.validatesDomainName = NO;
    operation.securityPolicy.allowInvalidCertificates = YES;

    [operation GET:serviceURL parameters:paramsDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject
                            
                                                           options:NSJSONWritingPrettyPrinted
                            
                                                             error:&error];
        
            NSString *aStr;
            aStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"%@",aStr);
            if(responseObject != nil) {
                if (self.delegate) {
//                    JsonParser *jsonObject = [[JsonParser alloc] init];
                   // [jsonObject parseSearchArtsitResponseData:responseObject];
                    [self.delegate webServiceEnd:@"" andResponseType:returnType];
                }
            }else {
                if(self.delegate){
                    NSString *webserviceError = [responseObject objectForKey:@"errors"];
                    @try {
                        [self.delegate webServiceError:webserviceError];
                    }
                    @catch (NSException *exception) {
                        
                    }
                    @finally {
                        NSLog(@"%@",webserviceError);
                    }
                }
            }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        if(self.delegate){
            @try {
                [self.delegate webServiceError:error.localizedDescription];
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                NSLog(@"%@",error);
            }
            
        }
    }];
}


-(void)SendRequestForPostData:(NSMutableDictionary *)paramsDict andServiceURL:(NSString *)serviceURL andServiceReturnType:(NSString *)returnType
{
    
    ModelLocator *model = [ModelLocator getInstance];
    NSString  *url = [NSString stringWithFormat:@"%@%@", model.url, serviceURL];

    NSLog(@"%@",paramsDict);
    NSLog(@"%@",url);
    

    [self.delegate webServiceStart];
    AFHTTPRequestOperationManager *operation = [[AFHTTPRequestOperationManager alloc] init];
    operation.securityPolicy.validatesDomainName = NO;
    operation.securityPolicy.allowInvalidCertificates = YES;
    
    [operation POST:url parameters:paramsDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject
                            
                                                           options:NSJSONWritingPrettyPrinted
                            
                                                             error:&error];
        
        NSString *aStr;
        aStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",aStr);
        

        if([[responseObject objectForKey:@"success"] boolValue] == true) {
             JsonParser *jsonObject = [[JsonParser alloc] init];
            
            if (self.delegate) {
                if ([returnType isEqualToString:@"SearchArtsit"]) {
                   
                    [jsonObject parseSearchArtsitResponseData:[responseObject objectForKey:@"data"]];
                    
                }else if ([returnType isEqualToString:@"SignIn"]) {
                   
                    [jsonObject parseProfileData:[responseObject objectForKey:@"data"]];

                }else if ([returnType isEqualToString:@"SignUp"]) {
                    
                     [jsonObject parseProfileData:[responseObject objectForKey:@"data"]];

                }else if ([returnType isEqualToString:@"getProfile"]) {
                    
                    [jsonObject parseProfileData:[responseObject objectForKey:@"data"]];
                    
                }else if ([returnType isEqualToString:@"OwnaAtists"]) {
                    
                    [jsonObject praseOwnaAtistsData:[responseObject objectForKey:@"data"]];
                    
                }else if ([returnType isEqualToString:@"OwnaArtworks"]) {
                    
                    [jsonObject praseOwnaArtWorkData:[responseObject objectForKey:@"data"]];
                    
                }else if ([returnType isEqualToString:@"ArtistDetail"]) {
                    
                    [jsonObject parseArtistDetailData:[responseObject objectForKey:@"data"]];
                    
                }else if ([returnType isEqualToString:@"ArtworkDetail"]) {
                    
                    [jsonObject parseArtWorkDetail:[responseObject objectForKey:@"data"]];
                    
                }else if ([returnType isEqualToString:@"RelatedArtists"]) {
                    
                    [jsonObject parseRelatedArtistData:[responseObject objectForKey:@"data"]];
                    
                }else if ([returnType isEqualToString:@"ArtworksFromArtists"]) {
                    
                    [jsonObject parseRelatedArtworkData:[responseObject objectForKey:@"data"]];
                }else if ([returnType isEqualToString:@"GetBooks"]) {
                    
                    [jsonObject parseBookArray:[responseObject objectForKey:@"data"]];
                    
                }else if ([returnType isEqualToString:@"GetBookDetail"]) {
                    [jsonObject parseBookDetail:[responseObject objectForKey:@"data"]];
                }
                
                [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:true];

                 [self.delegate webServiceEnd:@"" andResponseType:returnType];
            }
        }else {
            [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:true];

            if(self.delegate){
                NSString *webserviceError = [responseObject objectForKey:@"msg"];
                @try {
                    [self.delegate webServiceError:webserviceError];
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    NSLog(@"%@",webserviceError);
                }
            }
        }

    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:true];

        if(self.delegate){
            @try {
                [self.delegate webServiceError:error.localizedDescription];
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                NSLog(@"%@",error);
            }
        }
    }];
}


@end
