//
//  FileManager.h
//  WoWiLLIDANtASK
//
//  Created by Uladzislau Abramchuk on 20.02.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject
+(void)writeStarShipsToJSON: (NSArray *)array;
+(NSMutableArray *)readFromJSON;
+(BOOL)isFileExist;

@end
