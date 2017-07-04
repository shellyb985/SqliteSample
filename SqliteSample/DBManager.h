//
//  DBManager.h
//  SqliteSample
//
//  Created by Shelly Pritchard on 27/06/17.
//  Copyright © 2017 SPB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataBase.h"
#import "StudentEntity.h"

@interface DBManager : NSObject

- (void)insertStudentDetail:(StudentEntity*)student;
- (void)updateStudentDetail:(StudentEntity*)student;
- (NSMutableArray*)getStudentDetails;

@end
