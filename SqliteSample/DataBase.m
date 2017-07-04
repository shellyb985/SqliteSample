//
//  DataBase.m
//  SqliteSample
//
//  Created by Shelly Pritchard on 27/06/17.
//  Copyright © 2017 SPB. All rights reserved.
//

#import "DataBase.h"
#import "StudentEntity.h"

#define Sqlite_NAME @"Sample.sqlite"


#define SAFE_CONVERSION_TEXT_FROM_DB_TO_OBJECT(_objectVal, _dbVal) { char *chars = (char *)_dbVal; if (chars == NULL) {_objectVal = nil;} else {_objectVal = [[NSString stringWithUTF8String:chars] stringByReplacingOccurrencesOfString:@"__||??||__" withString:@"'"];}}


@implementation DataBase

+ (instancetype)sharedInstance {
    static DataBase *manager = nil;
    if (!manager) {
        manager = [[DataBase alloc] initDB];
    }
    return manager;
}

- (id)initDB {
    self = [super init];
    if (self) {
        [self copyDatabaseIfNeeded:(char*)[Sqlite_NAME UTF8String]];
        const char *nDatabaseName = [dataBasePath cStringUsingEncoding:NSUTF8StringEncoding];
        int nreturnCode = sqlite3_open(nDatabaseName, &dbInstance);
    }
    return self;
}

- (void)copyDatabaseIfNeeded:(char *)sqliteDataBaseName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success;
    if (!dataBasePath) {
        dataBasePath = [self getDBPath:sqliteDataBaseName];
    }
    
    success = [fileManager fileExistsAtPath:dataBasePath];
    
    if (success) {
        //Already database copyed...
    }
    else {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%s",sqliteDataBaseName]];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dataBasePath error:&error];
        if (!success) {
            //Failed to copy database
        }
    }
}

- (NSString*)getDBPath: (char *)sqliteDataBaseName {
    
    NSString *databaseName = [[NSString alloc] initWithCString:sqliteDataBaseName encoding:NSUTF8StringEncoding];
    NSArray *paths =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *cacheDir = [paths objectAtIndex:0];
    paths = nil;
    NSString *dbPath = [[NSString alloc] initWithString:[cacheDir stringByAppendingPathComponent:databaseName]];
    cacheDir = nil;
    return dbPath;
}

- (sqlite3*)getDBInstance {
    return dbInstance;
}

- (NSInteger)getCountTable:(NSString*)strQuery {
    
    @synchronized (self) {
        
    
        sqlite3_stmt *statement = NULL;
        int returnValue = 0;
        long lastInserRowId = 0;

    const char *sqlStatement = [strQuery cStringUsingEncoding:NSUTF8StringEncoding];
        sqlite3_busy_timeout(dbInstance, 2000);
        returnValue = sqlite3_prepare_v2(dbInstance, sqlStatement, (int)strlen(sqlStatement), &statement, NULL);
        
        if(returnValue == SQLITE_OK){
            returnValue = sqlite3_step(statement);
            
            if(returnValue == SQLITE_ROW) {
                lastInserRowId = sqlite3_column_int(statement, 0);
            }
        }
        sqlite3_finalize(statement);
        statement = nil;
        return lastInserRowId;
    }
}

- (void)executeQuery:(NSString *)query {
    
    @synchronized (self) {
        sqlite3_busy_timeout(dbInstance, 2000);
        int status = sqlite3_exec(dbInstance, [query cStringUsingEncoding:NSUTF8StringEncoding], NULL, NULL, NULL);
        if (status == SQLITE_OK) {
            //query successfully executed
        }
        else {
            //query failed to executed
        }
    }
}

- (NSMutableArray*)getStudentDetails:(NSString *)strQuery {
    @synchronized (self) {
        
        
        sqlite3_stmt *statement = NULL;
        int returnValue = 0;
        
        NSMutableArray *arrAllContents	= nil;
        const char *sqlStatement = [strQuery cStringUsingEncoding:NSUTF8StringEncoding];
        returnValue = sqlite3_prepare_v2(dbInstance, sqlStatement, (int)strlen(sqlStatement), &statement, NULL);
        sqlite3_busy_timeout(dbInstance, 2000);
        if(returnValue == SQLITE_OK) {
            arrAllContents = [NSMutableArray new];
            returnValue = sqlite3_step(statement);
            
            while (returnValue == SQLITE_ROW) {
                StudentEntity *student = [StudentEntity new];
                
                SAFE_CONVERSION_TEXT_FROM_DB_TO_OBJECT(student.name,sqlite3_column_text(statement,0));
                SAFE_CONVERSION_TEXT_FROM_DB_TO_OBJECT(student.place,sqlite3_column_text(statement,1));
                SAFE_CONVERSION_TEXT_FROM_DB_TO_OBJECT(student.age,sqlite3_column_text(statement,2));
                
                [arrAllContents addObject:student];
                returnValue = sqlite3_step(statement);
            }
        }
        
        sqlite3_finalize(statement);
        return arrAllContents;
    }
}


@end
