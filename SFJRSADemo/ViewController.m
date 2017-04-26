//
//  ViewController.m
//  SFJRSADemo
//
//  Created by 沙缚柩 on 2017/4/25.
//  Copyright © 2017年 沙缚柩. All rights reserved.
//

#import "ViewController.h"
#include "HBRSAHandler.h"

@interface ViewController ()
{
    HBRSAHandler *handler_;
}
@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UILabel *encryResult;
@property (weak, nonatomic) IBOutlet UILabel *decryResult;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    NSString* private_key_string = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBALgv/syFH337KzC29KvR0p6cP+glRqjDYAQno5ifafXZjgf1EhBjZblKv+HiLAzNBOlYU1PnLuOOkZj6pg1A5HUZLpsbYa5Mwr1bUHALjXLaB3THCpZX51/b5L14erGo52Jv/j/63YljEtMm8ALmkY8S+3fPxFeY7ya+2VXMEtplAgMBAAECgYAguvauZWGpQ37zUy+7cLfa061PlYAu8TkYw+qAbqOnupdQtq4VF3S2LqBWhZiKVcxvovB70nM0oNsisjfb1xJBpyfDBFug7d+y2f8yr6aTOezoY5DBYEF3Svg9Kp9ra+vvAYX/7fh+tHCU0HOvp0z8ikZiRSWZaQ+3A2GiCIJrwQJBAPKVji89hGAMEWLJJFZaPiLBqZUwR2W/rp7Ely5ddKfjcosHhggHfOb71BnrMOm0h4S85Gx6a87n9R2To0c51q0CQQDCX6yYdt/9JGORyNSXfzMfSZyVOrMpIo77R0YwKa3UOwwLA56l2Lc4AYO10/lyAyZCKse2/5D9ZZUB7xoYEmGZAkB8MEJVPuoY/bSc3RqENrjetERsAwZaObJcx4oaC3AgTxmhwV1FmQfBfKTODBDDZE+Ijedm/ZlZmHhtBtstKJgVAkBKma/DgHRtUscIT90QHBjB3F3FhJb4pbPcyzksCQMXXmY73/LG0ktXqnUjlyy4zm6jnIm0OZgrOQ6chGkubfeZAkBMCGF2tPfEJh8XODOvlw5ADnUiq+Qe/abcpKowkiT9zP+rYT9XJAx7QxChjdwTZb6ahnJY1+ny1emEHUOs2fm8";
    
    
    NSString* public_key_string = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4L/7MhR99+yswtvSr0dKenD/oJUaow2AEJ6OYn2n12Y4H9RIQY2W5Sr/h4iwMzQTpWFNT5y7jjpGY+qYNQOR1GS6bG2GuTMK9W1BwC41y2gd0xwqWV+df2+S9eHqxqOdib/4/+t2JYxLTJvAC5pGPEvt3z8RXmO8mvtlVzBLaZQIDAQAB";

    
    HBRSAHandler* handler = [HBRSAHandler new];
    [handler importKeyWithType:KeyTypePrivate andkeyString:private_key_string];
    [handler importKeyWithType:KeyTypePublic andkeyString:public_key_string];
    
    handler_ = handler;
}

- (IBAction)encry:(id)sender {
    if(self.input.text.length > 0 ){
        NSString* result = [handler_ encryptWithPublicKey:self.input.text];
        self.encryResult.text = result;
    }
}

- (IBAction)sign:(id)sender {
    if(self.input.text.length > 0 ){
        NSString* result = [handler_ signString:self.input.text];
        self.encryResult.text = result;
    }
}


- (IBAction)decry:(id)sender {
    if(self.encryResult.text.length > 0 ){
        NSString* result = [handler_ decryptWithPrivatecKey:self.encryResult.text];
        self.decryResult.text = result;
    }
}

- (IBAction)verify:(id)sender {
    if(self.encryResult.text.length > 0  && self.input.text.length > 0){
        BOOL result = [handler_ verifyString:self.input.text withSign:self.encryResult.text];
        self.decryResult.text = [NSString stringWithFormat:@"验证签名结果(1成功，0失败)： %d",result];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
