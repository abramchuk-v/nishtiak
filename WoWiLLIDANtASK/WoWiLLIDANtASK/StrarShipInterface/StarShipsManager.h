//
//  StarShipsManager.h
//  WoWiLLIDANtASK
//
//  Created by Uladzislau Abramchuk on 18.02.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^completion)(NSArray *);
@interface StarShipsManager : NSObject
@property (nonatomic, copy) NSNumber *count;
@property (nonatomic, copy) NSString *next;
@property (nonatomic, copy) NSString *previous;
@property (nonatomic, strong) NSMutableArray *ships;

+ (void)getStarShips: (BOOL)isSorted : (completion) completionBlock;
//@property (nonatomic) NSArray *friends;
@end


