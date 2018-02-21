//
//  FileManager.m
//  WoWiLLIDANtASK
//
//  Created by Uladzislau Abramchuk on 20.02.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

#import "FileManager.h"
#import "StarShip.h"

@implementation FileManager
+(void)writeStarShipsToJSON:(NSArray *)array
{
    NSMutableArray *arr = [NSMutableArray array];
    for (StarShip *shp in array) {
        [arr addObject:[shp toJSON]];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"JSON.json";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    [jsonData writeToFile:fileAtPath atomically:NO];
}

+(NSMutableArray *)readFromJSON {
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"JSON.json";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:fileAtPath];
    
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in json) {
        [arr addObject:[StarShip fromData:dict]];
    }
    return arr;
}





+(BOOL)isFileExist
{
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"JSON.json";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        return NO;
    }
    return YES;
}

@end
