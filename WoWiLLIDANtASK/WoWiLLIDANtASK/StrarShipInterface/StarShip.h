//
//  StarShip.h
//  WoWiLLIDANtASK
//
//  Created by Uladzislau Abramchuk on 18.02.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StarShip : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, copy) NSString *manufacturer;
@property (nonatomic, copy) NSString *costInCredits;
@property (nonatomic, copy) NSString *length;
@property (nonatomic, copy) NSString *maxAtmospheringSpeed;
@property (nonatomic, copy) NSString *crew;
@property (nonatomic, copy) NSString *passengers;
@property (nonatomic, copy) NSString *cargoCapacity;
@property (nonatomic, copy) NSString *consumables;
@property (nonatomic, copy) NSString *starshipClass;
+ (instancetype)fromData:(NSDictionary *)data;
- (NSDictionary *)toJSON;
@end
