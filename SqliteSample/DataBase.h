//
//  DataBase.h
//  SqliteSample
//
//  Created by Shelly Pritchard on 27/06/17.
//  Copyright © 2017 SPB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DataBase : NSObject{
    NSString  *dataBasePath;
    sqlite3   *dbInstance;
}

+ (instancetype)sharedInstance;
- (void)executeQuery:(NSString *)query;
- (NSMutableArray*)getStudentDetails:(NSString *)strQuery;
- (NSInteger)getCountTable:(NSString*)strQuery;

@end
