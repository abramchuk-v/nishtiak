//
//  StarShip.m
//  WoWiLLIDANtASK
//
//  Created by Uladzislau Abramchuk on 18.02.2018.
//  Copyright © 2018 Uladzislau Abramchuk. All rights reserved.
//

#import "StarShip.h"

@implementation StarShip
-(NSDictionary *)toJSON {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          self.name,@"name",
                          self.model,@"model",
                          self.manufacturer, @"manufacturer",
                          self.costInCredits, @"cost_in_credits",
                          self.length, @"length",
                          self.maxAtmospheringSpeed, @"max_atmosphering_speed",
                          self.crew, @"crew",
                          self.passengers, @"passengers",
                          self.cargoCapacity, @"cargo_capacity",
                          self.consumables, @"consumables",
                          self.starshipClass, @"starship_class", nil];
    return dict;
}
+ (instancetype)fromData:(NSDictionary *)data
{
    StarShip *ship = [[StarShip alloc] init];
    ship.name = data[@"name"];
    ship.model = data[@"model"];
    ship.manufacturer = data[@"manufacturer"];
    ship.costInCredits = data[@"cost_in_credits"];
    ship.length = data[@"length"];
    ship.maxAtmospheringSpeed = data[@"max_atmosphering_speed"];
    ship.crew = data[@"crew"];
    ship.passengers = data[@"passengers"];
    ship.cargoCapacity = data[@"cargo_capacity"];
    ship.consumables = data[@"consumables"];
    ship.starshipClass = data[@"starship_class"];
    return ship;
}
@end
