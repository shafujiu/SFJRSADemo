//
//  DESViewController.m
//  SFJRSADemo
//
//  Created by 沙缚柩 on 2017/4/25.
//  Copyright © 2017年 沙缚柩. All rights reserved.
//

#import "DESViewController.h"
#import "DESEncrypt.h"


@interface DESViewController ()
@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UILabel *encryResult;
@property (weak, nonatomic) IBOutlet UILabel *decryResult;
@end

@implementation DESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (IBAction)encry:(id)sender {
    if (_input.text.length > 0 && _password.text.length > 0) {
        _encryResult.text = [DESEncrypt encryptUseDES:_input.text key:_password.text];
    }
}

- (IBAction)decry:(id)sender {
    if(_encryResult.text.length > 0 && _password.text.length > 0 ){
        _decryResult.text = [DESEncrypt decryptUseDES:_encryResult.text key:_password.text];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
