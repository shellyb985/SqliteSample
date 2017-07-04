//
//  AddViewController.h
//  SqliteSample
//
//  Created by Shelly Pritchard on 27/06/17.
//  Copyright © 2017 SPB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *txtFldName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldAge;
@property (weak, nonatomic) IBOutlet UITextField *txtFldPlacce;

@property (weak, nonatomic) IBOutlet UILabel *lblErrorMsg;

- (IBAction)onClickStoreBtn:(UIButton *)sender;
- (IBAction)onClickBackBtn:(UIButton *)sender;

@end
