//
//  Tests.m
//  SeattleSensors
//
//  Created by Michael Reininger on 8/11/13.
//  Copyright (c) 2013 WINLAB. All rights reserved.
//

#import "Tests.h"
@implementation Tests
-(void)_testAppendData:(NSString *)data{
    NodeConnection *nc = [[NodeConnection alloc] init];
    [nc appendToFile:@"Test.txt" data:data];
    NSLog(@"{TEST} Appended to File");
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"Test.txt"];

    NSLog(@"{TEST} Data from file: %@", [NSString stringWithContentsOfFile:appFile]);
    

}
-(void)_testPushToSeattle:(NSString *)ip{
    NodeConnection *nc = [[NodeConnection alloc] init];
    [nc newConnection:ip];
    [nc sendRawDataFromFile:@"Test.txt"];
    [nc deleteFile:@"Test.txt"];
    NSLog(@"{TEST} Pushed to Seattle");

}
@end
