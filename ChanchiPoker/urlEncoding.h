//
//  urlEncoding.h
//  Login
//
//  Created by Lambda Software Co on 3/23/14.
//  Copyright (c) 2014 Lambda Software Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncoding)
-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;
@end