//
//  ViewController.m
//  SqliteSample
//
//  Created by Shelly Pritchard on 27/06/17.
//  Copyright © 2017 SPB. All rights reserved.
//

#import "ViewController.h"
#import "ShowTableViewCell.h"
#import "StudentEntity.h"
#import "DBManager.h"

@interface ViewController () {
    NSMutableArray *arrStudentDetail;
    DBManager *manager;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    manager = [[DBManager alloc] init];
    self.showTblVw.rowHeight = UITableViewAutomaticDimension;
    self.showTblVw.estimatedRowHeight = 70.0;
    self.showTblVw.allowsSelection = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getDataFromDB];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getDataFromDB {
    arrStudentDetail = [NSMutableArray arrayWithArray:[manager getStudentDetails]];
    [self.showTblVw reloadData];
}

- (IBAction)onClickAddButton:(UIButton *)sender {
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return arrStudentDetail.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    ShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DisplayCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ShowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DisplayCell"];
    }
    
    StudentEntity *student = [arrStudentDetail objectAtIndex:indexPath.row];
    
    [cell.lblName setText:student.name];
    [cell.lblAge setText:student.age];
    [cell.lblPlace setText:student.place];
    
    
    return cell;
    
}


@end
