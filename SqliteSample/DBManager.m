//
//  DBManager.m
//  SqliteSample
//
//  Created by Shelly Pritchard on 27/06/17.
//  Copyright © 2017 SPB. All rights reserved.
//

#import "DBManager.h"

#define InsertQuery @"INSERT INTO `StudentTable` (`name`,`place`,`age`) VALUES ('%@','%@','%@')"
#define UpdateQuery @"UPDATE `StudentTable` (`name`,`place`,`age`) VALUES (%@,'%@','%@') where name = '%@'"
#define CountQuery @"Select count(name) From `StudentTable` where name = '%@'"

#define SelectQuery @"Select * From `StudentTable`"


@implementation DBManager 

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)insertStudentDetail:(StudentEntity*)student {
    NSString *strCountQuery  = [NSString stringWithFormat:CountQuery,student.name];
    if ([[DataBase sharedInstance] getCountTable:strCountQuery]) {
        [self updateStudentDetail:student];
    }
    else {
        NSString *query = [NSString stringWithFormat:InsertQuery,student.name,student.place,student.age];
        [[DataBase sharedInstance] executeQuery:query];
    }
}

- (void)updateStudentDetail:(StudentEntity*)student {
    NSString *query = [NSString stringWithFormat:UpdateQuery,student.name,student.place,student.age,student.name];
    [[DataBase sharedInstance] executeQuery:query];

}

- (NSMutableArray*)getStudentDetails {
    return [[DataBase sharedInstance] getStudentDetails:SelectQuery];
}





@end
