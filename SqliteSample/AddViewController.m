//
//  AddViewController.m
//  SqliteSample
//
//  Created by Shelly Pritchard on 27/06/17.
//  Copyright © 2017 SPB. All rights reserved.
//

#import "AddViewController.h"
#import "DBManager.h";

@interface AddViewController () {
    DBManager *manager;
}

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    manager = [[DBManager alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onClickStoreBtn:(UIButton *)sender {
    
    if (self.txtFldName.text.length == 0 ) {
        [self.lblErrorMsg setText:@"Enter name"];
    }
    else if (self.txtFldPlacce.text.length == 0) {
        [self.lblErrorMsg setText:@"Enter place"];
    }
    else if (self.txtFldAge.text.length == 0) {
        [self.lblErrorMsg setText:@"Enter age"];
    }
    else {
        StudentEntity *student = [StudentEntity new];
        student.name = self.txtFldName.text;
        student.place = self.txtFldPlacce.text;
        student.age = self.txtFldAge.text;
        
        [manager insertStudentDetail:student];
        
    }
    
}
@end
