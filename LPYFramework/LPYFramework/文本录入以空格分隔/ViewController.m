//
//  ViewController.m
//  testDemo
//
//  Created by admin on 16/5/20.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+Extension.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txt;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.txt.delegate = self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    NSArray *insertPosition = @[@(6), @(10), @(14), @(18)];
    [textField insertWhitSpaceInsertPosition:insertPosition replacementString:string textlength:20];
    
    return NO;
}



//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if (textField == self.txt) {
//        return [self textField:textField range:range string:string];
//    }
//    return YES;
//}

- (NSString *)parseString:(NSString*)string {
    if (!string) return nil;
    NSMutableString *mStr = [NSMutableString stringWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@""]];
    if (mStr.length > 3) {
        [mStr insertString:@" " atIndex:3];
    }if (mStr.length > 8) {
        [mStr insertString:@" " atIndex:8];
    }
    return  mStr;
}

- (BOOL)textField:(UITextField *)textField range:(NSRange)range string:(NSString *)string {
    NSString* text = textField.text;
    
    // 只能输入这个集合内的字符
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789qwertyuiopasdfghjklzxcvbnm\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    //删除
    if ([string isEqualToString:@""]){
        //删除一位
        if (range.length == 1) {
            //最后一位,遇到空格则多删除一次
            if (range.location == text.length - 1) {
                if ([text characterAtIndex:text.length-1] == ' ') {
                    [textField deleteBackward];
                }
                return YES;
            }
            //从中间删除
            else {
                NSInteger offset = range.location;
                
                if (range.location < text.length && [text characterAtIndex:range.location] == ' ' && [textField.selectedTextRange isEmpty]) {
                    [textField deleteBackward];
                    offset --;
                }
                [textField deleteBackward];
                textField.text = [self parseString:textField.text];
                UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
                return NO;
            }
        }
        else if (range.length > 1) {
            BOOL isLast = NO;
            //如果是从最后一位开始
            if(range.location + range.length == textField.text.length ){
                isLast = YES;
            }
            [textField deleteBackward];
            textField.text = [self parseString:textField.text];
            
            NSInteger offset = range.location;
            if (range.location == 3 || range.location  == 8) {
                offset ++;
            }
            if (isLast) {
                //光标直接在最后一位了
            } else {
                UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
            }
            return NO;
        }
        else {
            return YES;
        }
    }
    else if (string.length >0) {
        //限制输入字符个数
        NSString *str = [textField.text stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        str = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ((str.length + string.length - range.length > 11) ) {
            return NO;
        }
        
        [textField insertText:string];
        textField.text = [self parseString:textField.text];
        
        NSInteger offset = range.location + string.length;
        if (range.location == 3 || range.location  == 8) {
            offset ++;
        }
        UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
        textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
        return NO;
    }
    else {
        return YES;
    }
}


@end
